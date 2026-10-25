import '../invoicing/enums.dart';
import '../invoicing/invoice_math.dart';
import '../invoicing/invoice_rules.dart';
import '../money/money.dart';

class LedgerInvoice {
  const LedgerInvoice({
    required this.id,
    required this.customerId,
    required this.customerName,
    required this.storedStatus,
    required this.issueDate,
    required this.dueDate,
    required this.grandMinor,
    required this.paidMinor,
    required this.currency,
    required this.number,
  });

  final String id;
  final String? customerId;
  final String customerName;
  final InvoiceStatus storedStatus;
  final DateTime issueDate;
  final DateTime dueDate;
  final int grandMinor;
  final int paidMinor;
  final String currency;
  final String? number;

  InvoiceStatus statusOn(DateTime today) => effectiveStatus(
    stored: storedStatus,
    grandMinor: grandMinor,
    paidMinor: paidMinor,
    dueDate: dueDate,
    today: today,
  );

  int outstandingOn(DateTime today) {
    final status = statusOn(today);
    if (status == InvoiceStatus.draft || status == InvoiceStatus.cancelled) return 0;
    return outstandingMinor(grandMinor, paidMinor);
  }
}

class LedgerPayment {
  const LedgerPayment({
    required this.id,
    required this.invoiceId,
    required this.amountMinor,
    required this.paidAt,
    required this.currency,
  });

  final String id;
  final String invoiceId;
  final int amountMinor;
  final DateTime paidAt;
  final String currency;
}

class LedgerLine {
  const LedgerLine({
    required this.invoiceId,
    required this.serviceName,
    required this.lineTotalMinor,
  });

  final String invoiceId;
  final String serviceName;
  final int lineTotalMinor;
}

class MonthPoint {
  const MonthPoint({required this.label, required this.invoicedMinor, required this.collectedMinor});

  final String label;
  final int invoicedMinor;
  final int collectedMinor;
}

class NamedTotal {
  const NamedTotal({required this.name, required this.minor});

  final String name;
  final int minor;
}

class DashboardFigures {
  const DashboardFigures({
    required this.currency,
    required this.invoicedMinor,
    required this.receivedMinor,
    required this.outstandingMinor,
    required this.overdueMinor,
    required this.excludedOtherCurrency,
    required this.months,
    required this.byService,
    required this.recentInvoiceIds,
    required this.recentPaymentIds,
  });

  final String currency;
  final int invoicedMinor;
  final int receivedMinor;
  final int outstandingMinor;
  final int overdueMinor;
  final int excludedOtherCurrency;
  final List<MonthPoint> months;
  final List<NamedTotal> byService;
  final List<String> recentInvoiceIds;
  final List<String> recentPaymentIds;
}

class ReportFigures {
  const ReportFigures({
    required this.currency,
    required this.invoiceCount,
    required this.invoicedMinor,
    required this.receivedMinor,
    required this.outstandingMinor,
    required this.overdueMinor,
    required this.paidCount,
    required this.partialCount,
    required this.overdueCount,
    required this.unpaidCount,
    required this.draftCount,
    required this.cancelledCount,
    required this.byService,
    required this.topCustomers,
    required this.months,
  });

  final String currency;
  final int invoiceCount;
  final int invoicedMinor;
  final int receivedMinor;
  final int outstandingMinor;
  final int overdueMinor;
  final int paidCount;
  final int partialCount;
  final int overdueCount;
  final int unpaidCount;
  final int draftCount;
  final int cancelledCount;
  final List<NamedTotal> byService;
  final List<NamedTotal> topCustomers;
  final List<MonthPoint> months;
}

enum ReportRange { today, week, month, year, custom }

({DateTime start, DateTime end}) rangeBounds(
  ReportRange range,
  DateTime now, {
  DateTime? customStart,
  DateTime? customEnd,
}) {
  final day = dateOnly(now);
  switch (range) {
    case ReportRange.today:
      return (start: day, end: day.add(const Duration(days: 1)));
    case ReportRange.week:
      final start = day.subtract(Duration(days: day.weekday - 1));
      return (start: start, end: start.add(const Duration(days: 7)));
    case ReportRange.month:
      final start = DateTime(day.year, day.month);
      return (start: start, end: DateTime(day.year, day.month + 1));
    case ReportRange.year:
      final start = DateTime(day.year);
      return (start: start, end: DateTime(day.year + 1));
    case ReportRange.custom:
      final start = dateOnly(customStart ?? day);
      final end = dateOnly(customEnd ?? day).add(const Duration(days: 1));
      return (start: start, end: end);
  }
}

bool _inRange(DateTime value, DateTime start, DateTime end) {
  final day = dateOnly(value);
  return !day.isBefore(start) && day.isBefore(end);
}

bool _countsAsIssued(InvoiceStatus status) =>
    status != InvoiceStatus.draft && status != InvoiceStatus.cancelled;

DashboardFigures dashboardFigures({
  required List<LedgerInvoice> invoices,
  required List<LedgerPayment> payments,
  required List<LedgerLine> lines,
  required String currency,
  required DateTime today,
}) {
  final mine = invoices.where((invoice) => invoice.currency == currency).toList();
  final excluded = invoices.where((invoice) => invoice.currency != currency).length;
  var invoiced = 0;
  var outstanding = 0;
  var overdue = 0;
  for (final invoice in mine) {
    final status = invoice.statusOn(today);
    if (!_countsAsIssued(status)) continue;
    invoiced += invoice.grandMinor;
    outstanding += invoice.outstandingOn(today);
    if (status == InvoiceStatus.overdue) overdue += invoice.outstandingOn(today);
  }
  final invoiceIds = mine.map((invoice) => invoice.id).toSet();
  var received = 0;
  for (final payment in payments) {
    if (invoiceIds.contains(payment.invoiceId) && payment.currency == currency) {
      received += payment.amountMinor;
    }
  }

  final months = <MonthPoint>[];
  for (var offset = 5; offset >= 0; offset--) {
    final month = DateTime(today.year, today.month - offset);
    final next = DateTime(month.year, month.month + 1);
    var monthInvoiced = 0;
    for (final invoice in mine) {
      final status = invoice.statusOn(today);
      if (!_countsAsIssued(status)) continue;
      if (_inRange(invoice.issueDate, month, next)) monthInvoiced += invoice.grandMinor;
    }
    var collected = 0;
    for (final payment in payments) {
      if (payment.currency != currency || !invoiceIds.contains(payment.invoiceId)) continue;
      if (_inRange(payment.paidAt, month, next)) collected += payment.amountMinor;
    }
    months.add(
      MonthPoint(
        label: _monthLabel(month),
        invoicedMinor: monthInvoiced,
        collectedMinor: collected,
      ),
    );
  }

  final serviceTotals = <String, int>{};
  final issuedIds = mine.where((invoice) => _countsAsIssued(invoice.statusOn(today))).map((e) => e.id).toSet();
  for (final line in lines) {
    if (!issuedIds.contains(line.invoiceId)) continue;
    serviceTotals[line.serviceName] = (serviceTotals[line.serviceName] ?? 0) + line.lineTotalMinor;
  }
  final byService = serviceTotals.entries.map((e) => NamedTotal(name: e.key, minor: e.value)).toList()
    ..sort((a, b) => b.minor.compareTo(a.minor));

  final recentInvoices = [...mine]..sort((a, b) => b.issueDate.compareTo(a.issueDate));
  final recentPayments = payments.where((p) => p.currency == currency).toList()
    ..sort((a, b) => b.paidAt.compareTo(a.paidAt));

  return DashboardFigures(
    currency: currency,
    invoicedMinor: invoiced,
    receivedMinor: received,
    outstandingMinor: outstanding,
    overdueMinor: overdue,
    excludedOtherCurrency: excluded,
    months: months,
    byService: byService.take(6).toList(),
    recentInvoiceIds: recentInvoices.take(5).map((e) => e.id).toList(),
    recentPaymentIds: recentPayments.take(5).map((e) => e.id).toList(),
  );
}

List<String> buildInsights({
  required DashboardFigures figures,
  required int invoiceCount,
}) {
  if (invoiceCount == 0) {
    return const ['Create your first invoice to see how the business is doing.'];
  }
  final insights = <String>[];
  if (figures.overdueMinor > 0) {
    insights.add(
      'You have ${formatMoney(figures.overdueMinor, figures.currency)} in overdue invoices.',
    );
  } else if (figures.outstandingMinor > 0) {
    insights.add('${formatMoney(figures.outstandingMinor, figures.currency)} is still outstanding.');
  }
  if (figures.months.length >= 2) {
    final current = figures.months.last.collectedMinor;
    final previous = figures.months[figures.months.length - 2].collectedMinor;
    if (current > previous && current > 0) {
      insights.add('Collections this month are ahead of last month.');
    }
  }
  if (figures.byService.isNotEmpty && figures.byService.first.minor > 0) {
    insights.add('${figures.byService.first.name} is your highest invoiced service.');
  }
  if (figures.excludedOtherCurrency > 0) {
    insights.add(
      '${figures.excludedOtherCurrency} invoice${figures.excludedOtherCurrency == 1 ? '' : 's'} in another currency are not included in these totals.',
    );
  }
  if (insights.isEmpty) {
    insights.add('Nothing is outstanding. New invoices will show up here.');
  }
  return insights;
}

ReportFigures reportFigures({
  required List<LedgerInvoice> invoices,
  required List<LedgerPayment> payments,
  required List<LedgerLine> lines,
  required String currency,
  required DateTime today,
  required DateTime start,
  required DateTime end,
}) {
  final inPeriod = invoices.where((invoice) {
    return invoice.currency == currency && _inRange(invoice.issueDate, start, end);
  }).toList();
  var invoiced = 0;
  var outstanding = 0;
  var overdueAmount = 0;
  var paid = 0;
  var partial = 0;
  var overdue = 0;
  var unpaid = 0;
  var drafts = 0;
  var cancelled = 0;
  var issued = 0;
  final customerTotals = <String, int>{};
  for (final invoice in inPeriod) {
    final status = invoice.statusOn(today);
    switch (status) {
      case InvoiceStatus.draft:
        drafts += 1;
      case InvoiceStatus.cancelled:
        cancelled += 1;
      case InvoiceStatus.paid:
        paid += 1;
        issued += 1;
        invoiced += invoice.grandMinor;
        customerTotals[invoice.customerName] =
            (customerTotals[invoice.customerName] ?? 0) + invoice.grandMinor;
      case InvoiceStatus.partial:
        partial += 1;
        issued += 1;
        invoiced += invoice.grandMinor;
        outstanding += invoice.outstandingOn(today);
        customerTotals[invoice.customerName] =
            (customerTotals[invoice.customerName] ?? 0) + invoice.grandMinor;
      case InvoiceStatus.overdue:
        overdue += 1;
        issued += 1;
        invoiced += invoice.grandMinor;
        outstanding += invoice.outstandingOn(today);
        overdueAmount += invoice.outstandingOn(today);
        customerTotals[invoice.customerName] =
            (customerTotals[invoice.customerName] ?? 0) + invoice.grandMinor;
      case InvoiceStatus.unpaid:
        unpaid += 1;
        issued += 1;
        invoiced += invoice.grandMinor;
        outstanding += invoice.outstandingOn(today);
        customerTotals[invoice.customerName] =
            (customerTotals[invoice.customerName] ?? 0) + invoice.grandMinor;
    }
  }
  final ids = inPeriod.map((invoice) => invoice.id).toSet();
  var received = 0;
  final monthCollected = <String, int>{};
  for (final payment in payments) {
    if (payment.currency != currency || !ids.contains(payment.invoiceId)) continue;
    if (!_inRange(payment.paidAt, start, end)) continue;
    received += payment.amountMinor;
    final key = _monthLabel(DateTime(payment.paidAt.year, payment.paidAt.month));
    monthCollected[key] = (monthCollected[key] ?? 0) + payment.amountMinor;
  }
  final issuedIds = inPeriod
      .where((invoice) => _countsAsIssued(invoice.statusOn(today)))
      .map((invoice) => invoice.id)
      .toSet();
  final serviceTotals = <String, int>{};
  for (final line in lines) {
    if (!issuedIds.contains(line.invoiceId)) continue;
    serviceTotals[line.serviceName] = (serviceTotals[line.serviceName] ?? 0) + line.lineTotalMinor;
  }
  final months = <MonthPoint>[];
  var cursor = DateTime(start.year, start.month);
  final last = DateTime(end.subtract(const Duration(days: 1)).year, end.subtract(const Duration(days: 1)).month);
  while (!cursor.isAfter(last)) {
    final label = _monthLabel(cursor);
    var monthInvoiced = 0;
    for (final invoice in inPeriod) {
      if (!_countsAsIssued(invoice.statusOn(today))) continue;
      if (invoice.issueDate.year == cursor.year && invoice.issueDate.month == cursor.month) {
        monthInvoiced += invoice.grandMinor;
      }
    }
    months.add(MonthPoint(label: label, invoicedMinor: monthInvoiced, collectedMinor: monthCollected[label] ?? 0));
    cursor = DateTime(cursor.year, cursor.month + 1);
  }
  final byService = serviceTotals.entries.map((e) => NamedTotal(name: e.key, minor: e.value)).toList()
    ..sort((a, b) => b.minor.compareTo(a.minor));
  final topCustomers = customerTotals.entries.map((e) => NamedTotal(name: e.key, minor: e.value)).toList()
    ..sort((a, b) => b.minor.compareTo(a.minor));
  return ReportFigures(
    currency: currency,
    invoiceCount: issued,
    invoicedMinor: invoiced,
    receivedMinor: received,
    outstandingMinor: outstanding,
    overdueMinor: overdueAmount,
    paidCount: paid,
    partialCount: partial,
    overdueCount: overdue,
    unpaidCount: unpaid,
    draftCount: drafts,
    cancelledCount: cancelled,
    byService: byService,
    topCustomers: topCustomers.take(8).toList(),
    months: months,
  );
}

String _monthLabel(DateTime month) {
  const names = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
  return '${names[month.month - 1]} ${month.year}';
}

class InvoiceQuery {
  const InvoiceQuery({this.chip = 'all', this.search = ''});

  final String chip;
  final String search;

  InvoiceQuery copyWith({String? chip, String? search}) =>
      InvoiceQuery(chip: chip ?? this.chip, search: search ?? this.search);
}

List<T> filterInvoices<T extends Object>({
  required List<T> invoices,
  required InvoiceQuery query,
  required InvoiceStatus Function(T invoice) status,
  required String Function(T invoice) customer,
  required String? Function(T invoice) number,
  required String Function(T invoice) service,
  required int Function(T invoice) grand,
  required int Function(T invoice) outstanding,
  required DateTime Function(T invoice) issued,
  required String Function(T invoice) currency,
}) {
  final chip = query.chip;
  final text = query.search.trim().toLowerCase();
  int? money;
  try {
    if (text.isNotEmpty) money = parseMoneyToMinor(text);
  } on Object {
    money = null;
  }
  return invoices.where((invoice) {
    final current = status(invoice);
    final chipOk = switch (chip) {
      'draft' => current == InvoiceStatus.draft,
      'unpaid' => current == InvoiceStatus.unpaid,
      'partial' =>
        current == InvoiceStatus.partial ||
            (current == InvoiceStatus.overdue && outstanding(invoice) < grand(invoice)),
      'paid' => current == InvoiceStatus.paid,
      'overdue' => current == InvoiceStatus.overdue,
      _ => true,
    };
    if (!chipOk) return false;
    if (text.isEmpty) return true;
    final haystack = [
      customer(invoice),
      number(invoice) ?? '',
      service(invoice),
      current.label,
      current.storage,
    ].join(' ').toLowerCase();
    if (haystack.contains(text)) return true;
    final iso = '${issued(invoice).year.toString().padLeft(4, '0')}-${issued(invoice).month.toString().padLeft(2, '0')}-${issued(invoice).day.toString().padLeft(2, '0')}';
    if (iso.contains(text) || iso == text) return true;
    if (money != null && (money == grand(invoice) || money == outstanding(invoice))) return true;
    return false;
  }).toList();
}
