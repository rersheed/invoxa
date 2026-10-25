import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../app/providers.dart';
import '../../core/format.dart';
import '../../core/money/money.dart';
import '../../core/reports/figures.dart';
import '../../core/widgets/ui.dart';
import '../../domain/models.dart';

class InvoiceListPage extends ConsumerStatefulWidget {
  const InvoiceListPage({super.key});

  @override
  ConsumerState<InvoiceListPage> createState() => _InvoiceListPageState();
}

class _InvoiceListPageState extends ConsumerState<InvoiceListPage> {
  late Future<List<InvoiceSummary>> _future;
  String _chip = 'all';
  final _search = TextEditingController();

  @override
  void initState() {
    super.initState();
    _future = ref.read(storeProvider).listInvoices();
  }

  void _reload() => setState(() => _future = ref.read(storeProvider).listInvoices());

  @override
  void dispose() {
    _search.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<int>(revisionProvider, (_, _) => _reload());
    return PageScaffold(
      title: 'Invoices',
      body: FutureBuilder<List<InvoiceSummary>>(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) return const LoadingView();
          final invoices = snapshot.data ?? const <InvoiceSummary>[];
          final visible = filterInvoices(
            invoices: invoices,
            query: InvoiceQuery(chip: _chip, search: _search.text),
            status: (invoice) => invoice.status,
            customer: (invoice) => invoice.customerName,
            number: (invoice) => invoice.number,
            service: (invoice) => invoice.serviceLabel,
            grand: (invoice) => invoice.grandMinor,
            outstanding: (invoice) => invoice.outstandingMinor,
            issued: (invoice) => invoice.issueDate,
            currency: (invoice) => invoice.currency,
          );
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 0),
                child: TextField(
                  controller: _search,
                  onChanged: (_) => setState(() {}),
                  decoration: const InputDecoration(
                    hintText: 'Search name, number, service, amount, or date',
                    prefixIcon: Icon(Icons.search),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              SizedBox(
                height: 48,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  children: [
                    for (final chip in const [('all', 'All'), ('draft', 'Draft'), ('unpaid', 'Unpaid'), ('partial', 'Partial'), ('paid', 'Paid'), ('overdue', 'Overdue')])
                      Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: ChoiceChip(
                          label: Text(chip.$2),
                          selected: _chip == chip.$1,
                          onSelected: (_) => setState(() => _chip = chip.$1),
                        ),
                      ),
                  ],
                ),
              ),
              Expanded(
                child: visible.isEmpty
                    ? EmptyView(
                        title: invoices.isEmpty ? 'No invoices yet' : 'Nothing matches',
                        body: invoices.isEmpty
                            ? 'A basic invoice takes a customer, a service, and a price.'
                            : 'Try another filter or search.',
                        action: invoices.isEmpty ? 'New invoice' : null,
                        onAction: invoices.isEmpty ? () => context.push('/invoices/new') : null,
                        icon: Icons.receipt_long_outlined,
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.fromLTRB(20, 8, 20, 96),
                        itemCount: visible.length,
                        itemBuilder: (context, index) {
                          final invoice = visible[index];
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: InvoxaCard(
                              onTap: () => context.push('/invoices/${invoice.id}'),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(invoice.customerName, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
                                        const SizedBox(height: 4),
                                        Text('${invoice.number ?? 'Draft'} · ${formatLongDate(invoice.issueDate)}'),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(formatMoney(invoice.grandMinor, invoice.currency), style: const TextStyle(fontWeight: FontWeight.w700)),
                                      const SizedBox(height: 6),
                                      StatusBadge(status: invoice.status),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
              ),
            ],
          );
        },
      ),
    );
  }
}
