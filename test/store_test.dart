import 'package:drift/drift.dart' hide isNotNull, isNull;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:invoxa/core/errors.dart';
import 'package:invoxa/core/invoicing/enums.dart';
import 'package:invoxa/data/db/app_database.dart';
import 'package:invoxa/data/invoxa_store.dart';
import 'package:invoxa/data/reminder_scheduler.dart';
import 'package:invoxa/domain/models.dart';

void main() {
  driftRuntimeOptions.dontWarnAboutMultipleDatabases = true;
  late AppDatabase database;
  late RecordingScheduler scheduler;
  late InvoxaStore store;

  setUp(() async {
    database = AppDatabase(NativeDatabase.memory());
    scheduler = RecordingScheduler();
    store = InvoxaStore(
      database,
      scheduler: scheduler,
      clock: () => DateTime(2026, 10, 25, 9),
    );
    await store.saveBusiness(
      const BusinessProfile(
        id: '',
        legalName: 'Ada Stores Limited',
        tradingName: 'Ada Stores',
        phone: '08030000000',
        whatsapp: '08030000000',
        email: 'ada@example.com',
        address: '12 Market Road, Lagos',
        defaultCurrency: 'NGN',
        tin: '12345678',
      ),
    );
    await store.saveBank(
      const BankAccount(
        id: '',
        bankName: 'GTBank',
        accountName: 'Ada Stores',
        accountNumber: '0123456789',
        label: 'Main',
        isDefault: true,
        isActive: true,
      ),
    );
  });

  tearDown(() => database.close());

  Future<String> bankId() async => (await store.bankAccounts()).single.id;

  InvoiceWrite draft({
    required String bank,
    String? serviceId,
    String name = 'Logo design',
    int price = 5000000,
    int quantity = 1000,
    bool issue = true,
    String? bankAccountId,
    BrandingMode mode = BrandingMode.business,
    int discount = 0,
    int tax = 0,
    int charges = 0,
    String customer = 'Kemi Foods',
    String? id,
  }) {
    return InvoiceWrite(
      id: id,
      issue: issue,
      saveCustomer: true,
      customerName: customer,
      customerPhone: '08020000000',
      lines: [
        InvoiceLineInput(
          serviceId: serviceId,
          name: name,
          description: 'A' * 80,
          quantityMilli: quantity,
          unit: UnitType.piece.storage,
          unitPriceMinor: price,
          brandingMode: mode,
          bankAccountId: bank,
        ),
      ],
      discountMinor: discount,
      taxRateBps: tax,
      chargesMinor: charges,
      currency: 'NGN',
      bankAccountId: bankAccountId,
      issueDate: DateTime(2026, 10, 25),
      dueDate: DateTime(2026, 10, 20),
      terms: TermsPreset.days7,
      paymentInstructions: 'Pay into the account below.',
    );
  }

  test('numbering survives edits and does not reuse after cancel', () async {
    final bank = await bankId();
    final first = await store.saveInvoice(draft(bank: bank));
    expect(first.number, 'INV-2026-0001');
    final edited = await store.saveInvoice(
      draft(bank: bank, id: first.id, price: 6000000, customer: 'Kemi Foods'),
    );
    expect(edited.number, 'INV-2026-0001');
    expect(edited.grandMinor, 6000000);
    await store.cancelInvoice(first.id);
    final third = await store.saveInvoice(draft(bank: bank, customer: 'Next Client'));
    expect(third.number, 'INV-2026-0002');
    expect(() => store.deleteDraft(first.id), throwsA(isA<InvoxaException>()));
  });

  test('drafts can be deleted and duplicates do not copy the number', () async {
    final bank = await bankId();
    final saved = await store.saveInvoice(draft(bank: bank, issue: false));
    expect(saved.number, isNull);
    expect(saved.status, InvoiceStatus.draft);
    final copy = await store.duplicateInvoice(saved.id);
    expect(copy.id, isNot(saved.id));
    expect(copy.number, isNull);
    await store.deleteDraft(saved.id);
    expect(store.listInvoices(), completion(hasLength(1)));
  });

  test('payments, overpayment, and duplicate submits', () async {
    final bank = await bankId();
    final invoice = await store.saveInvoice(draft(bank: bank, price: 1000000));
    final partial = await store.recordPayment(
      invoiceId: invoice.id,
      amountMinor: 400000,
      paidAt: DateTime(2026, 10, 25),
      method: PaymentMethod.bankTransfer,
      idempotencyKey: 'pay-1',
      bankAccountId: bank,
      reference: 'TRF-1',
    );
    expect(partial.fullyPaid, isFalse);
    expect(partial.receipt.marker, ReceiptMarker.partPayment);
    final again = await store.recordPayment(
      invoiceId: invoice.id,
      amountMinor: 400000,
      paidAt: DateTime(2026, 10, 25),
      method: PaymentMethod.bankTransfer,
      idempotencyKey: 'pay-1',
    );
    expect(again.payment.id, partial.payment.id);
    expect(await store.listPayments(), hasLength(1));
    expect(
      store.recordPayment(
        invoiceId: invoice.id,
        amountMinor: 700000,
        paidAt: DateTime(2026, 10, 25),
        method: PaymentMethod.cash,
        idempotencyKey: 'pay-2',
      ),
      throwsA(isA<InvoxaException>()),
    );
    final full = await store.recordPayment(
      invoiceId: invoice.id,
      amountMinor: 600000,
      paidAt: DateTime(2026, 10, 26),
      method: PaymentMethod.cash,
      idempotencyKey: 'pay-3',
    );
    expect(full.fullyPaid, isTrue);
    expect(full.receipt.marker, ReceiptMarker.paid);
    final detail = await store.invoice(invoice.id);
    expect(detail.status, InvoiceStatus.paid);
    expect(detail.settledAt, isNotNull);
    expect(detail.reminders.where((item) => item.status == ReminderStatus.scheduled), isEmpty);
    expect(scheduler.cancelled, isNotEmpty);
  });

  test('a service bank is selected and mixed accounts must be chosen', () async {
    final bank = await bankId();
    await store.saveBank(
      const BankAccount(
        id: 'second',
        bankName: 'Access',
        accountName: 'Ada Stores',
        accountNumber: '999',
        isDefault: false,
        isActive: true,
      ),
    );
    await store.saveService(
      ServiceItem(
        id: '',
        name: 'Photography',
        description: 'Event coverage',
        category: 'Creative',
        defaultPriceMinor: 7500000,
        unit: 'session',
        currency: 'NGN',
        bankAccountId: 'second',
        isActive: true,
        brandingMode: BrandingMode.custom,
        brand: const BrandProfile(
          id: '',
          ownerType: 'service',
          ownerId: '',
          primaryColor: '#111827',
          secondaryColor: '#0E8F62',
          accentColor: '#C4841D',
          template: InvoiceTemplate.premium,
          tradingName: 'Ada Lens',
          contactPhone: '08011111111',
        ),
      ),
    );
    final service = (await store.services()).single;
    final invoice = await store.saveInvoice(
      draft(bank: 'second', serviceId: service.id, mode: BrandingMode.custom, name: 'Photography', price: 7500000),
    );
    expect(invoice.bankAccountId, 'second');
    expect(invoice.brandSnapshot?['tradingName'], 'Ada Lens');
    expect(invoice.template, InvoiceTemplate.premium);

    await store.saveService(
      ServiceItem(
        id: '',
        name: 'Printing',
        description: '',
        category: 'Print',
        defaultPriceMinor: 100000,
        unit: 'piece',
        currency: 'NGN',
        bankAccountId: bank,
        isActive: true,
        brandingMode: BrandingMode.business,
      ),
    );
    final printing = (await store.services()).firstWhere((item) => item.name == 'Printing');
    final mixed = draft(bank: bank, name: 'Printing');
    expect(
      store.saveInvoice(
        InvoiceWrite(
          issue: true,
          saveCustomer: true,
          customerName: 'Kemi Foods',
          customerPhone: '08020000000',
          lines: [
            ...mixed.lines,
            InvoiceLineInput(
              serviceId: service.id,
              name: 'Photography',
              quantityMilli: 1000,
              unit: 'session',
              unitPriceMinor: 1000,
              brandingMode: BrandingMode.custom,
              bankAccountId: 'second',
            ),
            InvoiceLineInput(
              serviceId: printing.id,
              name: 'Printing',
              quantityMilli: 1000,
              unit: 'piece',
              unitPriceMinor: 1000,
              bankAccountId: bank,
            ),
          ],
          currency: 'NGN',
          issueDate: DateTime(2026, 10, 25),
          dueDate: DateTime(2026, 11, 1),
          terms: TermsPreset.days7,
          paymentInstructions: 'Choose an account.',
        ),
      ),
      throwsA(isA<InvoxaException>()),
    );
  });

  test('long names, large amounts, empty totals, backup and restore', () async {
    final empty = InvoxaStore(AppDatabase(NativeDatabase.memory()), clock: () => DateTime(2026, 10, 25));
    final dashboard = await empty.dashboard();
    expect(dashboard.invoicedMinor, 0);
    expect(dashboard.receivedMinor, 0);
    await empty.db.close();

    final bank = await bankId();
    final longName = 'N' * 300;
    final invoice = await store.saveInvoice(
      draft(bank: bank, customer: longName, price: 99999999999, quantity: 2000, discount: 100, tax: 750, charges: 50),
    );
    expect(invoice.customerName, longName);
    expect(invoice.grandMinor, greaterThan(100000000000));
    final bytes = await store.exportBackup(password: 'secret');
    expect(
      store.restoreBackup(bytes, password: 'nope'),
      throwsA(isA<InvoxaException>()),
    );
    expect((await store.listInvoices()).single.customerName, longName);
    await store.clearAll();
    expect(await store.business(), isNull);
    await store.restoreBackup(bytes, password: 'secret');
    final restored = await store.listInvoices();
    expect(restored.single.customerName, longName);
    expect(restored.single.grandMinor, invoice.grandMinor);
    expect((await store.loadSettings()).pinEnabled, isFalse);
  });

  test('csv import creates an issued invoice', () async {
    const csv = '''
customer,grand,issue_date,due_date,phone,service
"Tunde, and Co","₦15,000.00",2026-10-01,2026-12-01,08099999999,Catering
''';
    expect(await store.importInvoicesCsv(csv), 1);
    final invoices = await store.listInvoices();
    expect(invoices.single.customerName, 'Tunde, and Co');
    expect(invoices.single.grandMinor, 1500000);
    expect(invoices.single.status, InvoiceStatus.unpaid);
  });
}
