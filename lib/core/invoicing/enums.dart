enum InvoiceStatus { draft, unpaid, partial, paid, overdue, cancelled }

enum PaymentMethod { bankTransfer, cash, pos, card, other }

enum BrandingMode { business, custom }

enum InvoiceTemplate { corporate, minimal, premium, compact }

enum UnitType { piece, item, hour, day, week, month, session, project, package, custom }

enum TermsPreset { immediate, days7, days14, days30, custom }

enum ReminderKind { beforeDue, onDue, after3, after7, custom }

enum ReminderStatus { scheduled, sent, cancelled }

enum TemplateType { invoice, reminder, confirmation }

enum ReceiptMarker { paid, partPayment }

enum ThemeChoice { system, light, dark }

extension InvoiceStatusLabel on InvoiceStatus {
  String get label => switch (this) {
    InvoiceStatus.draft => 'Draft',
    InvoiceStatus.unpaid => 'Unpaid',
    InvoiceStatus.partial => 'Partially Paid',
    InvoiceStatus.paid => 'Paid',
    InvoiceStatus.overdue => 'Overdue',
    InvoiceStatus.cancelled => 'Cancelled',
  };

  String get storage => switch (this) {
    InvoiceStatus.draft => 'draft',
    InvoiceStatus.unpaid => 'unpaid',
    InvoiceStatus.partial => 'partial',
    InvoiceStatus.paid => 'paid',
    InvoiceStatus.overdue => 'overdue',
    InvoiceStatus.cancelled => 'cancelled',
  };

  static InvoiceStatus parse(String value) => switch (value) {
    'draft' => InvoiceStatus.draft,
    'unpaid' => InvoiceStatus.unpaid,
    'partial' => InvoiceStatus.partial,
    'paid' => InvoiceStatus.paid,
    'overdue' => InvoiceStatus.overdue,
    'cancelled' => InvoiceStatus.cancelled,
    _ => throw FormatException('Unknown invoice status: $value'),
  };
}

extension PaymentMethodLabel on PaymentMethod {
  String get label => switch (this) {
    PaymentMethod.bankTransfer => 'Bank transfer',
    PaymentMethod.cash => 'Cash',
    PaymentMethod.pos => 'POS',
    PaymentMethod.card => 'Card',
    PaymentMethod.other => 'Other',
  };

  String get storage => switch (this) {
    PaymentMethod.bankTransfer => 'bank_transfer',
    PaymentMethod.cash => 'cash',
    PaymentMethod.pos => 'pos',
    PaymentMethod.card => 'card',
    PaymentMethod.other => 'other',
  };

  static PaymentMethod parse(String value) => switch (value) {
    'bank_transfer' => PaymentMethod.bankTransfer,
    'cash' => PaymentMethod.cash,
    'pos' => PaymentMethod.pos,
    'card' => PaymentMethod.card,
    'other' => PaymentMethod.other,
    _ => throw FormatException('Unknown payment method: $value'),
  };
}

extension UnitTypeLabel on UnitType {
  String get label => switch (this) {
    UnitType.piece => 'Piece',
    UnitType.item => 'Item',
    UnitType.hour => 'Hour',
    UnitType.day => 'Day',
    UnitType.week => 'Week',
    UnitType.month => 'Month',
    UnitType.session => 'Session',
    UnitType.project => 'Project',
    UnitType.package => 'Package',
    UnitType.custom => 'Custom',
  };

  String get storage => name;

  static UnitType parse(String value) {
    for (final unit in UnitType.values) {
      if (unit.name == value) return unit;
    }
    throw FormatException('Unknown unit: $value');
  }
}

extension TermsPresetLabel on TermsPreset {
  String get label => switch (this) {
    TermsPreset.immediate => 'Due on receipt',
    TermsPreset.days7 => '7 days',
    TermsPreset.days14 => '14 days',
    TermsPreset.days30 => '30 days',
    TermsPreset.custom => 'Custom date',
  };

  String get storage => switch (this) {
    TermsPreset.immediate => 'immediate',
    TermsPreset.days7 => 'days7',
    TermsPreset.days14 => 'days14',
    TermsPreset.days30 => 'days30',
    TermsPreset.custom => 'custom',
  };

  int get days => switch (this) {
    TermsPreset.immediate => 0,
    TermsPreset.days7 => 7,
    TermsPreset.days14 => 14,
    TermsPreset.days30 => 30,
    TermsPreset.custom => 0,
  };

  String get termsText => switch (this) {
    TermsPreset.immediate => 'Payment is due on receipt.',
    TermsPreset.days7 => 'Payment is due within 7 days.',
    TermsPreset.days14 => 'Payment is due within 14 days.',
    TermsPreset.days30 => 'Payment is due within 30 days.',
    TermsPreset.custom => 'Payment is due on the date shown.',
  };

  static TermsPreset parse(String value) => switch (value) {
    'immediate' => TermsPreset.immediate,
    'days7' => TermsPreset.days7,
    'days14' => TermsPreset.days14,
    'days30' => TermsPreset.days30,
    'custom' => TermsPreset.custom,
    _ => throw FormatException('Unknown terms: $value'),
  };
}

extension InvoiceTemplateLabel on InvoiceTemplate {
  String get label => switch (this) {
    InvoiceTemplate.corporate => 'Corporate',
    InvoiceTemplate.minimal => 'Minimal',
    InvoiceTemplate.premium => 'Premium',
    InvoiceTemplate.compact => 'Compact',
  };

  String get storage => name;

  static InvoiceTemplate parse(String value) {
    for (final template in InvoiceTemplate.values) {
      if (template.name == value) return template;
    }
    throw FormatException('Unknown template: $value');
  }
}

extension BrandingModeLabel on BrandingMode {
  String get storage => name;

  static BrandingMode parse(String value) => switch (value) {
    'business' => BrandingMode.business,
    'custom' => BrandingMode.custom,
    _ => throw FormatException('Unknown branding mode: $value'),
  };
}

extension ReminderKindLabel on ReminderKind {
  String get label => switch (this) {
    ReminderKind.beforeDue => 'Before due date',
    ReminderKind.onDue => 'On due date',
    ReminderKind.after3 => '3 days after',
    ReminderKind.after7 => '7 days after',
    ReminderKind.custom => 'Custom date',
  };

  String get storage => switch (this) {
    ReminderKind.beforeDue => 'before_due',
    ReminderKind.onDue => 'on_due',
    ReminderKind.after3 => 'after_3',
    ReminderKind.after7 => 'after_7',
    ReminderKind.custom => 'custom',
  };

  static ReminderKind parse(String value) => switch (value) {
    'before_due' => ReminderKind.beforeDue,
    'on_due' => ReminderKind.onDue,
    'after_3' => ReminderKind.after3,
    'after_7' => ReminderKind.after7,
    'custom' => ReminderKind.custom,
    _ => throw FormatException('Unknown reminder: $value'),
  };
}

extension TemplateTypeLabel on TemplateType {
  String get storage => name;

  static TemplateType parse(String value) {
    for (final type in TemplateType.values) {
      if (type.name == value) return type;
    }
    throw FormatException('Unknown template type: $value');
  }
}

extension ReceiptMarkerLabel on ReceiptMarker {
  String get label => switch (this) {
    ReceiptMarker.paid => 'PAID',
    ReceiptMarker.partPayment => 'PART PAYMENT',
  };

  String get storage => switch (this) {
    ReceiptMarker.paid => 'paid',
    ReceiptMarker.partPayment => 'part_payment',
  };

  static ReceiptMarker parse(String value) => switch (value) {
    'paid' => ReceiptMarker.paid,
    'part_payment' => ReceiptMarker.partPayment,
    _ => throw FormatException('Unknown receipt marker: $value'),
  };
}

const supportedCurrencies = <String, String>{
  'NGN': '₦',
  'USD': r'$',
  'GBP': '£',
  'EUR': '€',
  'GHS': 'GH₵',
  'KES': 'KSh ',
  'ZAR': 'R',
  'CAD': r'CA$',
};

const defaultPaymentInstructions =
    'Please transfer the total to the account below and send a confirmation.';
