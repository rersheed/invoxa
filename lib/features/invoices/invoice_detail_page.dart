import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:printing/printing.dart';

import '../../app/providers.dart';
import '../../core/format.dart';
import '../../core/invoicing/enums.dart';
import '../../core/messaging/messages.dart';
import '../../core/money/money.dart';
import '../../core/widgets/ui.dart';
import '../../data/invoxa_store.dart';
import '../../domain/models.dart';
import '../shared/support.dart';

class InvoiceDetailPage extends ConsumerStatefulWidget {
  const InvoiceDetailPage({super.key, required this.id});

  final String id;

  @override
  ConsumerState<InvoiceDetailPage> createState() => _InvoiceDetailPageState();
}

class _InvoiceDetailPageState extends ConsumerState<InvoiceDetailPage> {
  late Future<InvoiceDetail> _future;

  @override
  void initState() {
    super.initState();
    _future = ref.read(storeProvider).invoice(widget.id);
  }

  void _reload() => setState(() => _future = ref.read(storeProvider).invoice(widget.id));

  @override
  Widget build(BuildContext context) {
    ref.listen<int>(revisionProvider, (_, _) => _reload());
    return FutureBuilder<InvoiceDetail>(
      future: _future,
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const Scaffold(body: LoadingView());
        }
        if (snapshot.hasError || snapshot.data == null) {
          return PageScaffold(
            title: 'Invoice',
            body: EmptyView(title: 'Invoice unavailable', body: 'It may have been removed.', action: 'Back', onAction: () => context.pop()),
          );
        }
        final invoice = snapshot.data!;
        final issued = invoice.status != InvoiceStatus.draft && invoice.status != InvoiceStatus.cancelled;
        return PageScaffold(
          title: invoice.number ?? 'Draft',
          actions: [StatusBadge(status: invoice.status), const SizedBox(width: 12)],
          body: ListView(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 32),
            children: [
              Text(invoice.customerName, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w700)),
              const SizedBox(height: 4),
              Text('${formatLongDate(invoice.issueDate)} · Due ${formatLongDate(invoice.dueDate)}'),
              if (invoice.brandingNote.isNotEmpty) ...[
                const SizedBox(height: 8),
                Text(invoice.brandingNote),
              ],
              const SizedBox(height: 16),
              InvoxaCard(
                child: Column(
                  children: [
                    for (final line in invoice.lines)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Text('${line.name}\n${formatQuantity(line.quantityMilli)} ${unitLabel(line.unit, line.customUnit)} × ${formatMoney(line.unitPriceMinor, invoice.currency)}'),
                            ),
                            Text(formatMoney(line.lineTotalMinor, invoice.currency), style: const TextStyle(fontWeight: FontWeight.w600)),
                          ],
                        ),
                      ),
                    const Divider(),
                    _row('Grand total', formatMoney(invoice.grandMinor, invoice.currency)),
                    _row('Paid', formatMoney(invoice.paidMinor, invoice.currency)),
                    _row('Outstanding', formatMoney(invoice.outstandingMinor, invoice.currency)),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              const Text('Statuses are recorded by you. INVOXA does not check your bank.'),
              const SizedBox(height: 12),
              _action('View PDF', () => context.push('/invoices/${invoice.id}/preview')),
              _action('Share PDF', () async {
                final bytes = await guard(context, () => invoicePdfBytes(invoice));
                if (bytes == null) return;
                await shareFile(bytes, '${invoice.number ?? 'draft'}.pdf', 'application/pdf');
              }),
              _action('WhatsApp message', () => _message(invoice, TemplateType.invoice)),
              if (invoice.status != InvoiceStatus.cancelled)
                _action('Edit', () async {
                  await context.push('/invoices/${invoice.id}/edit');
                  _reload();
                }),
              _action('Duplicate', () async {
                final copy = await guard(context, () => ref.read(storeProvider).duplicateInvoice(invoice.id));
                if (copy == null || !context.mounted) return;
                refresh(ref);
                if (!context.mounted) return;
                context.push('/invoices/${copy.id}/edit');
              }),
              if (issued && invoice.outstandingMinor > 0)
                _action('Record payment', () => context.push('/invoices/${invoice.id}/pay')),
              if (issued) _action('Reminders', () => context.push('/invoices/${invoice.id}/reminders')),
              if (invoice.receipts.isNotEmpty)
                _action('Receipt', () => context.push('/receipts/${invoice.payments.last.id}')),
              _action('History', () => context.push('/invoices/${invoice.id}/history')),
              if (invoice.status == InvoiceStatus.draft)
                _action('Delete draft', () async {
                  final ok = await confirmAction(
                    context,
                    title: 'Delete this draft?',
                    body: 'A draft with no payments can be deleted. Issued invoices stay on record.',
                    confirm: 'Delete',
                    destructive: true,
                  );
                  if (!ok || !context.mounted) return;
                  final removed = await guard(context, () async {
                    await ref.read(storeProvider).deleteDraft(invoice.id);
                    return true;
                  });
                  if (removed != null && context.mounted) {
                    refresh(ref);
                    context.pop();
                  }
                }, destructive: true),
              if (issued)
                _action('Cancel invoice', () async {
                  final ok = await confirmAction(
                    context,
                    title: 'Cancel this invoice?',
                    body: 'The invoice and any payments stay on record. Scheduled reminders stop.',
                    confirm: 'Cancel invoice',
                    destructive: true,
                  );
                  if (!ok || !context.mounted) return;
                  final cancelled = await guard(context, () async {
                    await ref.read(storeProvider).cancelInvoice(invoice.id);
                    return true;
                  });
                  if (cancelled != null && context.mounted) {
                    refresh(ref);
                    _reload();
                  }
                }, destructive: true),
            ],
          ),
        );
      },
    );
  }

  Widget _row(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(children: [Expanded(child: Text(label)), Text(value, style: const TextStyle(fontWeight: FontWeight.w700))]),
    );
  }

  Widget _action(String label, VoidCallback onTap, {bool destructive = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: SizedBox(
        width: double.infinity,
        height: 52,
        child: OutlinedButton(
          onPressed: onTap,
          child: Text(label, style: TextStyle(color: destructive ? const Color(0xFF9C2F2F) : null)),
        ),
      ),
    );
  }

  Future<void> _message(InvoiceDetail invoice, TemplateType type) async {
    final store = ref.read(storeProvider);
    final business = await store.business();
    final template = await store.templateFor(type);
    final brand = invoice.brandSnapshot;
    final name = brand?['tradingName']?.toString().trim().isNotEmpty == true
        ? brand!['tradingName'].toString()
        : (business?.displayName ?? 'INVOXA');
    final phone = brand?['phone']?.toString() ?? business?.phone ?? '';
    final input = messageInput(invoice, businessName: name, phone: phone);
    final text = renderTemplate(template.body, input.placeholders);
    if (!mounted) return;
    await showMessageSheet(
      context,
      title: 'Invoice message',
      initial: text,
      whatsapp: invoice.customerWhatsapp.isEmpty ? invoice.customerPhone : invoice.customerWhatsapp,
    );
  }
}

class InvoicePreviewPage extends ConsumerWidget {
  const InvoicePreviewPage({super.key, required this.id});

  final String id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FutureBuilder<InvoiceDetail>(
      future: ref.read(storeProvider).invoice(id),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const Scaffold(body: LoadingView());
        final invoice = snapshot.data!;
        return Scaffold(
          appBar: AppBar(
            title: Text(invoice.number ?? 'Draft'),
            actions: [
              IconButton(
                tooltip: 'Save PDF',
                onPressed: () async {
                  final bytes = await guard(context, () => invoicePdfBytes(invoice));
                  if (bytes == null || !context.mounted) return;
                  final saved = await saveFile(bytes, '${invoice.number ?? 'draft'}.pdf', 'application/pdf');
                  if (context.mounted) showNotice(context, saved ? 'PDF saved.' : 'Save cancelled.');
                },
                icon: const Icon(Icons.download_outlined),
              ),
              IconButton(
                tooltip: 'Share PDF',
                onPressed: () async {
                  final bytes = await guard(context, () => invoicePdfBytes(invoice));
                  if (bytes == null) return;
                  await shareFile(bytes, '${invoice.number ?? 'draft'}.pdf', 'application/pdf');
                },
                icon: const Icon(Icons.share_outlined),
              ),
            ],
          ),
          body: PdfPreview(
            build: (format) => invoicePdfBytes(invoice),
            pdfFileName: '${invoice.number ?? 'draft'}.pdf',
            canChangeOrientation: false,
            canChangePageFormat: false,
            allowPrinting: true,
            allowSharing: false,
          ),
        );
      },
    );
  }
}

class InvoiceHistoryPage extends ConsumerWidget {
  const InvoiceHistoryPage({super.key, required this.id});

  final String id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FutureBuilder<InvoiceDetail>(
      future: ref.read(storeProvider).invoice(id),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const Scaffold(body: LoadingView());
        final events = historyFor(snapshot.data!);
        return PageScaffold(
          title: 'History',
          body: ListView(
            padding: const EdgeInsets.all(20),
            children: [
              const Text('This is the record kept on this phone. Cancelling or editing does not erase payments.'),
              const SizedBox(height: 12),
              for (final event in events)
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(event.title),
                  subtitle: Text('${formatLongDate(event.at)} · ${event.detail}'),
                ),
            ],
          ),
        );
      },
    );
  }
}
