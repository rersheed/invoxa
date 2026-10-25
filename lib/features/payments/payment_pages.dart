import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:printing/printing.dart';
import 'package:uuid/uuid.dart';

import '../../app/providers.dart';
import '../../core/format.dart';
import '../../core/invoicing/enums.dart';
import '../../core/messaging/messages.dart';
import '../../core/money/money.dart';
import '../../core/widgets/ui.dart';
import '../../domain/models.dart';
import '../shared/support.dart';

class RecordPaymentPage extends ConsumerStatefulWidget {
  const RecordPaymentPage({super.key, this.invoiceId});

  final String? invoiceId;

  @override
  ConsumerState<RecordPaymentPage> createState() => _RecordPaymentPageState();
}

class _RecordPaymentPageState extends ConsumerState<RecordPaymentPage> {
  final _amount = TextEditingController();
  final _reference = TextEditingController();
  final _notes = TextEditingController();
  final _idempotency = const Uuid().v4();
  DateTime _date = DateTime.now();
  PaymentMethod _method = PaymentMethod.bankTransfer;
  String? _bankId;
  String? _invoiceId;
  List<InvoiceSummary> _open = const [];
  List<BankAccount> _banks = const [];
  List<PaymentMethod> _methods = PaymentMethod.values;
  var _loading = true;
  var _saving = false;

  @override
  void initState() {
    super.initState();
    _invoiceId = widget.invoiceId;
    _load();
  }

  Future<void> _load() async {
    final store = ref.read(storeProvider);
    final invoices = await store.listInvoices();
    final settings = await store.loadSettings();
    _banks = await store.bankAccounts(activeOnly: true);
    _methods = settings.paymentMethods.isEmpty ? PaymentMethod.values : settings.paymentMethods;
    _method = _methods.first;
    _open = invoices.where((invoice) {
      return invoice.status != InvoiceStatus.draft &&
          invoice.status != InvoiceStatus.cancelled &&
          invoice.status != InvoiceStatus.paid &&
          invoice.outstandingMinor > 0;
    }).toList();
    if (_invoiceId != null) {
      final invoice = invoices.where((item) => item.id == _invoiceId).firstOrNull;
      if (invoice != null) _amount.text = minorInput(invoice.outstandingMinor);
    }
    _bankId = _banks.where((bank) => bank.isDefault).map((bank) => bank.id).firstOrNull;
    if (mounted) setState(() => _loading = false);
  }

  @override
  void dispose() {
    _amount.dispose();
    _reference.dispose();
    _notes.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (_saving || _invoiceId == null) {
      if (_invoiceId == null) showNotice(context, 'Choose an invoice.');
      return;
    }
    setState(() => _saving = true);
    final recorded = await guard(context, () {
      return ref.read(storeProvider).recordPayment(
        invoiceId: _invoiceId!,
        amountMinor: parseMoneyToMinor(_amount.text),
        paidAt: _date,
        method: _method,
        idempotencyKey: _idempotency,
        bankAccountId: _bankId,
        reference: _reference.text,
        notes: _notes.text,
      );
    });
    if (!mounted) return;
    setState(() => _saving = false);
    if (recorded == null) return;
    refresh(ref);
    if (recorded.fullyPaid) {
      final invoice = await ref.read(storeProvider).invoice(_invoiceId!);
      if (!mounted) return;
      final send = await confirmAction(
        context,
        title: 'Marked paid',
        body: 'A receipt is ready. Send a WhatsApp acknowledgement? INVOXA does not contact the bank.',
        confirm: 'Prepare message',
      );
      if (send && mounted) {
        final business = await ref.read(storeProvider).business();
        final template = await ref.read(storeProvider).templateFor(TemplateType.confirmation);
        final input = messageInput(
          invoice,
          businessName: business?.displayName ?? 'INVOXA',
          phone: business?.phone ?? '',
          amountMinor: recorded.payment.amountMinor,
        );
        if (!mounted) return;
        await showMessageSheet(
          context,
          title: 'Payment acknowledgement',
          initial: renderTemplate(template.body, input.placeholders),
          whatsapp: invoice.customerWhatsapp.isEmpty ? invoice.customerPhone : invoice.customerWhatsapp,
        );
      }
    }
    if (mounted) context.go('/receipts/${recorded.payment.id}');
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) return const Scaffold(body: LoadingView());
    return PageScaffold(
      title: 'Record payment',
      bottom: FilledButton(onPressed: _saving ? null : _save, child: const Text('Save payment')),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
        children: [
          const InvoxaCard(
            child: Text('This payment is recorded on your phone. INVOXA does not verify it with a bank, and a second tap will not record it twice.'),
          ),
          const SizedBox(height: 12),
          if (widget.invoiceId == null) ...[
            const SectionTitle('Invoice'),
            if (_open.isEmpty)
              const Text('There is no unpaid invoice to record against.')
            else
              RadioGroup<String>(
                groupValue: _invoiceId,
                onChanged: (value) => setState(() {
                  _invoiceId = value;
                  final selected = _open.where((item) => item.id == value).firstOrNull;
                  if (selected != null) _amount.text = minorInput(selected.outstandingMinor);
                }),
                child: Column(
                  children: [
                    for (final invoice in _open)
                      RadioListTile<String>(
                        value: invoice.id,
                        title: Text(invoice.customerName),
                        subtitle: Text('${invoice.number ?? 'Invoice'} · ${formatMoney(invoice.outstandingMinor, invoice.currency)} outstanding'),
                      ),
                  ],
                ),
              ),
          ],
          InvoxaField(label: 'Amount', controller: _amount, keyboardType: const TextInputType.numberWithOptions(decimal: true)),
          ListTile(
            contentPadding: EdgeInsets.zero,
            title: const Text('Date'),
            subtitle: Text(formatLongDate(_date)),
            onTap: () async {
              final picked = await showDatePicker(context: context, initialDate: _date, firstDate: DateTime(2020), lastDate: DateTime(2100));
              if (picked != null) setState(() => _date = picked);
            },
          ),
          DropdownButtonFormField<PaymentMethod>(
            initialValue: _methods.contains(_method) ? _method : _methods.first,
            decoration: const InputDecoration(labelText: 'Method'),
            items: [for (final method in _methods) DropdownMenuItem(value: method, child: Text(method.label))],
            onChanged: (value) => setState(() => _method = value ?? PaymentMethod.other),
          ),
          const SizedBox(height: 12),
          if (_banks.isNotEmpty)
            DropdownButtonFormField<String?>(
              initialValue: _banks.any((bank) => bank.id == _bankId) ? _bankId : null,
              decoration: const InputDecoration(labelText: 'Bank account'),
              items: [
                const DropdownMenuItem<String?>(value: null, child: Text('Not tied to an account')),
                for (final bank in _banks) DropdownMenuItem(value: bank.id, child: Text(bank.displayLabel)),
              ],
              onChanged: (value) => setState(() => _bankId = value),
            ),
          const SizedBox(height: 12),
          InvoxaField(label: 'Reference (optional)', controller: _reference),
          InvoxaField(label: 'Notes (optional)', controller: _notes, maxLines: 3),
        ],
      ),
    );
  }
}

class PaymentHistoryPage extends ConsumerStatefulWidget {
  const PaymentHistoryPage({super.key});

  @override
  ConsumerState<PaymentHistoryPage> createState() => _PaymentHistoryPageState();
}

class _PaymentHistoryPageState extends ConsumerState<PaymentHistoryPage> {
  late Future<List<PaymentItem>> _future;

  @override
  void initState() {
    super.initState();
    _future = ref.read(storeProvider).listPayments();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<int>(revisionProvider, (_, _) {
      setState(() => _future = ref.read(storeProvider).listPayments());
    });
    return PageScaffold(
      title: 'Payments',
      body: FutureBuilder<List<PaymentItem>>(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) return const LoadingView();
          final payments = snapshot.data ?? const <PaymentItem>[];
          if (payments.isEmpty) {
            return const EmptyView(
              title: 'No payments yet',
              body: 'Each payment is its own record. Nothing here is confirmed by a bank.',
              icon: Icons.payments_outlined,
            );
          }
          return ListView.builder(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
            itemCount: payments.length,
            itemBuilder: (context, index) {
              final payment = payments[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: InvoxaCard(
                  onTap: () => context.push('/receipts/${payment.id}'),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(payment.customerName, style: const TextStyle(fontWeight: FontWeight.w600)),
                            Text('${payment.invoiceNumber ?? 'Invoice'} · ${formatLongDate(payment.paidAt)} · ${payment.method.label}'),
                          ],
                        ),
                      ),
                      Text(formatMoney(payment.amountMinor, payment.currency), style: const TextStyle(fontWeight: FontWeight.w700)),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class ReceiptPreviewPage extends ConsumerWidget {
  const ReceiptPreviewPage({super.key, required this.paymentId});

  final String paymentId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FutureBuilder(
      future: () async {
        final store = ref.read(storeProvider);
        final receipt = await store.receiptForPayment(paymentId);
        if (receipt == null) return null;
        final invoice = await store.invoice(receipt.invoiceId);
        return (receipt: receipt, invoice: invoice);
      }(),
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) return const Scaffold(body: LoadingView());
        final data = snapshot.data;
        if (data == null) {
          return const PageScaffold(title: 'Receipt', body: EmptyView(title: 'No receipt', body: 'This payment has no receipt on this phone.'));
        }
        final receipt = data.receipt;
        final invoice = data.invoice;
        return Scaffold(
          appBar: AppBar(
            title: Text(receipt.number),
            actions: [
              IconButton(
                tooltip: 'Save PDF',
                onPressed: () async {
                  final bytes = await guard(context, () => receiptPdfBytes(receipt, invoice.currency));
                  if (bytes == null || !context.mounted) return;
                  await saveFile(bytes, '${receipt.number}.pdf', 'application/pdf');
                },
                icon: const Icon(Icons.download_outlined),
              ),
              IconButton(
                tooltip: 'Share PDF',
                onPressed: () async {
                  final bytes = await guard(context, () => receiptPdfBytes(receipt, invoice.currency));
                  if (bytes == null) return;
                  await shareFile(bytes, '${receipt.number}.pdf', 'application/pdf');
                },
                icon: const Icon(Icons.share_outlined),
              ),
            ],
          ),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 0),
                child: Text('${receipt.marker.label} · Remaining ${formatMoney(receipt.remainingMinor, invoice.currency)}'),
              ),
              Expanded(
                child: PdfPreview(
                  build: (format) => receiptPdfBytes(receipt, invoice.currency),
                  pdfFileName: '${receipt.number}.pdf',
                  canChangeOrientation: false,
                  canChangePageFormat: false,
                  allowPrinting: true,
                  allowSharing: false,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
