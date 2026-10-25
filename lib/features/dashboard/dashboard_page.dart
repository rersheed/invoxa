import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../app/providers.dart';
import '../../core/format.dart';
import '../../core/invoicing/enums.dart';
import '../../core/invoicing/invoice_rules.dart';
import '../../core/money/money.dart';
import '../../core/reports/figures.dart';
import '../../core/theme/app_theme.dart';
import '../../core/widgets/ui.dart';
import '../../domain/models.dart';

class DashboardPage extends ConsumerStatefulWidget {
  const DashboardPage({super.key});

  @override
  ConsumerState<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends ConsumerState<DashboardPage> {
  late Future<_Dash> _future;

  @override
  void initState() {
    super.initState();
    _future = _load();
  }

  Future<_Dash> _load() async {
    final store = ref.read(storeProvider);
    final figures = await store.dashboard();
    final invoices = await store.listInvoices();
    final payments = await store.listPayments();
    final business = await store.business();
    final settings = await store.loadSettings();
    return _Dash(figures, invoices, payments, business, settings);
  }

  void _reload() => setState(() => _future = _load());

  @override
  Widget build(BuildContext context) {
    ref.listen<int>(revisionProvider, (_, _) => _reload());
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder<_Dash>(
          future: _future,
          builder: (context, snapshot) {
            if (snapshot.connectionState != ConnectionState.done) return const LoadingView();
            if (snapshot.hasError || snapshot.data == null) {
              return EmptyView(title: 'Dashboard unavailable', body: 'Try again.', action: 'Reload', onAction: _reload);
            }
            final data = snapshot.data!;
            final recentInvoices = [
              for (final id in data.figures.recentInvoiceIds)
                if (data.invoices.any((invoice) => invoice.id == id))
                  data.invoices.firstWhere((invoice) => invoice.id == id),
            ];
            final recentPayments = [
              for (final id in data.figures.recentPaymentIds)
                if (data.payments.any((payment) => payment.id == id))
                  data.payments.firstWhere((payment) => payment.id == id),
            ];
            return DashboardView(
              greeting: greetingFor(DateTime.now()),
              businessName: data.business?.displayName,
              figures: data.figures,
              insights: data.settings.insightEnabled
                  ? buildInsights(figures: data.figures, invoiceCount: data.invoices.length)
                  : const [],
              recentInvoices: recentInvoices,
              recentPayments: recentPayments,
              onInvoice: (id) => context.push('/invoices/$id'),
              onNewInvoice: () => context.push('/invoices/new'),
              onRecordPayment: () => context.push('/payments/record'),
              onCustomers: () => context.go('/customers'),
              onServices: () => context.push('/services'),
              onPayment: (id) => context.push('/receipts/$id'),
            );
          },
        ),
      ),
    );
  }
}

class _Dash {
  const _Dash(this.figures, this.invoices, this.payments, this.business, this.settings);
  final DashboardFigures figures;
  final List<InvoiceSummary> invoices;
  final List<PaymentItem> payments;
  final BusinessProfile? business;
  final AppSettingsData settings;
}

class DashboardView extends StatelessWidget {
  const DashboardView({
    super.key,
    required this.greeting,
    this.businessName,
    required this.figures,
    required this.insights,
    required this.recentInvoices,
    required this.recentPayments,
    required this.onInvoice,
    required this.onNewInvoice,
    required this.onRecordPayment,
    required this.onCustomers,
    required this.onServices,
    required this.onPayment,
  });

  final String greeting;
  final String? businessName;
  final DashboardFigures figures;
  final List<String> insights;
  final List<InvoiceSummary> recentInvoices;
  final List<PaymentItem> recentPayments;
  final ValueChanged<String> onInvoice;
  final VoidCallback onNewInvoice;
  final VoidCallback onRecordPayment;
  final VoidCallback onCustomers;
  final VoidCallback onServices;
  final ValueChanged<String> onPayment;

  @override
  Widget build(BuildContext context) {
    final muted = Theme.of(context).brightness == Brightness.dark ? InvoxaColors.darkMuted : InvoxaColors.muted;
    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 96),
      children: [
        Text(greeting, style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w700)),
        if ((businessName ?? '').isNotEmpty)
          Text(businessName!, style: TextStyle(color: muted, fontSize: 16)),
        const SizedBox(height: 4),
        Text("Here's how your business is doing.", style: TextStyle(color: muted, fontSize: 16)),
        const SizedBox(height: 16),
        GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          childAspectRatio: 1.35,
          children: [
            _Stat('Total invoiced', formatMoney(figures.invoicedMinor, figures.currency), InvoxaColors.navy),
            _Stat('Total received', formatMoney(figures.receivedMinor, figures.currency), InvoxaColors.emerald),
            _Stat('Outstanding', formatMoney(figures.outstandingMinor, figures.currency), InvoxaColors.amber),
            _Stat('Overdue', formatMoney(figures.overdueMinor, figures.currency), InvoxaColors.overdue),
          ],
        ),
        const SizedBox(height: 8),
        Text('Invoiced and received are kept separate. Received is money you recorded, not a bank check.', style: TextStyle(color: muted, fontSize: 13)),
        const SizedBox(height: 16),
        const SectionTitle('Quick actions'),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            ActionChip(label: const Text('New invoice'), onPressed: onNewInvoice),
            ActionChip(label: const Text('Record payment'), onPressed: onRecordPayment),
            ActionChip(label: const Text('Customers'), onPressed: onCustomers),
            ActionChip(label: const Text('Services'), onPressed: onServices),
          ],
        ),
        if (insights.isNotEmpty) ...[
          const SectionTitle('Insights'),
          for (final insight in insights)
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: InvoxaCard(child: Text(insight)),
            ),
        ],
        const SectionTitle('This year, month by month'),
        InvoxaCard(child: _Chart(months: figures.months)),
        const SizedBox(height: 8),
        Text('Navy is invoiced. Green is collected.', style: TextStyle(color: muted, fontSize: 13)),
        const SectionTitle('Revenue by service'),
        if (figures.byService.isEmpty || figures.byService.every((item) => item.minor == 0))
          const InvoxaCard(child: Text('Service totals appear after you issue an invoice.'))
        else
          InvoxaCard(
            child: Column(
              children: [
                for (final item in figures.byService)
                  if (item.minor > 0)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: _ServiceBar(name: item.name, amount: formatMoney(item.minor, figures.currency), share: item.minor / figures.invoicedMinor.clamp(1, 1 << 62)),
                    ),
              ],
            ),
          ),
        const SectionTitle('Recent invoices'),
        if (recentInvoices.isEmpty)
          const InvoxaCard(child: Text('Your first invoice will show up here.'))
        else
          for (final invoice in recentInvoices)
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: InvoxaCard(
                onTap: () => onInvoice(invoice.id),
                child: _InvoiceRow(invoice: invoice),
              ),
            ),
        const SectionTitle('Recent payments'),
        if (recentPayments.isEmpty)
          const InvoxaCard(child: Text('Recorded payments show up here. They are not verified with a bank.'))
        else
          for (final payment in recentPayments)
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: InvoxaCard(
                onTap: () => onPayment(payment.id),
                child: Row(
                  children: [
                    Expanded(child: Text('${payment.customerName}\n${payment.method.label}')),
                    Text(formatMoney(payment.amountMinor, payment.currency), style: const TextStyle(fontWeight: FontWeight.w700, color: InvoxaColors.emerald)),
                  ],
                ),
              ),
            ),
      ],
    );
  }
}

class _Stat extends StatelessWidget {
  const _Stat(this.label, this.value, this.color);
  final String label;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return InvoxaCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(label, style: const TextStyle(fontSize: 13)),
          const SizedBox(height: 8),
          FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerLeft,
            child: Text(value, maxLines: 1, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: color)),
          ),
        ],
      ),
    );
  }
}

class _InvoiceRow extends StatelessWidget {
  const _InvoiceRow({required this.invoice});
  final InvoiceSummary invoice;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(invoice.customerName, style: const TextStyle(fontWeight: FontWeight.w600)),
              Text('${invoice.number ?? 'Draft'} · ${formatLongDate(invoice.issueDate)}'),
            ],
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(formatMoney(invoice.grandMinor, invoice.currency), style: const TextStyle(fontWeight: FontWeight.w700)),
            const SizedBox(height: 4),
            StatusBadge(status: invoice.status),
          ],
        ),
      ],
    );
  }
}

class _Chart extends StatelessWidget {
  const _Chart({required this.months});
  final List<MonthPoint> months;

  @override
  Widget build(BuildContext context) {
    final maxMinor = months.fold<int>(0, (max, month) {
      final local = month.invoicedMinor > month.collectedMinor ? month.invoicedMinor : month.collectedMinor;
      return local > max ? local : max;
    });
    return SizedBox(
      height: 180,
      child: BarChart(
        BarChartData(
          maxY: maxMinor == 0 ? 1 : maxMinor / 100 * 1.25,
          gridData: const FlGridData(show: false),
          borderData: FlBorderData(show: false),
          barGroups: [
            for (var index = 0; index < months.length; index++)
              BarChartGroupData(
                x: index,
                barsSpace: 3,
                barRods: [
                  BarChartRodData(
                    toY: months[index].invoicedMinor / 100,
                    color: InvoxaColors.navy,
                    width: 7,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  BarChartRodData(
                    toY: months[index].collectedMinor / 100,
                    color: InvoxaColors.emerald,
                    width: 7,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ],
              ),
          ],
          titlesData: FlTitlesData(
            leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 28,
                getTitlesWidget: (value, meta) {
                  final index = value.toInt();
                  if (index < 0 || index >= months.length) return const SizedBox.shrink();
                  return Padding(
                    padding: const EdgeInsets.only(top: 6),
                    child: Text(months[index].label.split(' ').first, style: const TextStyle(fontSize: 11)),
                  );
                },
              ),
            ),
          ),
        ),
        duration: const Duration(milliseconds: 250),
      ),
    );
  }
}

class _ServiceBar extends StatelessWidget {
  const _ServiceBar({required this.name, required this.amount, required this.share});
  final String name;
  final String amount;
  final double share;

  @override
  Widget build(BuildContext context) {
    final width = share.isNaN || share < 0 ? 0.0 : (share > 1 ? 1.0 : share);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(children: [Expanded(child: Text(name)), Text(amount, style: const TextStyle(fontWeight: FontWeight.w600))]),
        const SizedBox(height: 6),
        ClipRRect(
          borderRadius: BorderRadius.circular(6),
          child: LinearProgressIndicator(value: width, minHeight: 8, color: InvoxaColors.emerald, backgroundColor: const Color(0xFFE7EDF8)),
        ),
      ],
    );
  }
}
