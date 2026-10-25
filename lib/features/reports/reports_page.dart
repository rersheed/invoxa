import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/providers.dart';
import '../../core/format.dart';
import '../../core/money/money.dart';
import '../../core/pdf/document_pdf.dart';
import '../../core/reports/figures.dart';
import '../../core/widgets/ui.dart';
import '../shared/support.dart';

class ReportsPage extends ConsumerStatefulWidget {
  const ReportsPage({super.key});

  @override
  ConsumerState<ReportsPage> createState() => _ReportsPageState();
}

class _ReportsPageState extends ConsumerState<ReportsPage> {
  ReportRange _range = ReportRange.month;
  DateTime? _start;
  DateTime? _end;
  late Future<ReportFigures> _future;

  @override
  void initState() {
    super.initState();
    _future = _load();
  }

  Future<ReportFigures> _load() {
    return ref.read(storeProvider).report(_range, customStart: _start, customEnd: _end);
  }

  void _reload() => setState(() => _future = _load());

  Future<void> _pickCustom() async {
    final now = DateTime.now();
    final start = await showDatePicker(context: context, initialDate: _start ?? now, firstDate: DateTime(2020), lastDate: DateTime(2100));
    if (start == null || !mounted) return;
    final end = await showDatePicker(context: context, initialDate: _end ?? start, firstDate: start, lastDate: DateTime(2100));
    if (end == null) return;
    setState(() {
      _range = ReportRange.custom;
      _start = start;
      _end = end;
      _future = _load();
    });
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<int>(revisionProvider, (_, _) => _reload());
    return PageScaffold(
      title: 'Reports',
      body: FutureBuilder<ReportFigures>(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) return const LoadingView();
          final figures = snapshot.data;
          if (figures == null) {
            return EmptyView(title: 'Report unavailable', body: 'Try again.', action: 'Reload', onAction: _reload);
          }
          final rangeLabel = switch (_range) {
            ReportRange.today => 'Today',
            ReportRange.week => 'This week',
            ReportRange.month => 'This month',
            ReportRange.year => 'This year',
            ReportRange.custom => '${_start == null ? '' : formatIsoDate(_start!)} – ${_end == null ? '' : formatIsoDate(_end!)}',
          };
          return ListView(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 96),
            children: [
              Wrap(
                spacing: 8,
                children: [
                  for (final item in const [
                    (ReportRange.today, 'Today'),
                    (ReportRange.week, 'Week'),
                    (ReportRange.month, 'Month'),
                    (ReportRange.year, 'Year'),
                  ])
                    ChoiceChip(
                      label: Text(item.$2),
                      selected: _range == item.$1,
                      onSelected: (_) => setState(() {
                        _range = item.$1;
                        _future = _load();
                      }),
                    ),
                  ChoiceChip(label: const Text('Custom'), selected: _range == ReportRange.custom, onSelected: (_) => _pickCustom()),
                ],
              ),
              const SizedBox(height: 12),
              Text(rangeLabel, style: const TextStyle(fontWeight: FontWeight.w600)),
              const SizedBox(height: 12),
              _grid(figures),
              const SectionTitle('Counts'),
              InvoxaCard(
                child: Column(
                  children: [
                    _line('Invoices', '${figures.invoiceCount}'),
                    _line('Paid', '${figures.paidCount}'),
                    _line('Partially paid', '${figures.partialCount}'),
                    _line('Unpaid', '${figures.unpaidCount}'),
                    _line('Overdue', '${figures.overdueCount}'),
                    _line('Drafts', '${figures.draftCount}'),
                    _line('Cancelled', '${figures.cancelledCount}'),
                  ],
                ),
              ),
              const SectionTitle('Revenue by service'),
              InvoxaCard(
                child: figures.byService.isEmpty
                    ? const Text('No issued invoices in this period.')
                    : Column(
                        children: [
                          for (final item in figures.byService) _line(item.name, formatMoney(item.minor, figures.currency)),
                        ],
                      ),
              ),
              const SectionTitle('Top customers'),
              InvoxaCard(
                child: figures.topCustomers.isEmpty
                    ? const Text('No customers in this period.')
                    : Column(
                        children: [
                          for (final item in figures.topCustomers) _line(item.name, formatMoney(item.minor, figures.currency)),
                        ],
                      ),
              ),
              const SectionTitle('Monthly collections'),
              InvoxaCard(
                child: Column(
                  children: [
                    for (final month in figures.months)
                      _line(month.label, formatMoney(month.collectedMinor, figures.currency)),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              FilledButton(
                onPressed: () => _exportPdf(figures, rangeLabel),
                child: const Text('Export PDF'),
              ),
              const SizedBox(height: 8),
              OutlinedButton(onPressed: _exportCsv, child: const Text('Export CSV')),
            ],
          );
        },
      ),
    );
  }

  Widget _grid(ReportFigures figures) {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 12,
      crossAxisSpacing: 12,
      childAspectRatio: 1.4,
      children: [
        _tile('Invoiced', formatMoney(figures.invoicedMinor, figures.currency)),
        _tile('Received', formatMoney(figures.receivedMinor, figures.currency)),
        _tile('Outstanding', formatMoney(figures.outstandingMinor, figures.currency)),
        _tile('Overdue', formatMoney(figures.overdueMinor, figures.currency)),
      ],
    );
  }

  Widget _tile(String label, String value) {
    return InvoxaCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(label),
          const SizedBox(height: 6),
          Text(value, style: const TextStyle(fontWeight: FontWeight.w700)),
        ],
      ),
    );
  }

  Widget _line(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(children: [Expanded(child: Text(label)), Text(value, style: const TextStyle(fontWeight: FontWeight.w600))]),
    );
  }

  Future<void> _exportPdf(ReportFigures figures, String rangeLabel) async {
    final business = await ref.read(storeProvider).business();
    await pdfFonts.load();
    final bytes = await buildReportPdf(
      data: ReportPdfData(
        title: 'INVOXA report',
        rangeLabel: rangeLabel,
        businessName: business?.displayName ?? 'Business',
        rows: [
          ('Invoiced', formatMoney(figures.invoicedMinor, figures.currency)),
          ('Received', formatMoney(figures.receivedMinor, figures.currency)),
          ('Outstanding', formatMoney(figures.outstandingMinor, figures.currency)),
          ('Overdue', formatMoney(figures.overdueMinor, figures.currency)),
        ],
        sections: [
          (
            'By service',
            [
              for (final item in figures.byService) (item.name, formatMoney(item.minor, figures.currency)),
            ],
          ),
          (
            'Top customers',
            [
              for (final item in figures.topCustomers) (item.name, formatMoney(item.minor, figures.currency)),
            ],
          ),
        ],
      ),
      regularFont: pdfFonts.regular!,
      boldFont: pdfFonts.bold!,
    );
    if (!mounted) return;
    await shareFile(bytes, 'INVOXA-report.pdf', 'application/pdf');
  }

  Future<void> _exportCsv() async {
    final csv = await ref.read(storeProvider).exportInvoicesCsv();
    await shareFile(Uint8List.fromList(utf8.encode(csv)), 'INVOXA-invoices.csv', 'text/csv');
  }
}
