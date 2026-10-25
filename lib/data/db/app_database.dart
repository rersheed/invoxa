import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

part 'app_database.g.dart';

@DataClassName('BusinessRow')
class Businesses extends Table {
  TextColumn get id => text()();
  TextColumn get legalName => text()();
  TextColumn get tradingName => text().nullable()();
  TextColumn get phone => text()();
  TextColumn get whatsapp => text()();
  TextColumn get email => text()();
  TextColumn get address => text()();
  TextColumn get website => text().nullable()();
  TextColumn get registrationNumber => text().nullable()();
  TextColumn get tin => text().nullable()();
  TextColumn get description => text().nullable()();
  TextColumn get defaultCurrency => text().withDefault(const Constant('NGN'))();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('BrandProfileRow')
class BrandProfiles extends Table {
  TextColumn get id => text()();
  TextColumn get ownerType => text()();
  TextColumn get ownerId => text()();
  BlobColumn get logoBytes => blob().nullable()();
  BlobColumn get signatureBytes => blob().nullable()();
  TextColumn get primaryColor => text().withDefault(const Constant('#1B2A4A'))();
  TextColumn get secondaryColor => text().withDefault(const Constant('#243B67'))();
  TextColumn get accentColor => text().withDefault(const Constant('#0E8F62'))();
  TextColumn get tagline => text().nullable()();
  TextColumn get footer => text().nullable()();
  TextColumn get template => text().withDefault(const Constant('corporate'))();
  TextColumn get tradingName => text().nullable()();
  TextColumn get contactPhone => text().nullable()();
  TextColumn get contactWhatsapp => text().nullable()();
  TextColumn get contactEmail => text().nullable()();
  TextColumn get contactAddress => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};

  @override
  List<Set<Column>> get uniqueKeys => [
    {ownerType, ownerId},
  ];
}

@DataClassName('BankAccountRow')
class BankAccounts extends Table {
  TextColumn get id => text()();
  TextColumn get businessId => text().references(Businesses, #id)();
  TextColumn get bankName => text()();
  TextColumn get accountName => text()();
  TextColumn get accountNumber => text()();
  TextColumn get label => text().nullable()();
  BoolColumn get isDefault => boolean().withDefault(const Constant(false))();
  BoolColumn get isActive => boolean().withDefault(const Constant(true))();
  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('ServiceRow')
class Services extends Table {
  TextColumn get id => text()();
  TextColumn get businessId => text().references(Businesses, #id)();
  TextColumn get name => text()();
  TextColumn get description => text().withDefault(const Constant(''))();
  TextColumn get category => text().withDefault(const Constant(''))();
  IntColumn get defaultPriceMinor => integer().withDefault(const Constant(0))();
  TextColumn get unit => text().withDefault(const Constant('item'))();
  TextColumn get customUnit => text().nullable()();
  TextColumn get currency => text().withDefault(const Constant('NGN'))();
  TextColumn get bankAccountId => text().nullable().references(BankAccounts, #id)();
  BoolColumn get isActive => boolean().withDefault(const Constant(true))();
  TextColumn get brandingMode => text().withDefault(const Constant('business'))();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('CustomerRow')
class Customers extends Table {
  TextColumn get id => text()();
  TextColumn get businessId => text().references(Businesses, #id)();
  TextColumn get name => text()();
  TextColumn get phone => text().withDefault(const Constant(''))();
  TextColumn get whatsapp => text().withDefault(const Constant(''))();
  TextColumn get email => text().nullable()();
  TextColumn get address => text().nullable()();
  TextColumn get notes => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

@TableIndex(name: 'idx_invoices_status', columns: {#status})
@TableIndex(name: 'idx_invoices_customer', columns: {#customerId})
@DataClassName('InvoiceRow')
class Invoices extends Table {
  TextColumn get id => text()();
  TextColumn get businessId => text().references(Businesses, #id)();
  TextColumn get number => text().nullable().unique()();
  TextColumn get status => text()();
  DateTimeColumn get issueDate => dateTime()();
  DateTimeColumn get dueDate => dateTime()();
  TextColumn get customerId => text().nullable().references(Customers, #id)();
  TextColumn get customerName => text()();
  TextColumn get customerPhone => text().withDefault(const Constant(''))();
  TextColumn get customerWhatsapp => text().withDefault(const Constant(''))();
  TextColumn get customerEmail => text().nullable()();
  TextColumn get customerAddress => text().nullable()();
  BoolColumn get customerSaved => boolean().withDefault(const Constant(true))();
  IntColumn get discountMinor => integer().withDefault(const Constant(0))();
  IntColumn get taxRateBps => integer().withDefault(const Constant(0))();
  IntColumn get taxMinor => integer().withDefault(const Constant(0))();
  IntColumn get chargesMinor => integer().withDefault(const Constant(0))();
  IntColumn get subtotalMinor => integer().withDefault(const Constant(0))();
  IntColumn get grandTotalMinor => integer().withDefault(const Constant(0))();
  TextColumn get currency => text().withDefault(const Constant('NGN'))();
  TextColumn get bankAccountId => text().nullable().references(BankAccounts, #id)();
  TextColumn get bankSnapshot => text().nullable()();
  TextColumn get brandingSnapshot => text().nullable()();
  TextColumn get paymentInstructions => text().withDefault(const Constant(''))();
  TextColumn get notes => text().nullable()();
  TextColumn get terms => text().nullable()();
  TextColumn get termsPreset => text().withDefault(const Constant('days7'))();
  TextColumn get template => text().withDefault(const Constant('corporate'))();
  DateTimeColumn get issuedAt => dateTime().nullable()();
  DateTimeColumn get settledAt => dateTime().nullable()();
  DateTimeColumn get cancelledAt => dateTime().nullable()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('InvoiceItemRow')
class InvoiceItems extends Table {
  TextColumn get id => text()();
  TextColumn get invoiceId => text().references(Invoices, #id, onDelete: KeyAction.cascade)();
  TextColumn get serviceId => text().nullable().references(Services, #id)();
  TextColumn get name => text()();
  TextColumn get description => text().withDefault(const Constant(''))();
  IntColumn get quantityMilli => integer()();
  TextColumn get unit => text()();
  TextColumn get customUnit => text().nullable()();
  IntColumn get unitPriceMinor => integer()();
  IntColumn get lineTotalMinor => integer()();
  IntColumn get position => integer().withDefault(const Constant(0))();

  @override
  Set<Column> get primaryKey => {id};
}

@TableIndex(name: 'idx_payments_invoice', columns: {#invoiceId})
@DataClassName('PaymentRow')
class Payments extends Table {
  TextColumn get id => text()();
  TextColumn get invoiceId => text().references(Invoices, #id)();
  TextColumn get idempotencyKey => text().unique()();
  IntColumn get amountMinor => integer()();
  DateTimeColumn get paidAt => dateTime()();
  TextColumn get method => text()();
  TextColumn get bankAccountId => text().nullable().references(BankAccounts, #id)();
  TextColumn get reference => text().nullable()();
  TextColumn get notes => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('ReceiptRow')
class Receipts extends Table {
  TextColumn get id => text()();
  TextColumn get number => text().unique()();
  TextColumn get paymentId => text().unique().references(Payments, #id)();
  TextColumn get invoiceId => text().references(Invoices, #id)();
  IntColumn get amountMinor => integer()();
  IntColumn get remainingMinor => integer()();
  TextColumn get marker => text()();
  TextColumn get snapshot => text()();
  DateTimeColumn get issuedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

@TableIndex(name: 'idx_reminders_invoice', columns: {#invoiceId})
@DataClassName('ReminderRow')
class Reminders extends Table {
  TextColumn get id => text()();
  TextColumn get invoiceId => text().references(Invoices, #id, onDelete: KeyAction.cascade)();
  TextColumn get kind => text()();
  DateTimeColumn get scheduledAt => dateTime()();
  IntColumn get notificationId => integer()();
  TextColumn get status => text()();
  DateTimeColumn get sentAt => dateTime().nullable()();
  TextColumn get message => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('MessageTemplateRow')
class MessageTemplates extends Table {
  TextColumn get id => text()();
  TextColumn get type => text()();
  TextColumn get name => text()();
  TextColumn get body => text()();
  BoolColumn get isDefault => boolean().withDefault(const Constant(false))();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('AppSettingRow')
class AppSettings extends Table {
  TextColumn get id => text()();
  BoolColumn get onboardingComplete => boolean().withDefault(const Constant(false))();
  TextColumn get invoicePrefix => text().withDefault(const Constant('INV'))();
  IntColumn get nextInvoiceSequence => integer().withDefault(const Constant(1))();
  TextColumn get receiptPrefix => text().withDefault(const Constant('RCT'))();
  IntColumn get nextReceiptSequence => integer().withDefault(const Constant(1))();
  IntColumn get numberPadding => integer().withDefault(const Constant(4))();
  TextColumn get defaultCurrency => text().withDefault(const Constant('NGN'))();
  BoolColumn get taxEnabled => boolean().withDefault(const Constant(false))();
  IntColumn get defaultTaxRateBps => integer().withDefault(const Constant(0))();
  TextColumn get defaultTermsPreset => text().withDefault(const Constant('days7'))();
  IntColumn get defaultDueDays => integer().withDefault(const Constant(7))();
  TextColumn get defaultNotes => text().withDefault(const Constant(''))();
  TextColumn get defaultPaymentInstructions => text().withDefault(const Constant(''))();
  BoolColumn get notificationsEnabled => boolean().withDefault(const Constant(true))();
  IntColumn get remindBeforeDays => integer().withDefault(const Constant(1))();
  BoolColumn get remindOnDue => boolean().withDefault(const Constant(true))();
  BoolColumn get remindAfter3 => boolean().withDefault(const Constant(true))();
  BoolColumn get remindAfter7 => boolean().withDefault(const Constant(true))();
  BoolColumn get pinEnabled => boolean().withDefault(const Constant(false))();
  BoolColumn get biometricEnabled => boolean().withDefault(const Constant(false))();
  IntColumn get autoLockSeconds => integer().withDefault(const Constant(60))();
  BoolColumn get protectSensitive => boolean().withDefault(const Constant(true))();
  DateTimeColumn get lastBackupAt => dateTime().nullable()();
  TextColumn get themeMode => text().withDefault(const Constant('system'))();
  TextColumn get paymentMethods =>
      text().withDefault(const Constant('bank_transfer,cash,pos,card,other'))();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
  BoolColumn get insightEnabled => boolean().withDefault(const Constant(true))();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('BackupMetadataRow')
class BackupMetadata extends Table {
  TextColumn get id => text()();
  DateTimeColumn get createdAt => dateTime()();
  TextColumn get fileName => text()();
  IntColumn get formatVersion => integer()();
  BoolColumn get encrypted => boolean().withDefault(const Constant(false))();
  IntColumn get sizeBytes => integer().withDefault(const Constant(0))();
  TextColumn get note => text().nullable()();

  @override
  String get tableName => 'backup_metadata';

  @override
  Set<Column> get primaryKey => {id};
}

@DriftDatabase(
  tables: [
    Businesses,
    BrandProfiles,
    BankAccounts,
    Services,
    Customers,
    Invoices,
    InvoiceItems,
    Payments,
    Receipts,
    Reminders,
    MessageTemplates,
    AppSettings,
    BackupMetadata,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase(super.executor);

  AppDatabase.defaults() : super(driftDatabase(name: 'invoxa'));

  @override
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (migrator) async {
      await migrator.createAll();
    },
    onUpgrade: (migrator, from, to) async {
      if (from < 2) {
        await migrator.addColumn(appSettings, appSettings.insightEnabled);
      }
    },
    beforeOpen: (details) async {
      await customStatement('PRAGMA foreign_keys = ON');
    },
  );
}
