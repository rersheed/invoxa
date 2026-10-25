import 'dart:convert';
import 'dart:math';

import 'package:collection/collection.dart';
import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

import '../core/backup/backup_codec.dart';
import '../core/errors.dart';
import '../core/format.dart';
import '../core/invoicing/enums.dart';
import '../core/invoicing/invoice_math.dart';
import '../core/invoicing/invoice_rules.dart';
import '../core/messaging/messages.dart';
import '../core/money/money.dart';
import '../core/reports/csv_export.dart';
import '../core/reports/figures.dart';
import '../domain/models.dart';
import 'db/app_database.dart';
import 'reminder_scheduler.dart';

class InvoxaStore {
  InvoxaStore(
    this.db, {
    ReminderScheduler? scheduler,
    Uuid? uuid,
    DateTime Function()? clock,
    BackupCodec? backupCodec,
  }) : scheduler = scheduler ?? NoopReminderScheduler(),
       _uuid = uuid ?? const Uuid(),
       _clock = clock ?? DateTime.now,
       _backup = backupCodec ?? BackupCodec(),
       _random = Random() {
    driftRuntimeOptions.defaultSerializer = const ValueSerializer.defaults(
      serializeDateTimeValuesAsString: true,
    );
  }

  final AppDatabase db;
  final ReminderScheduler scheduler;
  final Uuid _uuid;
  final DateTime Function() _clock;
  final BackupCodec _backup;
  final Random _random;

  String _id() => _uuid.v4();
  DateTime get _now => _clock();

  Future<void> ensureDefaults() async {
    final existing = await (db.select(db.appSettings)..where((row) => row.id.equals('app'))).getSingleOrNull();
    if (existing == null) {
      final now = _now;
      await db.into(db.appSettings).insert(
        AppSettingsCompanion.insert(
          id: 'app',
          defaultPaymentInstructions: const Value(defaultPaymentInstructions),
          createdAt: now,
          updatedAt: now,
        ),
      );
    }
    final templates = await db.select(db.messageTemplates).get();
    if (templates.isEmpty) {
      final now = _now;
      await db.into(db.messageTemplates).insert(
        MessageTemplatesCompanion.insert(
          id: 'tpl-invoice',
          type: TemplateType.invoice.storage,
          name: 'Invoice',
          body: invoiceTemplateBody.trim(),
          isDefault: const Value(true),
          updatedAt: now,
        ),
      );
      await db.into(db.messageTemplates).insert(
        MessageTemplatesCompanion.insert(
          id: 'tpl-reminder',
          type: TemplateType.reminder.storage,
          name: 'Payment reminder',
          body: reminderTemplateBody.trim(),
          isDefault: const Value(true),
          updatedAt: now,
        ),
      );
      await db.into(db.messageTemplates).insert(
        MessageTemplatesCompanion.insert(
          id: 'tpl-confirmation',
          type: TemplateType.confirmation.storage,
          name: 'Payment confirmation',
          body: confirmationTemplateBody.trim(),
          isDefault: const Value(true),
          updatedAt: now,
        ),
      );
    }
  }

  Future<AppSettingRow> _settingsRow() async {
    await ensureDefaults();
    return (db.select(db.appSettings)..where((row) => row.id.equals('app'))).getSingle();
  }

  Future<AppSettingsData> loadSettings() async => _mapSettings(await _settingsRow());

  Future<void> saveSettings(AppSettingsData data) async {
    final current = await _settingsRow();
    if (data.nextInvoiceSequence < 1 || data.nextReceiptSequence < 1) {
      throw InvoxaException('The next number must be 1 or more.');
    }
    if (data.nextInvoiceSequence < current.nextInvoiceSequence ||
        data.nextReceiptSequence < current.nextReceiptSequence) {
      throw InvoxaException('Numbers are never reused, so the next number cannot go backwards.');
    }
    if (data.paymentMethods.isEmpty) {
      throw InvoxaException('Keep at least one payment method.');
    }
    formatDocumentNumber(
      prefix: data.invoicePrefix,
      year: _now.year,
      sequence: data.nextInvoiceSequence,
      padding: data.numberPadding,
    );
    await (db.update(db.appSettings)..where((row) => row.id.equals('app'))).write(
      AppSettingsCompanion(
        onboardingComplete: Value(data.onboardingComplete),
        invoicePrefix: Value(data.invoicePrefix.trim().toUpperCase()),
        nextInvoiceSequence: Value(data.nextInvoiceSequence),
        receiptPrefix: Value(data.receiptPrefix.trim().toUpperCase()),
        nextReceiptSequence: Value(data.nextReceiptSequence),
        numberPadding: Value(data.numberPadding),
        defaultCurrency: Value(data.defaultCurrency),
        taxEnabled: Value(data.taxEnabled),
        defaultTaxRateBps: Value(data.defaultTaxRateBps),
        defaultTermsPreset: Value(data.defaultTermsPreset.storage),
        defaultDueDays: Value(data.defaultDueDays),
        defaultNotes: Value(data.defaultNotes),
        defaultPaymentInstructions: Value(data.defaultPaymentInstructions),
        notificationsEnabled: Value(data.notificationsEnabled),
        remindBeforeDays: Value(data.remindBeforeDays),
        remindOnDue: Value(data.remindOnDue),
        remindAfter3: Value(data.remindAfter3),
        remindAfter7: Value(data.remindAfter7),
        pinEnabled: Value(data.pinEnabled),
        biometricEnabled: Value(data.biometricEnabled),
        autoLockSeconds: Value(data.autoLockSeconds),
        protectSensitive: Value(data.protectSensitive),
        themeMode: Value(data.themeMode.name),
        paymentMethods: Value(data.paymentMethods.map((method) => method.storage).join(',')),
        insightEnabled: Value(data.insightEnabled),
        updatedAt: Value(_now),
      ),
    );
  }

  Future<BusinessProfile?> business() async {
    final row = await (db.select(db.businesses)..limit(1)).getSingleOrNull();
    return row == null ? null : _mapBusiness(row);
  }

  Future<BusinessRow> _requireBusiness() async {
    final row = await (db.select(db.businesses)..limit(1)).getSingleOrNull();
    if (row == null) throw InvoxaException('Add your business profile first.');
    return row;
  }

  Future<void> saveBusiness(BusinessProfile profile) async {
    if (profile.legalName.trim().isEmpty) throw InvoxaException('Enter the business name.');
    if (profile.phone.trim().isEmpty) throw InvoxaException('Enter a phone number.');
    final now = _now;
    final existing = await (db.select(db.businesses)..limit(1)).getSingleOrNull();
    final id = existing?.id ?? (profile.id.isEmpty ? _id() : profile.id);
    final companion = BusinessesCompanion(
      id: Value(id),
      legalName: Value(profile.legalName.trim()),
      tradingName: Value(_blank(profile.tradingName)),
      phone: Value(profile.phone.trim()),
      whatsapp: Value(profile.whatsapp.trim().isEmpty ? profile.phone.trim() : profile.whatsapp.trim()),
      email: Value(profile.email.trim()),
      address: Value(profile.address.trim()),
      website: Value(_blank(profile.website)),
      registrationNumber: Value(_blank(profile.registrationNumber)),
      tin: Value(_blank(profile.tin)),
      description: Value(_blank(profile.description)),
      defaultCurrency: Value(profile.defaultCurrency),
      updatedAt: Value(now),
      createdAt: Value(existing?.createdAt ?? now),
    );
    if (existing == null) {
      await db.into(db.businesses).insert(companion);
      final settings = await loadSettings();
      await saveSettings(
        AppSettingsData(
          onboardingComplete: settings.onboardingComplete,
          invoicePrefix: settings.invoicePrefix,
          nextInvoiceSequence: settings.nextInvoiceSequence,
          receiptPrefix: settings.receiptPrefix,
          nextReceiptSequence: settings.nextReceiptSequence,
          numberPadding: settings.numberPadding,
          defaultCurrency: profile.defaultCurrency,
          taxEnabled: settings.taxEnabled,
          defaultTaxRateBps: settings.defaultTaxRateBps,
          defaultTermsPreset: settings.defaultTermsPreset,
          defaultDueDays: settings.defaultDueDays,
          defaultNotes: settings.defaultNotes,
          defaultPaymentInstructions: settings.defaultPaymentInstructions,
          notificationsEnabled: settings.notificationsEnabled,
          remindBeforeDays: settings.remindBeforeDays,
          remindOnDue: settings.remindOnDue,
          remindAfter3: settings.remindAfter3,
          remindAfter7: settings.remindAfter7,
          pinEnabled: settings.pinEnabled,
          biometricEnabled: settings.biometricEnabled,
          autoLockSeconds: settings.autoLockSeconds,
          protectSensitive: settings.protectSensitive,
          lastBackupAt: settings.lastBackupAt,
          themeMode: settings.themeMode,
          paymentMethods: settings.paymentMethods,
          insightEnabled: settings.insightEnabled,
        ),
      );
    } else {
      await (db.update(db.businesses)..where((row) => row.id.equals(id))).write(companion);
    }
    final brand = await brandFor(ownerType: 'business', ownerId: id);
    if (brand == null) {
      await saveBrand(
        BrandProfile(
          id: _id(),
          ownerType: 'business',
          ownerId: id,
          primaryColor: '#1B2A4A',
          secondaryColor: '#243B67',
          accentColor: '#0E8F62',
          template: InvoiceTemplate.corporate,
        ),
      );
    }
  }

  Future<BrandProfile?> brandFor({required String ownerType, required String ownerId}) async {
    final row = await (db.select(db.brandProfiles)..where(
      (table) => table.ownerType.equals(ownerType) & table.ownerId.equals(ownerId),
    )).getSingleOrNull();
    return row == null ? null : _mapBrand(row);
  }

  Future<void> saveBrand(BrandProfile brand) async {
    final now = _now;
    final existing = await (db.select(db.brandProfiles)..where(
      (table) => table.ownerType.equals(brand.ownerType) & table.ownerId.equals(brand.ownerId),
    )).getSingleOrNull();
    final companion = BrandProfilesCompanion(
      id: Value(existing?.id ?? (brand.id.isEmpty ? _id() : brand.id)),
      ownerType: Value(brand.ownerType),
      ownerId: Value(brand.ownerId),
      logoBytes: Value(brand.logoBytes),
      signatureBytes: Value(brand.signatureBytes),
      primaryColor: Value(brand.primaryColor),
      secondaryColor: Value(brand.secondaryColor),
      accentColor: Value(brand.accentColor),
      tagline: Value(_blank(brand.tagline)),
      footer: Value(_blank(brand.footer)),
      template: Value(brand.template.storage),
      tradingName: Value(_blank(brand.tradingName)),
      contactPhone: Value(_blank(brand.contactPhone)),
      contactWhatsapp: Value(_blank(brand.contactWhatsapp)),
      contactEmail: Value(_blank(brand.contactEmail)),
      contactAddress: Value(_blank(brand.contactAddress)),
      createdAt: Value(existing?.createdAt ?? now),
      updatedAt: Value(now),
    );
    if (existing == null) {
      await db.into(db.brandProfiles).insert(companion);
    } else {
      await (db.update(db.brandProfiles)..where((row) => row.id.equals(existing.id))).write(companion);
    }
  }

  Future<List<BankAccount>> bankAccounts({bool activeOnly = false}) async {
    final rows = await (db.select(db.bankAccounts)..orderBy([(row) => OrderingTerm.desc(row.isDefault)])).get();
    return [
      for (final row in rows)
        if (!activeOnly || row.isActive) _mapBank(row),
    ];
  }

  Future<void> saveBank(BankAccount account) async {
    final business = await _requireBusiness();
    if (account.bankName.trim().isEmpty || account.accountName.trim().isEmpty || account.accountNumber.trim().isEmpty) {
      throw InvoxaException('Enter the bank, account name, and account number.');
    }
    final id = account.id.isEmpty ? _id() : account.id;
    await db.transaction(() async {
      if (account.isDefault) {
        await (db.update(db.bankAccounts)..where((row) => row.businessId.equals(business.id))).write(
          const BankAccountsCompanion(isDefault: Value(false)),
        );
      }
      final existing = await (db.select(db.bankAccounts)..where((row) => row.id.equals(id))).getSingleOrNull();
      final companion = BankAccountsCompanion(
        id: Value(id),
        businessId: Value(business.id),
        bankName: Value(account.bankName.trim()),
        accountName: Value(account.accountName.trim()),
        accountNumber: Value(account.accountNumber.trim()),
        label: Value(_blank(account.label)),
        isDefault: Value(account.isDefault),
        isActive: Value(account.isActive),
        createdAt: Value(existing?.createdAt ?? _now),
      );
      if (existing == null) {
        await db.into(db.bankAccounts).insert(companion);
      } else {
        await (db.update(db.bankAccounts)..where((row) => row.id.equals(id))).write(companion);
      }
      final defaults = await (db.select(db.bankAccounts)..where(
        (row) => row.businessId.equals(business.id) & row.isDefault.equals(true),
      )).get();
      if (defaults.isEmpty) {
        final first = await (db.select(db.bankAccounts)..where(
          (row) => row.businessId.equals(business.id),
        )).getSingleOrNull();
        if (first != null) {
          await (db.update(db.bankAccounts)..where((row) => row.id.equals(first.id))).write(
            const BankAccountsCompanion(isDefault: Value(true)),
          );
        }
      }
    });
  }

  Future<void> deleteBank(String id) async {
    final used = await (db.select(db.services)..where((row) => row.bankAccountId.equals(id))).get();
    if (used.isNotEmpty) {
      throw InvoxaException('This account is assigned to a service. Mark it inactive instead.');
    }
    await (db.delete(db.bankAccounts)..where((row) => row.id.equals(id))).go();
  }

  Future<List<ServiceItem>> services({bool activeOnly = false}) async {
    final rows = await (db.select(db.services)..orderBy([(row) => OrderingTerm.asc(row.name)])).get();
    final brands = await db.select(db.brandProfiles).get();
    return [
      for (final row in rows)
        if (!activeOnly || row.isActive)
          _mapService(row, brands.where((brand) => brand.ownerType == 'service' && brand.ownerId == row.id).firstOrNull),
    ];
  }

  Future<ServiceItem?> service(String id) async {
    final row = await (db.select(db.services)..where((table) => table.id.equals(id))).getSingleOrNull();
    if (row == null) return null;
    final brand = await brandFor(ownerType: 'service', ownerId: id);
    return _mapService(row, null, brand: brand);
  }

  Future<void> saveService(ServiceItem item) async {
    final business = await _requireBusiness();
    if (item.name.trim().isEmpty) throw InvoxaException('Enter the service name.');
    if (item.defaultPriceMinor < 0) throw InvoxaException('Price cannot be negative.');
    final id = item.id.isEmpty ? _id() : item.id;
    final existing = await (db.select(db.services)..where((row) => row.id.equals(id))).getSingleOrNull();
    final now = _now;
    final companion = ServicesCompanion(
      id: Value(id),
      businessId: Value(business.id),
      name: Value(item.name.trim()),
      description: Value(item.description.trim()),
      category: Value(item.category.trim()),
      defaultPriceMinor: Value(item.defaultPriceMinor),
      unit: Value(item.unit),
      customUnit: Value(_blank(item.customUnit)),
      currency: Value(item.currency),
      bankAccountId: Value(item.bankAccountId),
      isActive: Value(item.isActive),
      brandingMode: Value(item.brandingMode.storage),
      createdAt: Value(existing?.createdAt ?? now),
      updatedAt: Value(now),
    );
    if (existing == null) {
      await db.into(db.services).insert(companion);
    } else {
      await (db.update(db.services)..where((row) => row.id.equals(id))).write(companion);
    }
    if (item.brandingMode == BrandingMode.custom && item.brand != null) {
      await saveBrand(
        BrandProfile(
          id: item.brand!.id,
          ownerType: 'service',
          ownerId: id,
          logoBytes: item.brand!.logoBytes,
          signatureBytes: item.brand!.signatureBytes,
          primaryColor: item.brand!.primaryColor,
          secondaryColor: item.brand!.secondaryColor,
          accentColor: item.brand!.accentColor,
          tagline: item.brand!.tagline,
          footer: item.brand!.footer,
          template: item.brand!.template,
          tradingName: item.brand!.tradingName ?? item.name.trim(),
          contactPhone: item.brand!.contactPhone,
          contactWhatsapp: item.brand!.contactWhatsapp,
          contactEmail: item.brand!.contactEmail,
          contactAddress: item.brand!.contactAddress,
        ),
      );
    }
  }

  Future<void> deleteService(String id) async {
    final used = await (db.select(db.invoiceItems)..where((row) => row.serviceId.equals(id))).get();
    if (used.isNotEmpty) {
      throw InvoxaException('This service is on an invoice. Mark it inactive instead.');
    }
    await (db.delete(db.services)..where((row) => row.id.equals(id))).go();
  }

  Future<List<CustomerItem>> customers() async {
    final rows = await (db.select(db.customers)..orderBy([(row) => OrderingTerm.asc(row.name)])).get();
    return rows.map(_mapCustomer).toList();
  }

  Future<List<CustomerItem>> searchCustomers(String query) async {
    final text = query.trim().toLowerCase();
    final all = await customers();
    if (text.isEmpty) return all;
    return all.where((customer) {
      return customer.name.toLowerCase().contains(text) ||
          customer.phone.replaceAll(' ', '').contains(text.replaceAll(' ', '')) ||
          customer.whatsapp.replaceAll(' ', '').contains(text.replaceAll(' ', ''));
    }).toList();
  }

  Future<CustomerItem?> customer(String id) async {
    final row = await (db.select(db.customers)..where((table) => table.id.equals(id))).getSingleOrNull();
    return row == null ? null : _mapCustomer(row);
  }

  Future<String> saveCustomer(CustomerItem item) async {
    final business = await _requireBusiness();
    if (item.name.trim().isEmpty) throw InvoxaException('Enter the customer name.');
    final id = item.id.isEmpty ? _id() : item.id;
    final existing = await (db.select(db.customers)..where((row) => row.id.equals(id))).getSingleOrNull();
    final now = _now;
    final companion = CustomersCompanion(
      id: Value(id),
      businessId: Value(business.id),
      name: Value(item.name.trim()),
      phone: Value(item.phone.trim()),
      whatsapp: Value(item.whatsapp.trim().isEmpty ? item.phone.trim() : item.whatsapp.trim()),
      email: Value(_blank(item.email)),
      address: Value(_blank(item.address)),
      notes: Value(_blank(item.notes)),
      createdAt: Value(existing?.createdAt ?? now),
      updatedAt: Value(now),
    );
    if (existing == null) {
      await db.into(db.customers).insert(companion);
    } else {
      await (db.update(db.customers)..where((row) => row.id.equals(id))).write(companion);
    }
    return id;
  }

  Future<void> deleteCustomer(String id) async {
    final used = await (db.select(db.invoices)..where((row) => row.customerId.equals(id))).get();
    if (used.isNotEmpty) {
      throw InvoxaException('This customer has invoices, so the profile stays on record.');
    }
    await (db.delete(db.customers)..where((row) => row.id.equals(id))).go();
  }

  Future<CustomerStats> customerStats(String id) async {
    final person = await customer(id);
    if (person == null) throw InvoxaException('That customer is no longer on this device.');
    final invoices = await listInvoices();
    final linked = await (db.select(db.invoices)..where((row) => row.customerId.equals(id))).get();
    final ids = linked.map((row) => row.id).toSet();
    final relevant = invoices.where((invoice) => ids.contains(invoice.id)).toList();
    final payments = await listPayments();
    final currency = (await business())?.defaultCurrency ?? 'NGN';
    var invoiced = 0;
    var paid = 0;
    var outstanding = 0;
    for (final invoice in relevant) {
      if (invoice.status == InvoiceStatus.draft || invoice.status == InvoiceStatus.cancelled) continue;
      if (invoice.currency != currency) continue;
      invoiced += invoice.grandMinor;
      paid += invoice.paidMinor;
      outstanding += invoice.outstandingMinor;
    }
    return CustomerStats(
      customer: person,
      invoicedMinor: invoiced,
      paidMinor: paid,
      outstandingMinor: outstanding,
      currency: currency,
      invoices: relevant,
      payments: payments.where((payment) => ids.contains(payment.invoiceId)).toList(),
    );
  }

  Future<List<InvoiceSummary>> listInvoices({InvoiceQuery query = const InvoiceQuery()}) async {
    final summaries = await _summaries();
    return filterInvoices<InvoiceSummary>(
      invoices: summaries,
      query: query,
      status: (invoice) => invoice.status,
      customer: (invoice) => invoice.customerName,
      number: (invoice) => invoice.number,
      service: (invoice) => invoice.serviceLabel,
      grand: (invoice) => invoice.grandMinor,
      outstanding: (invoice) => invoice.outstandingMinor,
      issued: (invoice) => invoice.issueDate,
      currency: (invoice) => invoice.currency,
    );
  }

  Future<InvoiceDetail> invoice(String id) => _detail(id);

  Future<InvoiceDetail> saveInvoice(InvoiceWrite input) async {
    await ensureDefaults();
    final business = await _requireBusiness();
    if (input.customerName.trim().isEmpty) throw InvoxaException('Enter the customer name.');
    if (input.lines.isEmpty) throw InvoxaException('Add at least one line.');
    for (final line in input.lines) {
      if (line.name.trim().isEmpty) throw InvoxaException('Every line needs a name.');
      if (line.quantityMilli <= 0) throw InvoxaException('Quantity must be greater than zero.');
    }
    final totals = computeTotals(
      lines: [
        for (final line in input.lines) (quantityMilli: line.quantityMilli, unitPriceMinor: line.unitPriceMinor),
      ],
      discountMinor: input.discountMinor,
      taxRateBps: input.taxRateBps,
      chargesMinor: input.chargesMinor,
    );
    final existing = input.id == null
        ? null
        : await (db.select(db.invoices)..where((row) => row.id.equals(input.id!))).getSingleOrNull();
    if (input.id != null && existing == null) throw InvoxaException('That invoice is no longer on this device.');
    final paid = existing == null ? 0 : await _paidSum(existing.id);
    if (totals.grandMinor < paid) {
      throw InvoxaException('The new total is less than payments already recorded.');
    }
    final branding = selectInvoiceBranding([
      for (final line in input.lines) ServiceBrandRef(serviceId: line.serviceId, mode: line.brandingMode),
    ]);
    final brand = await _resolveBrand(business.id, branding);
    final banks = await bankAccounts();
    final selection = selectPaymentAccounts(
      serviceAccountIds: input.lines.map((line) => line.bankAccountId).toList(),
      businessDefaultAccountId: banks.where((bank) => bank.isDefault).firstOrNull?.id,
    );
    var bankId = input.bankAccountId;
    if (bankId == null || bankId.isEmpty) {
      if (selection.needsChoice) {
        throw InvoxaException('These services use different accounts. Choose where the customer should pay.');
      }
      bankId = selection.suggestedId;
    }
    final bank = banks.where((item) => item.id == bankId).firstOrNull;
    final service = branding.serviceId == null
        ? null
        : await (db.select(db.services)..where((row) => row.id.equals(branding.serviceId!))).getSingleOrNull();
    final now = _now;
    final id = existing?.id ?? _id();
    final stored = existing == null ? InvoiceStatus.draft : InvoiceStatusLabel.parse(existing.status);
    final issuing = input.issue || (stored != InvoiceStatus.draft && stored != InvoiceStatus.cancelled);
    if (stored == InvoiceStatus.cancelled) {
      throw InvoxaException('A cancelled invoice stays as it was.');
    }

    final notificationIds = <int>[];
    await db.transaction(() async {
      String? customerId = input.customerId;
      if (input.saveCustomer) {
        customerId = await saveCustomer(
          CustomerItem(
            id: input.customerId ?? '',
            name: input.customerName,
            phone: input.customerPhone,
            whatsapp: input.customerWhatsapp,
            email: input.customerEmail,
            address: input.customerAddress,
          ),
        );
      }
      var number = existing?.number;
      var issuedAt = existing?.issuedAt;
      var status = stored;
      if (issuing) {
        number ??= await _allocateNumber(receipt: false, when: input.issueDate);
        issuedAt ??= now;
        status = effectiveStatus(
          stored: InvoiceStatus.unpaid,
          grandMinor: totals.grandMinor,
          paidMinor: paid,
          dueDate: input.dueDate,
          today: now,
        );
      }
      final companion = InvoicesCompanion(
        id: Value(id),
        businessId: Value(business.id),
        number: Value(number),
        status: Value(status.storage),
        issueDate: Value(input.issueDate),
        dueDate: Value(input.dueDate),
        customerId: Value(customerId),
        customerName: Value(input.customerName.trim()),
        customerPhone: Value(input.customerPhone.trim()),
        customerWhatsapp: Value(
          input.customerWhatsapp.trim().isEmpty ? input.customerPhone.trim() : input.customerWhatsapp.trim(),
        ),
        customerEmail: Value(_blank(input.customerEmail)),
        customerAddress: Value(_blank(input.customerAddress)),
        customerSaved: Value(customerId != null),
        discountMinor: Value(totals.discountMinor),
        taxRateBps: Value(input.taxRateBps),
        taxMinor: Value(totals.taxMinor),
        chargesMinor: Value(totals.chargesMinor),
        subtotalMinor: Value(totals.subtotalMinor),
        grandTotalMinor: Value(totals.grandMinor),
        currency: Value(input.currency),
        bankAccountId: Value(bank?.id),
        bankSnapshot: Value(bank == null ? null : jsonEncode(_bankJson(bank))),
        brandingSnapshot: Value(jsonEncode(_brandJson(business, brand, service: service))),
        paymentInstructions: Value(input.paymentInstructions.trim()),
        notes: Value(_blank(input.notes)),
        terms: Value(input.terms.termsText),
        termsPreset: Value(input.terms.storage),
        template: Value(brand.template),
        issuedAt: Value(issuedAt),
        settledAt: Value(status == InvoiceStatus.paid ? (existing?.settledAt ?? now) : null),
        cancelledAt: const Value(null),
        createdAt: Value(existing?.createdAt ?? now),
        updatedAt: Value(now),
      );
      if (existing == null) {
        await db.into(db.invoices).insert(companion);
      } else {
        await (db.update(db.invoices)..where((row) => row.id.equals(id))).write(companion);
      }
      await (db.delete(db.invoiceItems)..where((row) => row.invoiceId.equals(id))).go();
      for (var index = 0; index < input.lines.length; index++) {
        final line = input.lines[index];
        await db.into(db.invoiceItems).insert(
          InvoiceItemsCompanion.insert(
            id: _id(),
            invoiceId: id,
            serviceId: Value(line.serviceId),
            name: line.name.trim(),
            description: Value(line.description.trim()),
            quantityMilli: line.quantityMilli,
            unit: line.unit,
            customUnit: Value(_blank(line.customUnit)),
            unitPriceMinor: line.unitPriceMinor,
            lineTotalMinor: lineTotalMinor(line.quantityMilli, line.unitPriceMinor),
            position: Value(index),
          ),
        );
      }
      if (status == InvoiceStatus.paid) {
        notificationIds.addAll(await _cancelReminderRows(id));
      }
    });
    for (final notificationId in notificationIds) {
      await scheduler.cancel(notificationId);
    }
    if (issuing && paid < totals.grandMinor) {
      await scheduleInvoiceReminders(id);
    }
    return _detail(id);
  }

  Future<InvoiceDetail> duplicateInvoice(String id) async {
    final source = await _detail(id);
    final settings = await loadSettings();
    final issue = dateOnly(_now);
    return saveInvoice(
      InvoiceWrite(
        issue: false,
        customerId: source.customerId,
        saveCustomer: false,
        customerName: source.customerName,
        customerPhone: source.customerPhone,
        customerWhatsapp: source.customerWhatsapp,
        customerEmail: source.customerEmail,
        customerAddress: source.customerAddress,
        lines: [
          for (final line in source.lines)
            InvoiceLineInput(
              serviceId: line.serviceId,
              name: line.name,
              description: line.description,
              quantityMilli: line.quantityMilli,
              unit: line.unit,
              customUnit: line.customUnit,
              unitPriceMinor: line.unitPriceMinor,
              brandingMode: line.brandingMode,
              bankAccountId: line.bankAccountId,
            ),
        ],
        discountMinor: source.discountMinor,
        taxRateBps: source.taxRateBps,
        chargesMinor: source.chargesMinor,
        currency: source.currency,
        bankAccountId: source.bankAccountId,
        issueDate: issue,
        dueDate: dueDateFor(issue, settings.defaultTermsPreset),
        terms: settings.defaultTermsPreset,
        notes: source.notes,
        paymentInstructions: source.paymentInstructions,
      ),
    );
  }

  Future<void> deleteDraft(String id) async {
    final row = await _invoiceRow(id);
    if (row.status != InvoiceStatus.draft.storage) {
      throw InvoxaException('Only drafts can be deleted. Cancel an issued invoice to keep the record.');
    }
    if (await _paidSum(id) > 0) {
      throw InvoxaException('This invoice has payments, so it stays on record.');
    }
    await (db.delete(db.invoices)..where((table) => table.id.equals(id))).go();
  }

  Future<void> cancelInvoice(String id) async {
    final row = await _invoiceRow(id);
    if (row.status == InvoiceStatus.draft.storage) {
      throw InvoxaException('Delete the draft instead of cancelling it.');
    }
    final ids = await _cancelReminderRows(id);
    await (db.update(db.invoices)..where((table) => table.id.equals(id))).write(
      InvoicesCompanion(
        status: Value(InvoiceStatus.cancelled.storage),
        cancelledAt: Value(_now),
        updatedAt: Value(_now),
      ),
    );
    for (final notificationId in ids) {
      await scheduler.cancel(notificationId);
    }
  }

  Future<RecordedPayment> recordPayment({
    required String invoiceId,
    required int amountMinor,
    required DateTime paidAt,
    required PaymentMethod method,
    required String idempotencyKey,
    String? bankAccountId,
    String? reference,
    String? notes,
  }) async {
    if (idempotencyKey.trim().isEmpty) throw InvoxaException('The payment could not be saved. Try again.');
    if (amountMinor <= 0) throw InvoxaException('Enter a payment amount greater than zero.');
    final existingKey = await (db.select(db.payments)..where(
      (row) => row.idempotencyKey.equals(idempotencyKey),
    )).getSingleOrNull();
    if (existingKey != null) {
      if (existingKey.invoiceId != invoiceId) {
        throw InvoxaException('This payment was already recorded on another invoice.');
      }
      final receipt = await (db.select(db.receipts)..where(
        (row) => row.paymentId.equals(existingKey.id),
      )).getSingle();
      final detail = await _detail(invoiceId);
      return RecordedPayment(
        payment: _mapPayment(existingKey, detail.number, detail.customerName, detail.currency),
        receipt: _mapReceipt(receipt),
        fullyPaid: detail.status == InvoiceStatus.paid,
      );
    }

    late RecordedPayment recorded;
    final cancelIds = <int>[];
    await db.transaction(() async {
      final row = await _invoiceRow(invoiceId);
      final stored = InvoiceStatusLabel.parse(row.status);
      if (stored == InvoiceStatus.draft) {
        throw InvoxaException('Issue the invoice before recording a payment.');
      }
      if (stored == InvoiceStatus.cancelled) {
        throw InvoxaException('This invoice is cancelled.');
      }
      final paid = await _paidSum(invoiceId);
      final outstanding = row.grandTotalMinor - paid;
      if (amountMinor > outstanding) {
        throw InvoxaException('That is more than the ${formatMoney(outstanding, row.currency)} still outstanding.');
      }
      final now = _now;
      final paymentId = _id();
      await db.into(db.payments).insert(
        PaymentsCompanion.insert(
          id: paymentId,
          invoiceId: invoiceId,
          idempotencyKey: idempotencyKey,
          amountMinor: amountMinor,
          paidAt: paidAt,
          method: method.storage,
          bankAccountId: Value(bankAccountId),
          reference: Value(_blank(reference)),
          notes: Value(_blank(notes)),
          createdAt: now,
        ),
      );
      final remaining = outstanding - amountMinor;
      final marker = remaining == 0 ? ReceiptMarker.paid : ReceiptMarker.partPayment;
      final receiptNumber = await _allocateNumber(receipt: true, when: paidAt);
      final receiptId = _id();
      final snapshot = await _receiptSnapshot(
        row: row,
        amountMinor: amountMinor,
        remainingMinor: remaining,
        method: method,
        reference: reference ?? '',
        receiptNumber: receiptNumber,
      );
      await db.into(db.receipts).insert(
        ReceiptsCompanion.insert(
          id: receiptId,
          number: receiptNumber,
          paymentId: paymentId,
          invoiceId: invoiceId,
          amountMinor: amountMinor,
          remainingMinor: remaining,
          marker: marker.storage,
          snapshot: jsonEncode(snapshot),
          issuedAt: paidAt,
        ),
      );
      final status = effectiveStatus(
        stored: InvoiceStatus.unpaid,
        grandMinor: row.grandTotalMinor,
        paidMinor: paid + amountMinor,
        dueDate: row.dueDate,
        today: now,
      );
      await (db.update(db.invoices)..where((table) => table.id.equals(invoiceId))).write(
        InvoicesCompanion(
          status: Value(status.storage),
          settledAt: Value(status == InvoiceStatus.paid ? paidAt : null),
          updatedAt: Value(now),
        ),
      );
      if (shouldCancelReminders(status)) {
        cancelIds.addAll(await _cancelReminderRows(invoiceId));
      }
      final payment = await (db.select(db.payments)..where((table) => table.id.equals(paymentId))).getSingle();
      final receipt = await (db.select(db.receipts)..where((table) => table.id.equals(receiptId))).getSingle();
      recorded = RecordedPayment(
        payment: _mapPayment(payment, row.number, row.customerName, row.currency),
        receipt: _mapReceipt(receipt),
        fullyPaid: status == InvoiceStatus.paid,
      );
    });
    for (final notificationId in cancelIds) {
      await scheduler.cancel(notificationId);
    }
    return recorded;
  }

  Future<List<PaymentItem>> listPayments() async {
    final payments = await (db.select(db.payments)..orderBy([(row) => OrderingTerm.desc(row.paidAt)])).get();
    final invoices = await db.select(db.invoices).get();
    final byId = {for (final row in invoices) row.id: row};
    return [
      for (final payment in payments)
        if (byId[payment.invoiceId] != null)
          _mapPayment(
            payment,
            byId[payment.invoiceId]!.number,
            byId[payment.invoiceId]!.customerName,
            byId[payment.invoiceId]!.currency,
          ),
    ];
  }

  Future<ReceiptItem?> receiptForPayment(String paymentId) async {
    final row = await (db.select(db.receipts)..where((table) => table.paymentId.equals(paymentId))).getSingleOrNull();
    return row == null ? null : _mapReceipt(row);
  }

  Future<List<ReminderItem>> remindersFor(String invoiceId) async {
    final rows = await (db.select(db.reminders)
          ..where((table) => table.invoiceId.equals(invoiceId))
          ..orderBy([(row) => OrderingTerm.asc(row.scheduledAt)]))
        .get();
    return rows.map(_mapReminder).toList();
  }

  Future<void> scheduleInvoiceReminders(String invoiceId, {DateTime? custom}) async {
    final detail = await _detail(invoiceId);
    if (detail.status == InvoiceStatus.paid ||
        detail.status == InvoiceStatus.cancelled ||
        detail.status == InvoiceStatus.draft) {
      final ids = await _cancelReminderRows(invoiceId);
      for (final id in ids) {
        await scheduler.cancel(id);
      }
      return;
    }
    final settings = await loadSettings();
    if (!settings.notificationsEnabled && custom == null) {
      final ids = await _cancelReminderRows(invoiceId);
      for (final id in ids) {
        await scheduler.cancel(id);
      }
      return;
    }
    final planned = planReminders(
      dueDate: detail.dueDate,
      now: _now,
      beforeDue: settings.notificationsEnabled,
      beforeDays: settings.remindBeforeDays,
      onDue: settings.notificationsEnabled && settings.remindOnDue,
      after3: settings.notificationsEnabled && settings.remindAfter3,
      after7: settings.notificationsEnabled && settings.remindAfter7,
      custom: custom,
    );
    final previous = await _cancelReminderRows(invoiceId);
    for (final id in previous) {
      await scheduler.cancel(id);
    }
    for (final plan in planned) {
      final notificationId = _random.nextInt(1 << 30) + 1;
      final body = reminderNotificationBody(
        kind: plan.kind,
        number: detail.number ?? 'Draft',
        outstanding: detail.outstandingMinor,
        currency: detail.currency,
        dueDate: detail.dueDate,
      );
      await db.into(db.reminders).insert(
        RemindersCompanion.insert(
          id: _id(),
          invoiceId: invoiceId,
          kind: plan.kind.storage,
          scheduledAt: plan.scheduledAt,
          notificationId: notificationId,
          status: 'scheduled',
          message: Value(body),
          createdAt: _now,
        ),
      );
      await scheduler.schedule(
        id: notificationId,
        when: plan.scheduledAt,
        title: 'INVOXA',
        body: body,
        payload: invoiceId,
      );
    }
  }

  Future<void> markReminderSent(String reminderId) async {
    await (db.update(db.reminders)..where((row) => row.id.equals(reminderId))).write(
      RemindersCompanion(status: const Value('sent'), sentAt: Value(_now)),
    );
  }

  Future<void> addSentReminder({required String invoiceId, required String message}) async {
    await db.into(db.reminders).insert(
      RemindersCompanion.insert(
        id: _id(),
        invoiceId: invoiceId,
        kind: ReminderKind.custom.storage,
        scheduledAt: _now,
        notificationId: 0,
        status: 'sent',
        sentAt: Value(_now),
        message: Value(message),
        createdAt: _now,
      ),
    );
  }

  Future<DashboardFigures> dashboard() async {
    final profile = await business();
    final currency = profile?.defaultCurrency ?? 'NGN';
    final ledger = await _ledger();
    return dashboardFigures(
      invoices: ledger.invoices,
      payments: ledger.payments,
      lines: ledger.lines,
      currency: currency,
      today: _now,
    );
  }

  Future<ReportFigures> report(ReportRange range, {DateTime? customStart, DateTime? customEnd}) async {
    final profile = await business();
    final currency = profile?.defaultCurrency ?? 'NGN';
    final bounds = rangeBounds(range, _now, customStart: customStart, customEnd: customEnd);
    final ledger = await _ledger();
    return reportFigures(
      invoices: ledger.invoices,
      payments: ledger.payments,
      lines: ledger.lines,
      currency: currency,
      today: _now,
      start: bounds.start,
      end: bounds.end,
    );
  }

  Future<List<MessageTemplateItem>> templates() async {
    await ensureDefaults();
    final rows = await db.select(db.messageTemplates).get();
    return rows
        .map(
          (row) => MessageTemplateItem(
            id: row.id,
            type: TemplateTypeLabel.parse(row.type),
            name: row.name,
            body: row.body,
            isDefault: row.isDefault,
          ),
        )
        .toList();
  }

  Future<void> saveTemplate(MessageTemplateItem item) async {
    if (item.body.trim().isEmpty) throw InvoxaException('The message cannot be empty.');
    await (db.update(db.messageTemplates)..where((row) => row.id.equals(item.id))).write(
      MessageTemplatesCompanion(name: Value(item.name.trim()), body: Value(item.body.trim()), updatedAt: Value(_now)),
    );
  }

  Future<MessageTemplateItem> templateFor(TemplateType type) async {
    final all = await templates();
    return all.firstWhere((item) => item.type == type, orElse: () {
      return MessageTemplateItem(
        id: '',
        type: type,
        name: type.name,
        body: defaultTemplate(type),
        isDefault: true,
      );
    });
  }

  Future<Uint8List> exportBackup({String? password}) async {
    final document = BackupDocument(exportedAt: _now.toUtc(), tables: await _exportTables());
    final bytes = await _backup.encode(document, password: password);
    await db.into(db.backupMetadata).insert(
      BackupMetadataCompanion.insert(
        id: _id(),
        createdAt: _now,
        fileName: 'INVOXA-backup-${formatIsoDate(_now)}.invoxa.json',
        formatVersion: backupVersion,
        encrypted: Value(password != null && password.isNotEmpty),
        sizeBytes: Value(bytes.length),
        note: const Value('Manual backup'),
      ),
    );
    await (db.update(db.appSettings)..where((row) => row.id.equals('app'))).write(
      AppSettingsCompanion(lastBackupAt: Value(_now)),
    );
    return bytes;
  }

  Future<void> restoreBackup(Uint8List bytes, {String? password}) async {
    final document = await _backup.decode(bytes, password: password);
    await db.transaction(() async {
      await _wipe();
      await _importTables(document.tables);
    });
  }

  Future<void> clearAll() async {
    await db.transaction(_wipe);
    await ensureDefaults();
  }

  Future<void> checkpoint() => db.customStatement('PRAGMA wal_checkpoint(FULL)');

  Future<String> exportInvoicesCsv() async {
    final invoices = await listInvoices();
    return invoicesToCsv([
      for (final invoice in invoices)
        CsvInvoiceRow(
          number: invoice.number ?? '',
          status: invoice.status.label,
          issueDate: formatIsoDate(invoice.issueDate),
          dueDate: formatIsoDate(invoice.dueDate),
          customer: invoice.customerName,
          phone: '',
          currency: invoice.currency,
          subtotalMinor: invoice.grandMinor,
          discountMinor: 0,
          taxMinor: 0,
          chargesMinor: 0,
          grandMinor: invoice.grandMinor,
          paidMinor: invoice.paidMinor,
          outstandingMinor: invoice.outstandingMinor,
          service: invoice.serviceLabel,
          notes: '',
        ),
    ]);
  }

  Future<int> importInvoicesCsv(String csv) async {
    final rows = parseInvoiceCsv(csv);
    final business = await _requireBusiness();
    await db.transaction(() async {
      for (final row in rows) {
        final issue = DateTime.parse(row.issueDate);
        final due = DateTime.parse(row.dueDate);
        final phone = row.phone.trim();
        final existingCustomer = phone.isEmpty
            ? null
            : (await customers()).where((customer) => customer.phone == phone || customer.whatsapp == phone).firstOrNull;
        final customerId = existingCustomer?.id ??
            await saveCustomer(
              CustomerItem(id: '', name: row.customer, phone: phone, whatsapp: phone),
            );
        final totals = computeTotals(
          lines: [(quantityMilli: 1000, unitPriceMinor: row.grandMinor)],
          discountMinor: 0,
          taxRateBps: 0,
          chargesMinor: 0,
        );
        final detail = await saveInvoice(
          InvoiceWrite(
            issue: true,
            customerId: customerId,
            saveCustomer: false,
            customerName: row.customer,
            customerPhone: phone,
            lines: [
              InvoiceLineInput(
                name: row.service,
                quantityMilli: 1000,
                unit: UnitType.item.storage,
                unitPriceMinor: totals.grandMinor,
              ),
            ],
            currency: supportedCurrencies.containsKey(row.currency) ? row.currency : business.defaultCurrency,
            issueDate: issue,
            dueDate: due,
            terms: TermsPreset.custom,
            notes: row.notes,
            paymentInstructions: (await loadSettings()).defaultPaymentInstructions,
          ),
        );
        if (row.paidMinor > 0) {
          final amount = row.paidMinor > detail.grandMinor ? detail.grandMinor : row.paidMinor;
          if (amount > 0) {
            await recordPayment(
              invoiceId: detail.id,
              amountMinor: amount,
              paidAt: issue,
              method: PaymentMethod.other,
              idempotencyKey: _id(),
              reference: 'Imported',
            );
          }
        }
      }
    });
    return rows.length;
  }

  Future<({List<LedgerInvoice> invoices, List<LedgerPayment> payments, List<LedgerLine> lines})> _ledger() async {
    final summaries = await _summaries();
    final payments = await listPayments();
    final items = await db.select(db.invoiceItems).get();
    return (
      invoices: [
        for (final invoice in summaries)
          LedgerInvoice(
            id: invoice.id,
            customerId: null,
            customerName: invoice.customerName,
            storedStatus: invoice.status,
            issueDate: invoice.issueDate,
            dueDate: invoice.dueDate,
            grandMinor: invoice.grandMinor,
            paidMinor: invoice.paidMinor,
            currency: invoice.currency,
            number: invoice.number,
          ),
      ],
      payments: [
        for (final payment in payments)
          LedgerPayment(
            id: payment.id,
            invoiceId: payment.invoiceId,
            amountMinor: payment.amountMinor,
            paidAt: payment.paidAt,
            currency: payment.currency,
          ),
      ],
      lines: [
        for (final item in items)
          LedgerLine(invoiceId: item.invoiceId, serviceName: item.name, lineTotalMinor: item.lineTotalMinor),
      ],
    );
  }

  Future<List<InvoiceSummary>> _summaries() async {
    final invoices = await db.select(db.invoices).get();
    final items = await db.select(db.invoiceItems).get();
    final payments = await db.select(db.payments).get();
    final paid = <String, int>{};
    for (final payment in payments) {
      paid[payment.invoiceId] = (paid[payment.invoiceId] ?? 0) + payment.amountMinor;
    }
    final names = <String, List<String>>{};
    for (final item in items) {
      names.putIfAbsent(item.invoiceId, () => []).add(item.name);
    }
    final today = _now;
    final summaries = <InvoiceSummary>[];
    for (final row in invoices) {
      final paidMinor = paid[row.id] ?? 0;
      final status = effectiveStatus(
        stored: InvoiceStatusLabel.parse(row.status),
        grandMinor: row.grandTotalMinor,
        paidMinor: paidMinor,
        dueDate: row.dueDate,
        today: today,
      );
      if (status.storage != row.status && row.status != InvoiceStatus.draft.storage) {
        await (db.update(db.invoices)..where((table) => table.id.equals(row.id))).write(
          InvoicesCompanion(status: Value(status.storage)),
        );
      }
      final outstanding = status == InvoiceStatus.draft || status == InvoiceStatus.cancelled
          ? 0
          : outstandingMinor(row.grandTotalMinor, paidMinor);
      summaries.add(
        InvoiceSummary(
          id: row.id,
          number: row.number,
          status: status,
          issueDate: row.issueDate,
          dueDate: row.dueDate,
          customerName: row.customerName,
          customerId: row.customerId,
          grandMinor: row.grandTotalMinor,
          paidMinor: paidMinor,
          outstandingMinor: outstanding,
          currency: row.currency,
          serviceLabel: (names[row.id] ?? const []).join(', '),
        ),
      );
    }
    summaries.sort((a, b) => b.issueDate.compareTo(a.issueDate));
    return summaries;
  }

  Future<InvoiceDetail> _detail(String id) async {
    final row = await _invoiceRow(id);
    final items = await (db.select(db.invoiceItems)
          ..where((table) => table.invoiceId.equals(id))
          ..orderBy([(item) => OrderingTerm.asc(item.position)]))
        .get();
    final services = await db.select(db.services).get();
    final serviceById = {for (final service in services) service.id: service};
    final payments = await (db.select(db.payments)..where((table) => table.invoiceId.equals(id))).get();
    final receipts = await (db.select(db.receipts)..where((table) => table.invoiceId.equals(id))).get();
    final reminders = await remindersFor(id);
    final paidMinor = payments.fold<int>(0, (sum, payment) => sum + payment.amountMinor);
    final status = effectiveStatus(
      stored: InvoiceStatusLabel.parse(row.status),
      grandMinor: row.grandTotalMinor,
      paidMinor: paidMinor,
      dueDate: row.dueDate,
      today: _now,
    );
    final branding = selectInvoiceBranding([
      for (final item in items)
        ServiceBrandRef(
          serviceId: item.serviceId,
          mode: item.serviceId == null
              ? BrandingMode.business
              : BrandingModeLabel.parse(serviceById[item.serviceId]?.brandingMode ?? 'business'),
        ),
    ]);
    return InvoiceDetail(
      id: row.id,
      number: row.number,
      storedStatus: InvoiceStatusLabel.parse(row.status),
      status: status,
      issueDate: row.issueDate,
      dueDate: row.dueDate,
      customerId: row.customerId,
      customerName: row.customerName,
      customerPhone: row.customerPhone,
      customerWhatsapp: row.customerWhatsapp,
      customerEmail: row.customerEmail,
      customerAddress: row.customerAddress,
      customerSaved: row.customerSaved,
      lines: [
        for (final item in items)
          InvoiceLineItem(
            id: item.id,
            serviceId: item.serviceId,
            name: item.name,
            description: item.description,
            quantityMilli: item.quantityMilli,
            unit: item.unit,
            customUnit: item.customUnit,
            unitPriceMinor: item.unitPriceMinor,
            lineTotalMinor: item.lineTotalMinor,
            position: item.position,
            brandingMode: item.serviceId == null
                ? BrandingMode.business
                : BrandingModeLabel.parse(serviceById[item.serviceId]?.brandingMode ?? 'business'),
            bankAccountId: item.serviceId == null ? null : serviceById[item.serviceId]?.bankAccountId,
          ),
      ],
      discountMinor: row.discountMinor,
      taxRateBps: row.taxRateBps,
      taxMinor: row.taxMinor,
      chargesMinor: row.chargesMinor,
      subtotalMinor: row.subtotalMinor,
      grandMinor: row.grandTotalMinor,
      paidMinor: paidMinor,
      outstandingMinor: status == InvoiceStatus.draft || status == InvoiceStatus.cancelled
          ? 0
          : outstandingMinor(row.grandTotalMinor, paidMinor),
      currency: row.currency,
      bankAccountId: row.bankAccountId,
      bankSnapshot: _decodeMap(row.bankSnapshot),
      brandSnapshot: _decodeMap(row.brandingSnapshot),
      paymentInstructions: row.paymentInstructions,
      notes: row.notes,
      terms: row.terms,
      termsPreset: TermsPresetLabel.parse(row.termsPreset),
      template: InvoiceTemplateLabel.parse(row.template),
      issuedAt: row.issuedAt,
      settledAt: row.settledAt,
      cancelledAt: row.cancelledAt,
      payments: [
        for (final payment in payments) _mapPayment(payment, row.number, row.customerName, row.currency),
      ],
      receipts: [for (final receipt in receipts) _mapReceipt(receipt)],
      reminders: reminders,
      brandingNote: branding.reason,
    );
  }

  Future<InvoiceRow> _invoiceRow(String id) async {
    final row = await (db.select(db.invoices)..where((table) => table.id.equals(id))).getSingleOrNull();
    if (row == null) throw InvoxaException('That invoice is no longer on this device.');
    return row;
  }

  Future<int> _paidSum(String invoiceId) async {
    final rows = await (db.select(db.payments)..where((table) => table.invoiceId.equals(invoiceId))).get();
    return rows.fold<int>(0, (sum, row) => sum + row.amountMinor);
  }

  Future<String> _allocateNumber({required bool receipt, required DateTime when}) async {
    final settings = await (db.select(db.appSettings)..where((row) => row.id.equals('app'))).getSingle();
    var sequence = receipt ? settings.nextReceiptSequence : settings.nextInvoiceSequence;
    final prefix = receipt ? settings.receiptPrefix : settings.invoicePrefix;
    while (true) {
      final number = formatDocumentNumber(
        prefix: prefix,
        year: when.year,
        sequence: sequence,
        padding: settings.numberPadding,
      );
      final taken = receipt
          ? await (db.select(db.receipts)..where((row) => row.number.equals(number))).getSingleOrNull()
          : await (db.select(db.invoices)..where((row) => row.number.equals(number))).getSingleOrNull();
      sequence += 1;
      if (taken == null) {
        await (db.update(db.appSettings)..where((row) => row.id.equals('app'))).write(
          receipt
              ? AppSettingsCompanion(nextReceiptSequence: Value(sequence))
              : AppSettingsCompanion(nextInvoiceSequence: Value(sequence)),
        );
        return number;
      }
      if (sequence > 1000000) throw InvoxaException('Could not allocate a unique number.');
    }
  }

  Future<BrandProfileRow> _resolveBrand(String businessId, BrandingSelection selection) async {
    if (selection.useServiceBrand && selection.serviceId != null) {
      final serviceBrand = await (db.select(db.brandProfiles)..where(
        (row) => row.ownerType.equals('service') & row.ownerId.equals(selection.serviceId!),
      )).getSingleOrNull();
      if (serviceBrand != null) return serviceBrand;
    }
    final businessBrand = await (db.select(db.brandProfiles)..where(
      (row) => row.ownerType.equals('business') & row.ownerId.equals(businessId),
    )).getSingleOrNull();
    if (businessBrand != null) return businessBrand;
    final now = _now;
    final id = _id();
    await db.into(db.brandProfiles).insert(
      BrandProfilesCompanion.insert(id: id, ownerType: 'business', ownerId: businessId, createdAt: now, updatedAt: now),
    );
    return (db.select(db.brandProfiles)..where((row) => row.id.equals(id))).getSingle();
  }

  Future<List<int>> _cancelReminderRows(String invoiceId) async {
    final rows = await (db.select(db.reminders)..where(
      (row) => row.invoiceId.equals(invoiceId) & row.status.equals('scheduled'),
    )).get();
    await (db.update(db.reminders)..where(
      (row) => row.invoiceId.equals(invoiceId) & row.status.equals('scheduled'),
    )).write(const RemindersCompanion(status: Value('cancelled')));
    return [for (final row in rows) row.notificationId];
  }

  Future<Map<String, Object?>> _receiptSnapshot({
    required InvoiceRow row,
    required int amountMinor,
    required int remainingMinor,
    required PaymentMethod method,
    required String reference,
    required String receiptNumber,
  }) async {
    final brand = _decodeMap(row.brandingSnapshot) ?? const <String, Object?>{};
    return {
      'receiptNumber': receiptNumber,
      'invoiceNumber': row.number ?? '',
      'businessName': brand['tradingName'] ?? brand['legalName'] ?? '',
      'businessPhone': brand['phone'] ?? '',
      'businessAddress': brand['address'] ?? '',
      'customerName': row.customerName,
      'method': method.label,
      'reference': reference,
      'primaryColor': brand['primaryColor'] ?? '#1B2A4A',
      'signatureBase64': brand['signatureBase64'],
      'footer': brand['footer'] ?? '',
      'amountMinor': amountMinor,
      'remainingMinor': remainingMinor,
    };
  }

  Future<void> _wipe() async {
    await db.delete(db.reminders).go();
    await db.delete(db.receipts).go();
    await db.delete(db.payments).go();
    await db.delete(db.invoiceItems).go();
    await db.delete(db.invoices).go();
    await db.delete(db.services).go();
    await db.delete(db.customers).go();
    await db.delete(db.bankAccounts).go();
    await db.delete(db.brandProfiles).go();
    await db.delete(db.businesses).go();
    await db.delete(db.messageTemplates).go();
    await db.delete(db.backupMetadata).go();
    await db.delete(db.appSettings).go();
  }

  Future<Map<String, List<Map<String, Object?>>>> _exportTables() async {
    List<Map<String, Object?>> maps(List<DataClass> rows) => [
        for (final row in rows) Map<String, Object?>.from(row.toJson()),
      ];
    final brands = await db.select(db.brandProfiles).get();
    return {
      'businesses': maps(await db.select(db.businesses).get()),
      'brandProfiles': [
        for (final row in brands) _blobJson(row.toJson(), row.logoBytes, row.signatureBytes),
      ],
      'bankAccounts': maps(await db.select(db.bankAccounts).get()),
      'services': maps(await db.select(db.services).get()),
      'customers': maps(await db.select(db.customers).get()),
      'invoices': maps(await db.select(db.invoices).get()),
      'invoiceItems': maps(await db.select(db.invoiceItems).get()),
      'payments': maps(await db.select(db.payments).get()),
      'receipts': maps(await db.select(db.receipts).get()),
      'reminders': maps(await db.select(db.reminders).get()),
      'messageTemplates': maps(await db.select(db.messageTemplates).get()),
      'appSettings': maps(await db.select(db.appSettings).get()),
      'backupMetadata': maps(await db.select(db.backupMetadata).get()),
    };
  }

  Map<String, Object?> _blobJson(Map<String, dynamic> json, Uint8List? logo, Uint8List? signature) {
    final copy = Map<String, Object?>.from(json);
    copy.remove('logoBytes');
    copy.remove('signatureBytes');
    copy['logoBase64'] = logo == null ? null : base64Encode(logo);
    copy['signatureBase64'] = signature == null ? null : base64Encode(signature);
    return copy;
  }

  Future<void> _importTables(Map<String, List<Map<String, Object?>>> tables) async {
    for (final row in tables['businesses']!) {
      await db.into(db.businesses).insert(
        BusinessesCompanion.insert(
          id: row['id']! as String,
          legalName: row['legalName']! as String,
          tradingName: Value(row['tradingName'] as String?),
          phone: row['phone']! as String,
          whatsapp: row['whatsapp']! as String,
          email: row['email']! as String,
          address: row['address']! as String,
          website: Value(row['website'] as String?),
          registrationNumber: Value(row['registrationNumber'] as String?),
          tin: Value(row['tin'] as String?),
          description: Value(row['description'] as String?),
          defaultCurrency: Value(row['defaultCurrency'] as String? ?? 'NGN'),
          createdAt: DateTime.parse(row['createdAt']! as String),
          updatedAt: DateTime.parse(row['updatedAt']! as String),
        ),
      );
    }
    for (final row in tables['brandProfiles']!) {
      await db.into(db.brandProfiles).insert(
        BrandProfilesCompanion.insert(
          id: row['id']! as String,
          ownerType: row['ownerType']! as String,
          ownerId: row['ownerId']! as String,
          logoBytes: Value(_b64(row['logoBase64'])),
          signatureBytes: Value(_b64(row['signatureBase64'])),
          primaryColor: Value(row['primaryColor'] as String? ?? '#1B2A4A'),
          secondaryColor: Value(row['secondaryColor'] as String? ?? '#243B67'),
          accentColor: Value(row['accentColor'] as String? ?? '#0E8F62'),
          tagline: Value(row['tagline'] as String?),
          footer: Value(row['footer'] as String?),
          template: Value(row['template'] as String? ?? 'corporate'),
          tradingName: Value(row['tradingName'] as String?),
          contactPhone: Value(row['contactPhone'] as String?),
          contactWhatsapp: Value(row['contactWhatsapp'] as String?),
          contactEmail: Value(row['contactEmail'] as String?),
          contactAddress: Value(row['contactAddress'] as String?),
          createdAt: DateTime.parse(row['createdAt']! as String),
          updatedAt: DateTime.parse(row['updatedAt']! as String),
        ),
      );
    }
    for (final row in tables['bankAccounts']!) {
      await db.into(db.bankAccounts).insert(
        BankAccountsCompanion.insert(
          id: row['id']! as String,
          businessId: row['businessId']! as String,
          bankName: row['bankName']! as String,
          accountName: row['accountName']! as String,
          accountNumber: row['accountNumber']! as String,
          label: Value(row['label'] as String?),
          isDefault: Value(row['isDefault'] == true),
          isActive: Value(row['isActive'] != false),
          createdAt: DateTime.parse(row['createdAt']! as String),
        ),
      );
    }
    for (final row in tables['services']!) {
      await db.into(db.services).insert(
        ServicesCompanion.insert(
          id: row['id']! as String,
          businessId: row['businessId']! as String,
          name: row['name']! as String,
          description: Value(row['description'] as String? ?? ''),
          category: Value(row['category'] as String? ?? ''),
          defaultPriceMinor: Value(row['defaultPriceMinor'] as int? ?? 0),
          unit: Value(row['unit'] as String? ?? 'item'),
          customUnit: Value(row['customUnit'] as String?),
          currency: Value(row['currency'] as String? ?? 'NGN'),
          bankAccountId: Value(row['bankAccountId'] as String?),
          isActive: Value(row['isActive'] != false),
          brandingMode: Value(row['brandingMode'] as String? ?? 'business'),
          createdAt: DateTime.parse(row['createdAt']! as String),
          updatedAt: DateTime.parse(row['updatedAt']! as String),
        ),
      );
    }
    for (final row in tables['customers']!) {
      await db.into(db.customers).insert(
        CustomersCompanion.insert(
          id: row['id']! as String,
          businessId: row['businessId']! as String,
          name: row['name']! as String,
          phone: Value(row['phone'] as String? ?? ''),
          whatsapp: Value(row['whatsapp'] as String? ?? ''),
          email: Value(row['email'] as String?),
          address: Value(row['address'] as String?),
          notes: Value(row['notes'] as String?),
          createdAt: DateTime.parse(row['createdAt']! as String),
          updatedAt: DateTime.parse(row['updatedAt']! as String),
        ),
      );
    }
    for (final row in tables['appSettings']!) {
      await db.into(db.appSettings).insert(
        AppSettingsCompanion.insert(
          id: 'app',
          onboardingComplete: Value(row['onboardingComplete'] == true),
          invoicePrefix: Value(row['invoicePrefix'] as String? ?? 'INV'),
          nextInvoiceSequence: Value(row['nextInvoiceSequence'] as int? ?? 1),
          receiptPrefix: Value(row['receiptPrefix'] as String? ?? 'RCT'),
          nextReceiptSequence: Value(row['nextReceiptSequence'] as int? ?? 1),
          numberPadding: Value(row['numberPadding'] as int? ?? 4),
          defaultCurrency: Value(row['defaultCurrency'] as String? ?? 'NGN'),
          taxEnabled: Value(row['taxEnabled'] == true),
          defaultTaxRateBps: Value(row['defaultTaxRateBps'] as int? ?? 0),
          defaultTermsPreset: Value(row['defaultTermsPreset'] as String? ?? 'days7'),
          defaultDueDays: Value(row['defaultDueDays'] as int? ?? 7),
          defaultNotes: Value(row['defaultNotes'] as String? ?? ''),
          defaultPaymentInstructions: Value(row['defaultPaymentInstructions'] as String? ?? ''),
          notificationsEnabled: Value(row['notificationsEnabled'] != false),
          remindBeforeDays: Value(row['remindBeforeDays'] as int? ?? 1),
          remindOnDue: Value(row['remindOnDue'] != false),
          remindAfter3: Value(row['remindAfter3'] != false),
          remindAfter7: Value(row['remindAfter7'] != false),
          pinEnabled: const Value(false),
          biometricEnabled: const Value(false),
          autoLockSeconds: Value(row['autoLockSeconds'] as int? ?? 60),
          protectSensitive: Value(row['protectSensitive'] != false),
          themeMode: Value(row['themeMode'] as String? ?? 'system'),
          paymentMethods: Value(row['paymentMethods'] as String? ?? 'bank_transfer,cash,pos,card,other'),
          createdAt: DateTime.parse(row['createdAt']! as String),
          updatedAt: DateTime.parse(row['updatedAt']! as String),
          insightEnabled: Value(row['insightEnabled'] != false),
        ),
      );
    }
    for (final row in tables['messageTemplates']!) {
      await db.into(db.messageTemplates).insert(
        MessageTemplatesCompanion.insert(
          id: row['id']! as String,
          type: row['type']! as String,
          name: row['name']! as String,
          body: row['body']! as String,
          isDefault: Value(row['isDefault'] == true),
          updatedAt: DateTime.parse(row['updatedAt']! as String),
        ),
      );
    }
    for (final row in tables['invoices']!) {
      await db.into(db.invoices).insert(
        InvoicesCompanion.insert(
          id: row['id']! as String,
          businessId: row['businessId']! as String,
          number: Value(row['number'] as String?),
          status: row['status']! as String,
          issueDate: DateTime.parse(row['issueDate']! as String),
          dueDate: DateTime.parse(row['dueDate']! as String),
          customerId: Value(row['customerId'] as String?),
          customerName: row['customerName']! as String,
          customerPhone: Value(row['customerPhone'] as String? ?? ''),
          customerWhatsapp: Value(row['customerWhatsapp'] as String? ?? ''),
          customerEmail: Value(row['customerEmail'] as String?),
          customerAddress: Value(row['customerAddress'] as String?),
          customerSaved: Value(row['customerSaved'] != false),
          discountMinor: Value(row['discountMinor'] as int? ?? 0),
          taxRateBps: Value(row['taxRateBps'] as int? ?? 0),
          taxMinor: Value(row['taxMinor'] as int? ?? 0),
          chargesMinor: Value(row['chargesMinor'] as int? ?? 0),
          subtotalMinor: Value(row['subtotalMinor'] as int? ?? 0),
          grandTotalMinor: Value(row['grandTotalMinor'] as int? ?? 0),
          currency: Value(row['currency'] as String? ?? 'NGN'),
          bankAccountId: Value(row['bankAccountId'] as String?),
          bankSnapshot: Value(row['bankSnapshot'] as String?),
          brandingSnapshot: Value(row['brandingSnapshot'] as String?),
          paymentInstructions: Value(row['paymentInstructions'] as String? ?? ''),
          notes: Value(row['notes'] as String?),
          terms: Value(row['terms'] as String?),
          termsPreset: Value(row['termsPreset'] as String? ?? 'days7'),
          template: Value(row['template'] as String? ?? 'corporate'),
          issuedAt: Value(_optionalDate(row['issuedAt'])),
          settledAt: Value(_optionalDate(row['settledAt'])),
          cancelledAt: Value(_optionalDate(row['cancelledAt'])),
          createdAt: DateTime.parse(row['createdAt']! as String),
          updatedAt: DateTime.parse(row['updatedAt']! as String),
        ),
      );
    }
    for (final row in tables['invoiceItems']!) {
      await db.into(db.invoiceItems).insert(
        InvoiceItemsCompanion.insert(
          id: row['id']! as String,
          invoiceId: row['invoiceId']! as String,
          serviceId: Value(row['serviceId'] as String?),
          name: row['name']! as String,
          description: Value(row['description'] as String? ?? ''),
          quantityMilli: row['quantityMilli']! as int,
          unit: row['unit']! as String,
          customUnit: Value(row['customUnit'] as String?),
          unitPriceMinor: row['unitPriceMinor']! as int,
          lineTotalMinor: row['lineTotalMinor']! as int,
          position: Value(row['position'] as int? ?? 0),
        ),
      );
    }
    for (final row in tables['payments']!) {
      await db.into(db.payments).insert(
        PaymentsCompanion.insert(
          id: row['id']! as String,
          invoiceId: row['invoiceId']! as String,
          idempotencyKey: row['idempotencyKey']! as String,
          amountMinor: row['amountMinor']! as int,
          paidAt: DateTime.parse(row['paidAt']! as String),
          method: row['method']! as String,
          bankAccountId: Value(row['bankAccountId'] as String?),
          reference: Value(row['reference'] as String?),
          notes: Value(row['notes'] as String?),
          createdAt: DateTime.parse(row['createdAt']! as String),
        ),
      );
    }
    for (final row in tables['receipts']!) {
      await db.into(db.receipts).insert(
        ReceiptsCompanion.insert(
          id: row['id']! as String,
          number: row['number']! as String,
          paymentId: row['paymentId']! as String,
          invoiceId: row['invoiceId']! as String,
          amountMinor: row['amountMinor']! as int,
          remainingMinor: row['remainingMinor']! as int,
          marker: row['marker']! as String,
          snapshot: row['snapshot']! as String,
          issuedAt: DateTime.parse(row['issuedAt']! as String),
        ),
      );
    }
    for (final row in tables['reminders']!) {
      await db.into(db.reminders).insert(
        RemindersCompanion.insert(
          id: row['id']! as String,
          invoiceId: row['invoiceId']! as String,
          kind: row['kind']! as String,
          scheduledAt: DateTime.parse(row['scheduledAt']! as String),
          notificationId: row['notificationId']! as int,
          status: row['status'] == 'scheduled' ? 'cancelled' : row['status']! as String,
          sentAt: Value(_optionalDate(row['sentAt'])),
          message: Value(row['message'] as String?),
          createdAt: DateTime.parse(row['createdAt']! as String),
        ),
      );
    }
    for (final row in tables['backupMetadata']!) {
      await db.into(db.backupMetadata).insert(
        BackupMetadataCompanion.insert(
          id: row['id']! as String,
          createdAt: DateTime.parse(row['createdAt']! as String),
          fileName: row['fileName']! as String,
          formatVersion: row['formatVersion']! as int,
          encrypted: Value(row['encrypted'] == true),
          sizeBytes: Value(row['sizeBytes'] as int? ?? 0),
          note: Value(row['note'] as String?),
        ),
      );
    }
  }

  Map<String, Object?> _brandJson(BusinessRow business, BrandProfileRow brand, {ServiceRow? service}) {
    final custom = brand.ownerType == 'service';
    return {
      'legalName': custom ? (brand.tradingName ?? service?.name ?? business.legalName) : business.legalName,
      'tradingName': brand.tradingName ?? (custom ? service?.name : business.tradingName),
      'phone': custom ? (brand.contactPhone ?? business.phone) : business.phone,
      'email': custom ? (brand.contactEmail ?? business.email) : business.email,
      'address': custom ? (brand.contactAddress ?? business.address) : business.address,
      'website': custom ? null : business.website,
      'registrationNumber': custom ? null : business.registrationNumber,
      'tin': custom ? null : business.tin,
      'footer': brand.footer,
      'tagline': brand.tagline,
      'primaryColor': brand.primaryColor,
      'secondaryColor': brand.secondaryColor,
      'accentColor': brand.accentColor,
      'template': brand.template,
      'logoBase64': brand.logoBytes == null ? null : base64Encode(brand.logoBytes!),
      'signatureBase64': brand.signatureBytes == null ? null : base64Encode(brand.signatureBytes!),
    };
  }

  Map<String, Object?> _bankJson(BankAccount bank) => {
    'id': bank.id,
    'label': bank.label,
    'bankName': bank.bankName,
    'accountName': bank.accountName,
    'accountNumber': bank.accountNumber,
  };

  BusinessProfile _mapBusiness(BusinessRow row) => BusinessProfile(
    id: row.id,
    legalName: row.legalName,
    tradingName: row.tradingName,
    phone: row.phone,
    whatsapp: row.whatsapp,
    email: row.email,
    address: row.address,
    website: row.website,
    registrationNumber: row.registrationNumber,
    tin: row.tin,
    defaultCurrency: row.defaultCurrency,
    description: row.description,
  );

  BrandProfile _mapBrand(BrandProfileRow row) => BrandProfile(
    id: row.id,
    ownerType: row.ownerType,
    ownerId: row.ownerId,
    logoBytes: row.logoBytes,
    signatureBytes: row.signatureBytes,
    primaryColor: row.primaryColor,
    secondaryColor: row.secondaryColor,
    accentColor: row.accentColor,
    tagline: row.tagline,
    footer: row.footer,
    template: InvoiceTemplateLabel.parse(row.template),
    tradingName: row.tradingName,
    contactPhone: row.contactPhone,
    contactWhatsapp: row.contactWhatsapp,
    contactEmail: row.contactEmail,
    contactAddress: row.contactAddress,
  );

  BankAccount _mapBank(BankAccountRow row) => BankAccount(
    id: row.id,
    bankName: row.bankName,
    accountName: row.accountName,
    accountNumber: row.accountNumber,
    label: row.label,
    isDefault: row.isDefault,
    isActive: row.isActive,
  );

  ServiceItem _mapService(ServiceRow row, BrandProfileRow? brandRow, {BrandProfile? brand}) => ServiceItem(
    id: row.id,
    name: row.name,
    description: row.description,
    category: row.category,
    defaultPriceMinor: row.defaultPriceMinor,
    unit: row.unit,
    customUnit: row.customUnit,
    currency: row.currency,
    bankAccountId: row.bankAccountId,
    isActive: row.isActive,
    brandingMode: BrandingModeLabel.parse(row.brandingMode),
    brand: brand ?? (brandRow == null ? null : _mapBrand(brandRow)),
  );

  CustomerItem _mapCustomer(CustomerRow row) => CustomerItem(
    id: row.id,
    name: row.name,
    phone: row.phone,
    whatsapp: row.whatsapp,
    email: row.email,
    address: row.address,
    notes: row.notes,
  );

  PaymentItem _mapPayment(PaymentRow row, String? number, String customer, String currency) => PaymentItem(
    id: row.id,
    invoiceId: row.invoiceId,
    invoiceNumber: number,
    customerName: customer,
    amountMinor: row.amountMinor,
    paidAt: row.paidAt,
    method: PaymentMethodLabel.parse(row.method),
    bankAccountId: row.bankAccountId,
    reference: row.reference,
    notes: row.notes,
    currency: currency,
  );

  ReceiptItem _mapReceipt(ReceiptRow row) => ReceiptItem(
    id: row.id,
    number: row.number,
    paymentId: row.paymentId,
    invoiceId: row.invoiceId,
    amountMinor: row.amountMinor,
    remainingMinor: row.remainingMinor,
    marker: ReceiptMarkerLabel.parse(row.marker),
    issuedAt: row.issuedAt,
    snapshot: row.snapshot,
  );

  ReminderItem _mapReminder(ReminderRow row) => ReminderItem(
    id: row.id,
    invoiceId: row.invoiceId,
    kind: ReminderKindLabel.parse(row.kind),
    scheduledAt: row.scheduledAt,
    notificationId: row.notificationId,
    status: switch (row.status) {
      'sent' => ReminderStatus.sent,
      'cancelled' => ReminderStatus.cancelled,
      _ => ReminderStatus.scheduled,
    },
    sentAt: row.sentAt,
    message: row.message,
  );

  AppSettingsData _mapSettings(AppSettingRow row) => AppSettingsData(
    onboardingComplete: row.onboardingComplete,
    invoicePrefix: row.invoicePrefix,
    nextInvoiceSequence: row.nextInvoiceSequence,
    receiptPrefix: row.receiptPrefix,
    nextReceiptSequence: row.nextReceiptSequence,
    numberPadding: row.numberPadding,
    defaultCurrency: row.defaultCurrency,
    taxEnabled: row.taxEnabled,
    defaultTaxRateBps: row.defaultTaxRateBps,
    defaultTermsPreset: TermsPresetLabel.parse(row.defaultTermsPreset),
    defaultDueDays: row.defaultDueDays,
    defaultNotes: row.defaultNotes,
    defaultPaymentInstructions: row.defaultPaymentInstructions,
    notificationsEnabled: row.notificationsEnabled,
    remindBeforeDays: row.remindBeforeDays,
    remindOnDue: row.remindOnDue,
    remindAfter3: row.remindAfter3,
    remindAfter7: row.remindAfter7,
    pinEnabled: row.pinEnabled,
    biometricEnabled: row.biometricEnabled,
    autoLockSeconds: row.autoLockSeconds,
    protectSensitive: row.protectSensitive,
    lastBackupAt: row.lastBackupAt,
    themeMode: switch (row.themeMode) {
      'light' => ThemeChoice.light,
      'dark' => ThemeChoice.dark,
      _ => ThemeChoice.system,
    },
    paymentMethods: row.paymentMethods
        .split(',')
        .where((item) => item.isNotEmpty)
        .map(PaymentMethodLabel.parse)
        .toList(),
    insightEnabled: row.insightEnabled,
  );
}

String? _blank(String? value) {
  final text = value?.trim() ?? '';
  return text.isEmpty ? null : text;
}

Uint8List? _b64(Object? value) {
  if (value is! String || value.isEmpty) return null;
  return base64Decode(value);
}

DateTime? _optionalDate(Object? value) {
  if (value is! String || value.isEmpty) return null;
  return DateTime.parse(value);
}

Map<String, Object?>? _decodeMap(String? raw) {
  if (raw == null || raw.isEmpty) return null;
  final decoded = jsonDecode(raw);
  if (decoded is! Map) return null;
  return decoded.cast<String, Object?>();
}

List<HistoryEvent> historyFor(InvoiceDetail invoice) {
  final events = <HistoryEvent>[
    HistoryEvent(at: invoice.issueDate, title: 'Created', detail: invoice.customerName),
  ];
  if (invoice.issuedAt != null) {
    events.add(HistoryEvent(at: invoice.issuedAt!, title: 'Issued', detail: invoice.number ?? 'Invoice'));
  }
  for (final payment in invoice.payments) {
    events.add(
      HistoryEvent(
        at: payment.paidAt,
        title: 'Payment recorded',
        detail: '${formatMoney(payment.amountMinor, invoice.currency)} · ${payment.method.label}',
      ),
    );
  }
  for (final reminder in invoice.reminders) {
    if (reminder.sentAt != null) {
      events.add(HistoryEvent(at: reminder.sentAt!, title: 'Reminder marked sent', detail: reminder.kind.label));
    }
  }
  if (invoice.settledAt != null) {
    events.add(HistoryEvent(at: invoice.settledAt!, title: 'Settled', detail: 'Nothing left outstanding'));
  }
  if (invoice.cancelledAt != null) {
    events.add(HistoryEvent(at: invoice.cancelledAt!, title: 'Cancelled', detail: 'Payments stay on record'));
  }
  events.sort((a, b) => a.at.compareTo(b.at));
  return events;
}
