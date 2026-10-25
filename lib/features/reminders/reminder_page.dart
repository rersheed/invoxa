import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../app/providers.dart';
import '../../core/format.dart';
import '../../core/invoicing/enums.dart';
import '../../core/messaging/messages.dart';
import '../../core/money/money.dart';
import '../../core/widgets/ui.dart';
import '../../domain/models.dart';
import '../shared/support.dart';

class ReminderPage extends ConsumerStatefulWidget {
  const ReminderPage({super.key, this.invoiceId});

  final String? invoiceId;

  @override
  ConsumerState<ReminderPage> createState() => _ReminderPageState();
}

class _ReminderPageState extends ConsumerState<ReminderPage> {
  List<_Row> _rows = const [];
  var _loading = true;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final store = ref.read(storeProvider);
    final invoices = await store.listInvoices();
    final chosen = widget.invoiceId == null ? invoices : invoices.where((invoice) => invoice.id == widget.invoiceId).toList();
    final rows = <_Row>[];
    for (final invoice in chosen) {
      if (invoice.status == InvoiceStatus.draft) continue;
      final reminders = await store.remindersFor(invoice.id);
      if (reminders.isEmpty && widget.invoiceId == null && invoice.outstandingMinor == 0) continue;
      rows.add(_Row(invoice, reminders));
    }
    if (mounted) {
      setState(() {
        _rows = rows;
        _loading = false;
      });
    }
  }

  Future<void> _schedule(InvoiceSummary invoice, {DateTime? custom}) async {
    final done = await guard(context, () async {
      await ref.read(storeProvider).scheduleInvoiceReminders(invoice.id, custom: custom);
      return true;
    });
    if (done == true) {
      refresh(ref);
      await _load();
      if (mounted) showNotice(context, 'Reminders updated. Paid invoices cancel theirs automatically.');
    }
  }

  Future<void> _message(InvoiceSummary invoice) async {
    final store = ref.read(storeProvider);
    final detail = await store.invoice(invoice.id);
    final business = await store.business();
    final template = await store.templateFor(TemplateType.reminder);
    final input = messageInput(detail, businessName: business?.displayName ?? 'INVOXA', phone: business?.phone ?? '');
    if (!mounted) return;
    await showMessageSheet(
      context,
      title: 'Send payment reminder',
      initial: renderTemplate(template.body, input.placeholders),
      whatsapp: detail.customerWhatsapp.isEmpty ? detail.customerPhone : detail.customerWhatsapp,
      onSent: (text) async {
        await store.addSentReminder(invoiceId: invoice.id, message: text);
        refresh(ref);
      },
    );
    await _load();
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) return const Scaffold(body: LoadingView());
    return PageScaffold(
      title: 'Reminders',
      body: _rows.isEmpty
          ? const EmptyView(
              title: 'No reminders',
              body: 'Issue an invoice and reminders can be set before the due date, on the due date, and after it.',
              icon: Icons.notifications_none,
            )
          : ListView(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
              children: [
                const Text('Tapping a notification opens the invoice. A full payment cancels reminders that have not been sent.'),
                const SizedBox(height: 12),
                for (final row in _rows) ...[
                  InvoxaCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(row.invoice.customerName, style: const TextStyle(fontWeight: FontWeight.w700)),
                        Text('${row.invoice.number ?? 'Draft'} · ${formatMoney(row.invoice.outstandingMinor, row.invoice.currency)} outstanding'),
                        const SizedBox(height: 8),
                        if (row.reminders.isEmpty) const Text('Nothing scheduled.'),
                        for (final reminder in row.reminders)
                          ListTile(
                            contentPadding: EdgeInsets.zero,
                            title: Text(reminder.kind.label),
                            subtitle: Text('${formatLongDate(reminder.scheduledAt)} · ${reminder.status.name}'),
                            trailing: reminder.status == ReminderStatus.scheduled
                                ? TextButton(
                                    onPressed: () async {
                                      await ref.read(storeProvider).markReminderSent(reminder.id);
                                      await ref.read(schedulerProvider).cancel(reminder.notificationId);
                                      refresh(ref);
                                      await _load();
                                    },
                                    child: const Text('Mark sent'),
                                  )
                                : null,
                          ),
                        Wrap(
                          spacing: 8,
                          children: [
                            ActionChip(label: const Text('Schedule'), onPressed: () => _schedule(row.invoice)),
                            ActionChip(
                              label: const Text('Custom date'),
                              onPressed: () async {
                                final picked = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now().add(const Duration(days: 1)),
                                  firstDate: DateTime.now(),
                                  lastDate: DateTime(2100),
                                );
                                if (picked != null) {
                                  await _schedule(row.invoice, custom: DateTime(picked.year, picked.month, picked.day, 9));
                                }
                              },
                            ),
                            ActionChip(label: const Text('WhatsApp reminder'), onPressed: () => _message(row.invoice)),
                            ActionChip(label: const Text('Open invoice'), onPressed: () => context.push('/invoices/${row.invoice.id}')),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                ],
              ],
            ),
    );
  }
}

class _Row {
  const _Row(this.invoice, this.reminders);
  final InvoiceSummary invoice;
  final List<ReminderItem> reminders;
}
