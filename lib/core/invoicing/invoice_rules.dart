import '../money/money.dart';
import 'enums.dart';

String formatDocumentNumber({
  required String prefix,
  required int year,
  required int sequence,
  int padding = 4,
}) {
  final clean = prefix.trim().toUpperCase().replaceAll(RegExp(r'[^A-Z0-9]'), '');
  if (clean.isEmpty) {
    throw FormatException('Enter a number prefix.');
  }
  if (sequence < 1) {
    throw FormatException('The next number must be 1 or more.');
  }
  if (padding < 1 || padding > 8) {
    throw FormatException('Number padding must be between 1 and 8.');
  }
  return '$clean-$year-${sequence.toString().padLeft(padding, '0')}';
}

DateTime dateOnly(DateTime value) => DateTime(value.year, value.month, value.day);

DateTime dueDateFor(DateTime issueDate, TermsPreset preset, {DateTime? custom}) {
  if (preset == TermsPreset.custom) {
    return dateOnly(custom ?? issueDate);
  }
  return dateOnly(issueDate).add(Duration(days: preset.days));
}

InvoiceStatus effectiveStatus({
  required InvoiceStatus stored,
  required int grandMinor,
  required int paidMinor,
  required DateTime dueDate,
  required DateTime today,
}) {
  if (stored == InvoiceStatus.cancelled) return InvoiceStatus.cancelled;
  if (stored == InvoiceStatus.draft) return InvoiceStatus.draft;
  if (grandMinor - paidMinor <= 0) return InvoiceStatus.paid;
  if (dateOnly(dueDate).isBefore(dateOnly(today))) return InvoiceStatus.overdue;
  if (paidMinor > 0) return InvoiceStatus.partial;
  return InvoiceStatus.unpaid;
}

class BrandingSelection {
  const BrandingSelection({
    required this.useServiceBrand,
    required this.serviceId,
    required this.reason,
  });

  final bool useServiceBrand;
  final String? serviceId;
  final String reason;
}

class ServiceBrandRef {
  const ServiceBrandRef({required this.serviceId, required this.mode});

  final String? serviceId;
  final BrandingMode mode;
}

/// Custom service branding is used only when every line belongs to that service.
BrandingSelection selectInvoiceBranding(List<ServiceBrandRef> lines) {
  if (lines.isEmpty) {
    return const BrandingSelection(
      useServiceBrand: false,
      serviceId: null,
      reason: 'No service selected, so the main business brand is used.',
    );
  }
  final customIds = lines
      .where((line) => line.mode == BrandingMode.custom && line.serviceId != null)
      .map((line) => line.serviceId!)
      .toSet();
  final hasBusinessLine = lines.any((line) => line.mode == BrandingMode.business || line.serviceId == null);
  if (customIds.length == 1 && !hasBusinessLine) {
    return BrandingSelection(
      useServiceBrand: true,
      serviceId: customIds.single,
      reason: 'Every line uses this service, so its own brand is used.',
    );
  }
  return const BrandingSelection(
    useServiceBrand: false,
    serviceId: null,
    reason: 'Mixed services use the main business brand.',
  );
}

class BankSelection {
  const BankSelection({
    required this.needsChoice,
    required this.accountIds,
    required this.suggestedId,
  });

  final bool needsChoice;
  final List<String> accountIds;
  final String? suggestedId;
}

BankSelection selectPaymentAccounts({
  required List<String?> serviceAccountIds,
  required String? businessDefaultAccountId,
}) {
  final ids = <String>[];
  for (final id in serviceAccountIds) {
    if (id != null && id.isNotEmpty && !ids.contains(id)) ids.add(id);
  }
  if (ids.length > 1) {
    return BankSelection(needsChoice: true, accountIds: ids, suggestedId: ids.first);
  }
  if (ids.length == 1) {
    return BankSelection(needsChoice: false, accountIds: ids, suggestedId: ids.single);
  }
  return BankSelection(
    needsChoice: false,
    accountIds: [?businessDefaultAccountId],
    suggestedId: businessDefaultAccountId,
  );
}

class PlannedReminder {
  const PlannedReminder({required this.kind, required this.scheduledAt});

  final ReminderKind kind;
  final DateTime scheduledAt;
}

List<PlannedReminder> planReminders({
  required DateTime dueDate,
  required DateTime now,
  required bool beforeDue,
  required int beforeDays,
  required bool onDue,
  required bool after3,
  required bool after7,
  DateTime? custom,
}) {
  final dueAt = DateTime(dueDate.year, dueDate.month, dueDate.day, 9);
  final planned = <PlannedReminder>[];
  void add(ReminderKind kind, DateTime at) {
    if (at.isAfter(now)) {
      planned.add(PlannedReminder(kind: kind, scheduledAt: at));
    }
  }

  if (beforeDue && beforeDays > 0) {
    add(ReminderKind.beforeDue, dueAt.subtract(Duration(days: beforeDays)));
  }
  if (onDue) add(ReminderKind.onDue, dueAt);
  if (after3) add(ReminderKind.after3, dueAt.add(const Duration(days: 3)));
  if (after7) add(ReminderKind.after7, dueAt.add(const Duration(days: 7)));
  if (custom != null) add(ReminderKind.custom, custom);
  return planned;
}

bool shouldCancelReminders(InvoiceStatus status) =>
    status == InvoiceStatus.paid || status == InvoiceStatus.cancelled;

String reminderNotificationBody({
  required ReminderKind kind,
  required String number,
  required int outstanding,
  required String currency,
  required DateTime dueDate,
}) {
  final amount = formatMoney(outstanding, currency);
  final due = '${dueDate.year}-${dueDate.month.toString().padLeft(2, '0')}-${dueDate.day.toString().padLeft(2, '0')}';
  return switch (kind) {
    ReminderKind.beforeDue => 'Invoice $number is due on $due. $amount is still outstanding.',
    ReminderKind.onDue => 'Invoice $number is due today. $amount is still outstanding.',
    ReminderKind.after3 || ReminderKind.after7 || ReminderKind.custom =>
      'Invoice $number is overdue. $amount is still outstanding.',
  };
}

String greetingFor(DateTime now) {
  if (now.hour < 12) return 'Good morning';
  if (now.hour < 17) return 'Good afternoon';
  return 'Good evening';
}
