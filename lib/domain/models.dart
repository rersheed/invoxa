import 'dart:typed_data';

import '../core/invoicing/enums.dart';

class BusinessProfile {
  const BusinessProfile({
    required this.id,
    required this.legalName,
    this.tradingName,
    required this.phone,
    required this.whatsapp,
    required this.email,
    required this.address,
    this.website,
    this.registrationNumber,
    this.tin,
    required this.defaultCurrency,
    this.description,
  });

  final String id;
  final String legalName;
  final String? tradingName;
  final String phone;
  final String whatsapp;
  final String email;
  final String address;
  final String? website;
  final String? registrationNumber;
  final String? tin;
  final String defaultCurrency;
  final String? description;

  String get displayName {
    final trading = tradingName?.trim() ?? '';
    return trading.isEmpty ? legalName : trading;
  }
}

class BrandProfile {
  const BrandProfile({
    required this.id,
    required this.ownerType,
    required this.ownerId,
    this.logoBytes,
    this.signatureBytes,
    required this.primaryColor,
    required this.secondaryColor,
    required this.accentColor,
    this.tagline,
    this.footer,
    required this.template,
    this.tradingName,
    this.contactPhone,
    this.contactWhatsapp,
    this.contactEmail,
    this.contactAddress,
  });

  final String id;
  final String ownerType;
  final String ownerId;
  final Uint8List? logoBytes;
  final Uint8List? signatureBytes;
  final String primaryColor;
  final String secondaryColor;
  final String accentColor;
  final String? tagline;
  final String? footer;
  final InvoiceTemplate template;
  final String? tradingName;
  final String? contactPhone;
  final String? contactWhatsapp;
  final String? contactEmail;
  final String? contactAddress;
}

class BankAccount {
  const BankAccount({
    required this.id,
    required this.bankName,
    required this.accountName,
    required this.accountNumber,
    this.label,
    required this.isDefault,
    required this.isActive,
  });

  final String id;
  final String bankName;
  final String accountName;
  final String accountNumber;
  final String? label;
  final bool isDefault;
  final bool isActive;

  String get displayLabel {
    final name = label?.trim() ?? '';
    if (name.isNotEmpty) return name;
    return '$bankName · $accountNumber';
  }

  String get details =>
      [if ((label ?? '').trim().isNotEmpty) label!.trim(), bankName, accountName, accountNumber].join('\n');
}

class ServiceItem {
  const ServiceItem({
    required this.id,
    required this.name,
    required this.description,
    required this.category,
    required this.defaultPriceMinor,
    required this.unit,
    this.customUnit,
    required this.currency,
    this.bankAccountId,
    required this.isActive,
    required this.brandingMode,
    this.brand,
  });

  final String id;
  final String name;
  final String description;
  final String category;
  final int defaultPriceMinor;
  final String unit;
  final String? customUnit;
  final String currency;
  final String? bankAccountId;
  final bool isActive;
  final BrandingMode brandingMode;
  final BrandProfile? brand;
}

class CustomerItem {
  const CustomerItem({
    required this.id,
    required this.name,
    required this.phone,
    required this.whatsapp,
    this.email,
    this.address,
    this.notes,
  });

  final String id;
  final String name;
  final String phone;
  final String whatsapp;
  final String? email;
  final String? address;
  final String? notes;
}

class CustomerStats {
  const CustomerStats({
    required this.customer,
    required this.invoicedMinor,
    required this.paidMinor,
    required this.outstandingMinor,
    required this.currency,
    required this.invoices,
    required this.payments,
  });

  final CustomerItem customer;
  final int invoicedMinor;
  final int paidMinor;
  final int outstandingMinor;
  final String currency;
  final List<InvoiceSummary> invoices;
  final List<PaymentItem> payments;
}

class InvoiceLineItem {
  const InvoiceLineItem({
    required this.id,
    this.serviceId,
    required this.name,
    required this.description,
    required this.quantityMilli,
    required this.unit,
    this.customUnit,
    required this.unitPriceMinor,
    required this.lineTotalMinor,
    required this.position,
    required this.brandingMode,
    this.bankAccountId,
  });

  final String id;
  final String? serviceId;
  final String name;
  final String description;
  final int quantityMilli;
  final String unit;
  final String? customUnit;
  final int unitPriceMinor;
  final int lineTotalMinor;
  final int position;
  final BrandingMode brandingMode;
  final String? bankAccountId;
}

class InvoiceSummary {
  const InvoiceSummary({
    required this.id,
    this.number,
    required this.status,
    required this.issueDate,
    required this.dueDate,
    required this.customerName,
    this.customerId,
    required this.grandMinor,
    required this.paidMinor,
    required this.outstandingMinor,
    required this.currency,
    required this.serviceLabel,
  });

  final String id;
  final String? number;
  final InvoiceStatus status;
  final DateTime issueDate;
  final DateTime dueDate;
  final String customerName;
  final String? customerId;
  final int grandMinor;
  final int paidMinor;
  final int outstandingMinor;
  final String currency;
  final String serviceLabel;
}

class PaymentItem {
  const PaymentItem({
    required this.id,
    required this.invoiceId,
    this.invoiceNumber,
    required this.customerName,
    required this.amountMinor,
    required this.paidAt,
    required this.method,
    this.bankAccountId,
    this.reference,
    this.notes,
    required this.currency,
  });

  final String id;
  final String invoiceId;
  final String? invoiceNumber;
  final String customerName;
  final int amountMinor;
  final DateTime paidAt;
  final PaymentMethod method;
  final String? bankAccountId;
  final String? reference;
  final String? notes;
  final String currency;
}

class ReceiptItem {
  const ReceiptItem({
    required this.id,
    required this.number,
    required this.paymentId,
    required this.invoiceId,
    required this.amountMinor,
    required this.remainingMinor,
    required this.marker,
    required this.issuedAt,
    required this.snapshot,
  });

  final String id;
  final String number;
  final String paymentId;
  final String invoiceId;
  final int amountMinor;
  final int remainingMinor;
  final ReceiptMarker marker;
  final DateTime issuedAt;
  final String snapshot;
}

class ReminderItem {
  const ReminderItem({
    required this.id,
    required this.invoiceId,
    required this.kind,
    required this.scheduledAt,
    required this.notificationId,
    required this.status,
    this.sentAt,
    this.message,
  });

  final String id;
  final String invoiceId;
  final ReminderKind kind;
  final DateTime scheduledAt;
  final int notificationId;
  final ReminderStatus status;
  final DateTime? sentAt;
  final String? message;
}

class InvoiceDetail {
  const InvoiceDetail({
    required this.id,
    this.number,
    required this.storedStatus,
    required this.status,
    required this.issueDate,
    required this.dueDate,
    this.customerId,
    required this.customerName,
    required this.customerPhone,
    required this.customerWhatsapp,
    this.customerEmail,
    this.customerAddress,
    required this.customerSaved,
    required this.lines,
    required this.discountMinor,
    required this.taxRateBps,
    required this.taxMinor,
    required this.chargesMinor,
    required this.subtotalMinor,
    required this.grandMinor,
    required this.paidMinor,
    required this.outstandingMinor,
    required this.currency,
    this.bankAccountId,
    this.bankSnapshot,
    this.brandSnapshot,
    required this.paymentInstructions,
    this.notes,
    this.terms,
    required this.termsPreset,
    required this.template,
    this.issuedAt,
    this.settledAt,
    this.cancelledAt,
    required this.payments,
    required this.receipts,
    required this.reminders,
    required this.brandingNote,
  });

  final String id;
  final String? number;
  final InvoiceStatus storedStatus;
  final InvoiceStatus status;
  final DateTime issueDate;
  final DateTime dueDate;
  final String? customerId;
  final String customerName;
  final String customerPhone;
  final String customerWhatsapp;
  final String? customerEmail;
  final String? customerAddress;
  final bool customerSaved;
  final List<InvoiceLineItem> lines;
  final int discountMinor;
  final int taxRateBps;
  final int taxMinor;
  final int chargesMinor;
  final int subtotalMinor;
  final int grandMinor;
  final int paidMinor;
  final int outstandingMinor;
  final String currency;
  final String? bankAccountId;
  final Map<String, Object?>? bankSnapshot;
  final Map<String, Object?>? brandSnapshot;
  final String paymentInstructions;
  final String? notes;
  final String? terms;
  final TermsPreset termsPreset;
  final InvoiceTemplate template;
  final DateTime? issuedAt;
  final DateTime? settledAt;
  final DateTime? cancelledAt;
  final List<PaymentItem> payments;
  final List<ReceiptItem> receipts;
  final List<ReminderItem> reminders;
  final String brandingNote;
}

class HistoryEvent {
  const HistoryEvent({required this.at, required this.title, required this.detail});

  final DateTime at;
  final String title;
  final String detail;
}

class MessageTemplateItem {
  const MessageTemplateItem({
    required this.id,
    required this.type,
    required this.name,
    required this.body,
    required this.isDefault,
  });

  final String id;
  final TemplateType type;
  final String name;
  final String body;
  final bool isDefault;
}

class AppSettingsData {
  const AppSettingsData({
    required this.onboardingComplete,
    required this.invoicePrefix,
    required this.nextInvoiceSequence,
    required this.receiptPrefix,
    required this.nextReceiptSequence,
    required this.numberPadding,
    required this.defaultCurrency,
    required this.taxEnabled,
    required this.defaultTaxRateBps,
    required this.defaultTermsPreset,
    required this.defaultDueDays,
    required this.defaultNotes,
    required this.defaultPaymentInstructions,
    required this.notificationsEnabled,
    required this.remindBeforeDays,
    required this.remindOnDue,
    required this.remindAfter3,
    required this.remindAfter7,
    required this.pinEnabled,
    required this.biometricEnabled,
    required this.autoLockSeconds,
    required this.protectSensitive,
    this.lastBackupAt,
    required this.themeMode,
    required this.paymentMethods,
    required this.insightEnabled,
  });

  final bool onboardingComplete;
  final String invoicePrefix;
  final int nextInvoiceSequence;
  final String receiptPrefix;
  final int nextReceiptSequence;
  final int numberPadding;
  final String defaultCurrency;
  final bool taxEnabled;
  final int defaultTaxRateBps;
  final TermsPreset defaultTermsPreset;
  final int defaultDueDays;
  final String defaultNotes;
  final String defaultPaymentInstructions;
  final bool notificationsEnabled;
  final int remindBeforeDays;
  final bool remindOnDue;
  final bool remindAfter3;
  final bool remindAfter7;
  final bool pinEnabled;
  final bool biometricEnabled;
  final int autoLockSeconds;
  final bool protectSensitive;
  final DateTime? lastBackupAt;
  final ThemeChoice themeMode;
  final List<PaymentMethod> paymentMethods;
  final bool insightEnabled;

  bool methodEnabled(PaymentMethod method) => paymentMethods.contains(method);

  AppSettingsData copyWith({
    bool? onboardingComplete,
    String? invoicePrefix,
    int? nextInvoiceSequence,
    String? receiptPrefix,
    int? nextReceiptSequence,
    int? numberPadding,
    String? defaultCurrency,
    bool? taxEnabled,
    int? defaultTaxRateBps,
    TermsPreset? defaultTermsPreset,
    int? defaultDueDays,
    String? defaultNotes,
    String? defaultPaymentInstructions,
    bool? notificationsEnabled,
    int? remindBeforeDays,
    bool? remindOnDue,
    bool? remindAfter3,
    bool? remindAfter7,
    bool? pinEnabled,
    bool? biometricEnabled,
    int? autoLockSeconds,
    bool? protectSensitive,
    DateTime? lastBackupAt,
    bool keepLastBackup = true,
    ThemeChoice? themeMode,
    List<PaymentMethod>? paymentMethods,
    bool? insightEnabled,
  }) {
    return AppSettingsData(
      onboardingComplete: onboardingComplete ?? this.onboardingComplete,
      invoicePrefix: invoicePrefix ?? this.invoicePrefix,
      nextInvoiceSequence: nextInvoiceSequence ?? this.nextInvoiceSequence,
      receiptPrefix: receiptPrefix ?? this.receiptPrefix,
      nextReceiptSequence: nextReceiptSequence ?? this.nextReceiptSequence,
      numberPadding: numberPadding ?? this.numberPadding,
      defaultCurrency: defaultCurrency ?? this.defaultCurrency,
      taxEnabled: taxEnabled ?? this.taxEnabled,
      defaultTaxRateBps: defaultTaxRateBps ?? this.defaultTaxRateBps,
      defaultTermsPreset: defaultTermsPreset ?? this.defaultTermsPreset,
      defaultDueDays: defaultDueDays ?? this.defaultDueDays,
      defaultNotes: defaultNotes ?? this.defaultNotes,
      defaultPaymentInstructions: defaultPaymentInstructions ?? this.defaultPaymentInstructions,
      notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
      remindBeforeDays: remindBeforeDays ?? this.remindBeforeDays,
      remindOnDue: remindOnDue ?? this.remindOnDue,
      remindAfter3: remindAfter3 ?? this.remindAfter3,
      remindAfter7: remindAfter7 ?? this.remindAfter7,
      pinEnabled: pinEnabled ?? this.pinEnabled,
      biometricEnabled: biometricEnabled ?? this.biometricEnabled,
      autoLockSeconds: autoLockSeconds ?? this.autoLockSeconds,
      protectSensitive: protectSensitive ?? this.protectSensitive,
      lastBackupAt: keepLastBackup ? (lastBackupAt ?? this.lastBackupAt) : lastBackupAt,
      themeMode: themeMode ?? this.themeMode,
      paymentMethods: paymentMethods ?? this.paymentMethods,
      insightEnabled: insightEnabled ?? this.insightEnabled,
    );
  }
}

class InvoiceLineInput {
  const InvoiceLineInput({
    this.id,
    this.serviceId,
    required this.name,
    this.description = '',
    required this.quantityMilli,
    required this.unit,
    this.customUnit,
    required this.unitPriceMinor,
    this.brandingMode = BrandingMode.business,
    this.bankAccountId,
  });

  final String? id;
  final String? serviceId;
  final String name;
  final String description;
  final int quantityMilli;
  final String unit;
  final String? customUnit;
  final int unitPriceMinor;
  final BrandingMode brandingMode;
  final String? bankAccountId;
}

class InvoiceWrite {
  const InvoiceWrite({
    this.id,
    required this.issue,
    this.customerId,
    required this.saveCustomer,
    required this.customerName,
    this.customerPhone = '',
    this.customerWhatsapp = '',
    this.customerEmail,
    this.customerAddress,
    required this.lines,
    this.discountMinor = 0,
    this.taxRateBps = 0,
    this.chargesMinor = 0,
    required this.currency,
    this.bankAccountId,
    required this.issueDate,
    required this.dueDate,
    required this.terms,
    this.notes,
    required this.paymentInstructions,
  });

  final String? id;
  final bool issue;
  final String? customerId;
  final bool saveCustomer;
  final String customerName;
  final String customerPhone;
  final String customerWhatsapp;
  final String? customerEmail;
  final String? customerAddress;
  final List<InvoiceLineInput> lines;
  final int discountMinor;
  final int taxRateBps;
  final int chargesMinor;
  final String currency;
  final String? bankAccountId;
  final DateTime issueDate;
  final DateTime dueDate;
  final TermsPreset terms;
  final String? notes;
  final String paymentInstructions;
}

class RecordedPayment {
  const RecordedPayment({required this.payment, required this.receipt, required this.fullyPaid});

  final PaymentItem payment;
  final ReceiptItem receipt;
  final bool fullyPaid;
}
