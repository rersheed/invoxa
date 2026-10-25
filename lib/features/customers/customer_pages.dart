import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../app/providers.dart';
import '../../core/format.dart';
import '../../core/invoicing/enums.dart';
import '../../core/money/money.dart';
import '../../core/widgets/ui.dart';
import '../../domain/models.dart';
import '../shared/support.dart';

class CustomerListPage extends ConsumerStatefulWidget {
  const CustomerListPage({super.key});

  @override
  ConsumerState<CustomerListPage> createState() => _CustomerListPageState();
}

class _CustomerListPageState extends ConsumerState<CustomerListPage> {
  late Future<List<CustomerItem>> _future;
  final _search = TextEditingController();

  @override
  void initState() {
    super.initState();
    _future = ref.read(storeProvider).customers();
  }

  void _reload() => setState(() => _future = ref.read(storeProvider).customers());

  @override
  void dispose() {
    _search.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<int>(revisionProvider, (_, _) => _reload());
    return PageScaffold(
      title: 'Customers',
      fab: FloatingActionButton.extended(
        onPressed: () => context.push('/customers/new'),
        icon: const Icon(Icons.person_add_alt),
        label: const Text('Add'),
      ),
      body: FutureBuilder<List<CustomerItem>>(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) return const LoadingView();
          final query = _search.text.trim().toLowerCase();
          final people = (snapshot.data ?? const <CustomerItem>[]).where((customer) {
            if (query.isEmpty) return true;
            return customer.name.toLowerCase().contains(query) || customer.phone.replaceAll(' ', '').contains(query.replaceAll(' ', ''));
          }).toList();
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
                child: TextField(
                  controller: _search,
                  onChanged: (_) => setState(() {}),
                  decoration: const InputDecoration(hintText: 'Search name or phone', prefixIcon: Icon(Icons.search)),
                ),
              ),
              Expanded(
                child: people.isEmpty
                    ? EmptyView(
                        title: 'No customers yet',
                        body: 'Save a customer while creating an invoice, or add one here.',
                        action: 'Add customer',
                        onAction: () => context.push('/customers/new'),
                        icon: Icons.people_outline,
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.fromLTRB(20, 0, 20, 96),
                        itemCount: people.length,
                        itemBuilder: (context, index) {
                          final customer = people[index];
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: InvoxaCard(
                              onTap: () => context.push('/customers/${customer.id}'),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(customer.name, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                                  if (customer.phone.isNotEmpty) Text(customer.phone),
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

class CustomerEditorPage extends ConsumerStatefulWidget {
  const CustomerEditorPage({super.key, this.id});

  final String? id;

  @override
  ConsumerState<CustomerEditorPage> createState() => _CustomerEditorPageState();
}

class _CustomerEditorPageState extends ConsumerState<CustomerEditorPage> {
  final _name = TextEditingController();
  final _phone = TextEditingController();
  final _whatsapp = TextEditingController();
  final _email = TextEditingController();
  final _address = TextEditingController();
  final _notes = TextEditingController();
  var _loading = true;
  var _saving = false;

  @override
  void initState() {
    super.initState();
    Future<void>(() async {
      if (widget.id != null) {
        final customer = await ref.read(storeProvider).customer(widget.id!);
        if (customer != null) {
          _name.text = customer.name;
          _phone.text = customer.phone;
          _whatsapp.text = customer.whatsapp;
          _email.text = customer.email ?? '';
          _address.text = customer.address ?? '';
          _notes.text = customer.notes ?? '';
        }
      }
      if (mounted) setState(() => _loading = false);
    });
  }

  @override
  void dispose() {
    for (final controller in [_name, _phone, _whatsapp, _email, _address, _notes]) {
      controller.dispose();
    }
    super.dispose();
  }

  Future<void> _save() async {
    if (_saving) return;
    setState(() => _saving = true);
    final id = await guard(context, () {
      return ref.read(storeProvider).saveCustomer(
        CustomerItem(
          id: widget.id ?? '',
          name: _name.text,
          phone: _phone.text,
          whatsapp: _whatsapp.text,
          email: _email.text,
          address: _address.text,
          notes: _notes.text,
        ),
      );
    });
    if (!mounted) return;
    setState(() => _saving = false);
    if (id == null) return;
    refresh(ref);
    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) return const Scaffold(body: LoadingView());
    return PageScaffold(
      title: widget.id == null ? 'New customer' : 'Edit customer',
      bottom: FilledButton(onPressed: _saving ? null : _save, child: const Text('Save customer')),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
        children: [
          InvoxaField(label: 'Name or company', controller: _name),
          InvoxaField(label: 'Phone', controller: _phone, keyboardType: TextInputType.phone),
          InvoxaField(label: 'WhatsApp', controller: _whatsapp, keyboardType: TextInputType.phone),
          InvoxaField(label: 'Email (optional)', controller: _email),
          InvoxaField(label: 'Address (optional)', controller: _address, maxLines: 2),
          InvoxaField(label: 'Notes (optional)', controller: _notes, maxLines: 3),
        ],
      ),
    );
  }
}

class CustomerProfilePage extends ConsumerWidget {
  const CustomerProfilePage({super.key, required this.id});

  final String id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FutureBuilder(
      future: ref.watch(revisionProvider) == -1 ? null : ref.read(storeProvider).customerStats(id),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          if (snapshot.connectionState != ConnectionState.done) return const Scaffold(body: LoadingView());
          return const PageScaffold(title: 'Customer', body: EmptyView(title: 'Customer not found', body: 'They may have been removed.'));
        }
        final stats = snapshot.data!;
        final customer = stats.customer;
        final phone = customer.phone;
        return PageScaffold(
          title: customer.name,
          actions: [
            IconButton(
              tooltip: 'Edit',
              onPressed: () => context.push('/customers/${customer.id}/edit'),
              icon: const Icon(Icons.edit_outlined),
            ),
          ],
          body: ListView(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 32),
            children: [
              Row(
                children: [
                  Expanded(child: _stat('Invoiced', formatMoney(stats.invoicedMinor, stats.currency))),
                  Expanded(child: _stat('Paid', formatMoney(stats.paidMinor, stats.currency))),
                  Expanded(child: _stat('Outstanding', formatMoney(stats.outstandingMinor, stats.currency))),
                ],
              ),
              const SizedBox(height: 12),
              FilledButton(onPressed: () => context.push('/invoices/new?customer=${customer.id}'), child: const Text('New invoice')),
              const SizedBox(height: 8),
              OutlinedButton(
                onPressed: phone.isEmpty ? null : () => openPhone(phone),
                child: const Text('Call'),
              ),
              const SizedBox(height: 8),
              OutlinedButton(
                onPressed: (customer.whatsapp.isEmpty && phone.isEmpty)
                    ? null
                    : () => openWhatsApp(number: customer.whatsapp.isEmpty ? phone : customer.whatsapp, text: 'Hello ${customer.name},'),
                child: const Text('WhatsApp'),
              ),
              const SizedBox(height: 8),
              OutlinedButton(
                onPressed: phone.isEmpty
                    ? null
                    : () async {
                        await Clipboard.setData(ClipboardData(text: phone));
                        if (context.mounted) showNotice(context, 'Phone copied.');
                      },
                child: const Text('Copy phone'),
              ),
              if ((customer.notes ?? '').isNotEmpty) ...[
                const SectionTitle('Notes'),
                Text(customer.notes!),
              ],
              const SectionTitle('Invoices'),
              if (stats.invoices.isEmpty)
                const Text('No invoices for this customer yet.')
              else
                for (final invoice in stats.invoices)
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text(invoice.number ?? 'Draft'),
                    subtitle: Text(formatLongDate(invoice.issueDate)),
                    trailing: Text(formatMoney(invoice.outstandingMinor, invoice.currency)),
                    onTap: () => context.push('/invoices/${invoice.id}'),
                  ),
              const SectionTitle('Payments'),
              if (stats.payments.isEmpty)
                const Text('No payments recorded yet.')
              else
                for (final payment in stats.payments)
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text(formatMoney(payment.amountMinor, payment.currency)),
                    subtitle: Text('${formatLongDate(payment.paidAt)} · ${payment.method.label}'),
                    onTap: () => context.push('/receipts/${payment.id}'),
                  ),
              TextButton(
                onPressed: () async {
                  final ok = await confirmAction(
                    context,
                    title: 'Remove this customer?',
                    body: 'Customers with invoices stay on record.',
                    confirm: 'Remove',
                    destructive: true,
                  );
                  if (!ok || !context.mounted) return;
                  final removed = await guard(context, () async {
                    await ref.read(storeProvider).deleteCustomer(customer.id);
                    return true;
                  });
                  if (removed == true && context.mounted) {
                    refresh(ref);
                    context.pop();
                  }
                },
                child: const Text('Remove customer'),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _stat(String label, String value) {
    return InvoxaCard(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontSize: 12)),
          const SizedBox(height: 4),
          Text(value, style: const TextStyle(fontWeight: FontWeight.w700)),
        ],
      ),
    );
  }
}
