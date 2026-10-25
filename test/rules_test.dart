import 'package:flutter_test/flutter_test.dart';
import 'package:invoxa/core/invoicing/enums.dart';
import 'package:invoxa/core/invoicing/invoice_rules.dart';
import 'package:invoxa/core/messaging/messages.dart';
import 'package:invoxa/core/reports/figures.dart';

void main() {
  test('numbers include the year and stay padded', () {
    expect(
      formatDocumentNumber(prefix: 'inv', year: 2026, sequence: 1),
      'INV-2026-0001',
    );
    expect(() => formatDocumentNumber(prefix: 'inv', year: 2026, sequence: 0), throwsFormatException);
  });

  test('overdue is calculated from the due date and balance', () {
    final due = DateTime(2026, 10, 1);
    expect(
      effectiveStatus(
        stored: InvoiceStatus.unpaid,
        grandMinor: 100,
        paidMinor: 0,
        dueDate: due,
        today: DateTime(2026, 10, 2),
      ),
      InvoiceStatus.overdue,
    );
    expect(
      effectiveStatus(
        stored: InvoiceStatus.unpaid,
        grandMinor: 100,
        paidMinor: 40,
        dueDate: due,
        today: DateTime(2026, 10, 2),
      ),
      InvoiceStatus.overdue,
    );
    expect(
      effectiveStatus(
        stored: InvoiceStatus.unpaid,
        grandMinor: 100,
        paidMinor: 40,
        dueDate: due,
        today: DateTime(2026, 9, 30),
      ),
      InvoiceStatus.partial,
    );
    expect(
      effectiveStatus(
        stored: InvoiceStatus.unpaid,
        grandMinor: 100,
        paidMinor: 100,
        dueDate: due,
        today: DateTime(2026, 11, 1),
      ),
      InvoiceStatus.paid,
    );
    expect(
      effectiveStatus(
        stored: InvoiceStatus.draft,
        grandMinor: 100,
        paidMinor: 0,
        dueDate: due,
        today: DateTime(2026, 12, 1),
      ),
      InvoiceStatus.draft,
    );
  });

  test('service branding is used only when every line shares it', () {
    final mixed = selectInvoiceBranding(const [
      ServiceBrandRef(serviceId: 'a', mode: BrandingMode.custom),
      ServiceBrandRef(serviceId: 'b', mode: BrandingMode.business),
    ]);
    expect(mixed.useServiceBrand, isFalse);

    final single = selectInvoiceBranding(const [
      ServiceBrandRef(serviceId: 'a', mode: BrandingMode.custom),
      ServiceBrandRef(serviceId: 'a', mode: BrandingMode.custom),
    ]);
    expect(single.useServiceBrand, isTrue);
    expect(single.serviceId, 'a');
  });

  test('different service accounts ask the user to choose', () {
    final choice = selectPaymentAccounts(
      serviceAccountIds: const ['bank-a', 'bank-b', 'bank-a'],
      businessDefaultAccountId: 'default',
    );
    expect(choice.needsChoice, isTrue);
    expect(choice.accountIds, ['bank-a', 'bank-b']);

    final single = selectPaymentAccounts(
      serviceAccountIds: const ['bank-a', null],
      businessDefaultAccountId: 'default',
    );
    expect(single.needsChoice, isFalse);
    expect(single.suggestedId, 'bank-a');
  });

  test('paid and cancelled invoices cancel reminders', () {
    expect(shouldCancelReminders(InvoiceStatus.paid), isTrue);
    expect(shouldCancelReminders(InvoiceStatus.cancelled), isTrue);
    expect(shouldCancelReminders(InvoiceStatus.overdue), isFalse);
    final planned = planReminders(
      dueDate: DateTime(2026, 10, 20),
      now: DateTime(2026, 10, 10, 8),
      beforeDue: true,
      beforeDays: 1,
      onDue: true,
      after3: true,
      after7: false,
    );
    expect(planned.map((item) => item.kind), [
      ReminderKind.beforeDue,
      ReminderKind.onDue,
      ReminderKind.after3,
    ]);
    expect(
      reminderNotificationBody(
        kind: ReminderKind.after3,
        number: 'INV-2026-0004',
        outstanding: 7500000,
        currency: 'NGN',
        dueDate: DateTime(2026, 10, 1),
      ),
      'Invoice INV-2026-0004 is overdue. ₦75,000 is still outstanding.',
    );
  });

  test('whatsapp message keeps the editable placeholders', () {
    final input = InvoiceMessageInput(
      customerName: 'Ada Bakery',
      invoiceNumber: 'INV-2026-0001',
      serviceSummary: 'Logo design',
      quantitySummary: '1 Piece',
      totalMinor: 5000000,
      outstandingMinor: 5000000,
      amountMinor: 0,
      currency: 'NGN',
      dueDateLabel: '1 Nov 2026',
      bankText: 'GTBank\nAda Stores\n0123456789',
      businessName: 'Ada Stores',
      phone: '08030000000',
      statusLabel: 'Unpaid',
      now: DateTime(2026, 10, 25, 9),
    );
    final message = renderTemplate(invoiceTemplateBody, input.placeholders);
    expect(message, contains('Good morning Ada Bakery'));
    expect(message, contains('INV-2026-0001'));
    expect(message, contains('₦50,000'));
    expect(message, contains('0123456789'));
    expect(whatsappNumber('0803 000 0000'), '2348030000000');
    expect(whatsappUri('2348030000000', 'Hello').queryParameters['text'], 'Hello');
  });

  test('empty books and other currencies stay honest', () {
    final empty = dashboardFigures(
      invoices: const [],
      payments: const [],
      lines: const [],
      currency: 'NGN',
      today: DateTime(2026, 10, 25),
    );
    expect(empty.invoicedMinor, 0);
    expect(empty.receivedMinor, 0);
    expect(buildInsights(figures: empty, invoiceCount: 0).single, contains('first invoice'));

    final figures = dashboardFigures(
      invoices: [
        LedgerInvoice(
          id: 'ngn',
          customerId: 'c',
          customerName: 'Ada',
          storedStatus: InvoiceStatus.overdue,
          issueDate: DateTime(2026, 9, 1),
          dueDate: DateTime(2026, 9, 8),
          grandMinor: 25000000,
          paidMinor: 0,
          currency: 'NGN',
          number: 'INV-2026-0002',
        ),
        LedgerInvoice(
          id: 'usd',
          customerId: 'c',
          customerName: 'Ada',
          storedStatus: InvoiceStatus.unpaid,
          issueDate: DateTime(2026, 10, 1),
          dueDate: DateTime(2026, 10, 8),
          grandMinor: 10000,
          paidMinor: 0,
          currency: 'USD',
          number: 'INV-2026-0003',
        ),
      ],
      payments: const [],
      lines: const [],
      currency: 'NGN',
      today: DateTime(2026, 10, 25),
    );
    expect(figures.invoicedMinor, 25000000);
    expect(figures.overdueMinor, 25000000);
    expect(figures.receivedMinor, 0);
    expect(figures.excludedOtherCurrency, 1);
    expect(buildInsights(figures: figures, invoiceCount: 2).first, contains('₦250,000'));
  });
}
