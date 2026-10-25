import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

import '../../app/providers.dart';
import '../../core/images.dart';
import '../../core/invoicing/enums.dart';
import '../../core/money/money.dart';
import '../../core/widgets/ui.dart';
import '../../domain/models.dart';
import '../shared/support.dart';

class ServiceListPage extends ConsumerStatefulWidget {
  const ServiceListPage({super.key});

  @override
  ConsumerState<ServiceListPage> createState() => _ServiceListPageState();
}

class _ServiceListPageState extends ConsumerState<ServiceListPage> {
  late Future<List<ServiceItem>> _future;

  @override
  void initState() {
    super.initState();
    _future = ref.read(storeProvider).services();
  }

  void _reload() => setState(() => _future = ref.read(storeProvider).services());

  @override
  Widget build(BuildContext context) {
    ref.listen<int>(revisionProvider, (_, _) => _reload());
    return PageScaffold(
      title: 'Services',
      fab: FloatingActionButton.extended(
        onPressed: () => context.push('/services/new'),
        icon: const Icon(Icons.add),
        label: const Text('Add'),
      ),
      body: FutureBuilder<List<ServiceItem>>(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) return const LoadingView();
          final services = snapshot.data ?? const <ServiceItem>[];
          if (services.isEmpty) {
            return EmptyView(
              title: 'No services yet',
              body: 'A service remembers the price, unit, bank account, and branding for the next invoice.',
              action: 'Add a service',
              onAction: () => context.push('/services/new'),
              icon: Icons.design_services_outlined,
            );
          }
          return ListView.builder(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 96),
            itemCount: services.length,
            itemBuilder: (context, index) {
              final service = services[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: InvoxaCard(
                  onTap: () => context.push('/services/${service.id}'),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(service.name, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
                            Text('${formatMoney(service.defaultPriceMinor, service.currency)} · ${unitLabel(service.unit, service.customUnit)}'),
                            Text(service.brandingMode == BrandingMode.custom ? 'Own branding' : 'Business branding'),
                          ],
                        ),
                      ),
                      if (!service.isActive) const Text('Inactive'),
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

class ServiceEditorPage extends ConsumerStatefulWidget {
  const ServiceEditorPage({super.key, this.id});

  final String? id;

  @override
  ConsumerState<ServiceEditorPage> createState() => _ServiceEditorPageState();
}

class _ServiceEditorPageState extends ConsumerState<ServiceEditorPage> {
  final _name = TextEditingController();
  final _description = TextEditingController();
  final _category = TextEditingController();
  final _price = TextEditingController();
  final _customUnit = TextEditingController();
  final _trading = TextEditingController();
  final _tagline = TextEditingController();
  final _phone = TextEditingController();
  final _whatsapp = TextEditingController();
  final _email = TextEditingController();
  final _address = TextEditingController();
  final _primary = TextEditingController(text: '#1B2A4A');
  final _secondary = TextEditingController(text: '#243B67');
  final _accent = TextEditingController(text: '#0E8F62');
  String _unit = 'item';
  String _currency = 'NGN';
  String? _bankId;
  var _active = true;
  var _customBrand = false;
  InvoiceTemplate _template = InvoiceTemplate.corporate;
  Uint8List? _logo;
  String _brandId = '';
  List<BankAccount> _banks = const [];
  var _loading = true;
  var _saving = false;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final store = ref.read(storeProvider);
    _banks = await store.bankAccounts(activeOnly: true);
    final settings = await store.loadSettings();
    _currency = settings.defaultCurrency;
    if (widget.id != null) {
      final service = await store.service(widget.id!);
      if (service != null) {
        _name.text = service.name;
        _description.text = service.description;
        _category.text = service.category;
        _price.text = minorInput(service.defaultPriceMinor);
        _unit = service.unit;
        _customUnit.text = service.customUnit ?? '';
        _currency = service.currency;
        _bankId = service.bankAccountId;
        _active = service.isActive;
        _customBrand = service.brandingMode == BrandingMode.custom;
        final brand = service.brand;
        if (brand != null) {
          _brandId = brand.id;
          _trading.text = brand.tradingName ?? '';
          _tagline.text = brand.tagline ?? '';
          _phone.text = brand.contactPhone ?? '';
          _whatsapp.text = brand.contactWhatsapp ?? '';
          _email.text = brand.contactEmail ?? '';
          _address.text = brand.contactAddress ?? '';
          _primary.text = brand.primaryColor;
          _secondary.text = brand.secondaryColor;
          _accent.text = brand.accentColor;
          _template = brand.template;
          _logo = brand.logoBytes;
        }
      }
    }
    if (mounted) setState(() => _loading = false);
  }

  @override
  void dispose() {
    for (final controller in [
      _name,
      _description,
      _category,
      _price,
      _customUnit,
      _trading,
      _tagline,
      _phone,
      _whatsapp,
      _email,
      _address,
      _primary,
      _secondary,
      _accent,
    ]) {
      controller.dispose();
    }
    super.dispose();
  }

  Future<void> _save() async {
    if (_saving) return;
    setState(() => _saving = true);
    final saved = await guard(context, () async {
      await ref.read(storeProvider).saveService(
        ServiceItem(
          id: widget.id ?? '',
          name: _name.text,
          description: _description.text,
          category: _category.text,
          defaultPriceMinor: _price.text.trim().isEmpty ? 0 : parseMoneyToMinor(_price.text),
          unit: _unit,
          customUnit: _unit == 'custom' ? _customUnit.text : null,
          currency: _currency,
          bankAccountId: _bankId,
          isActive: _active,
          brandingMode: _customBrand ? BrandingMode.custom : BrandingMode.business,
          brand: _customBrand
              ? BrandProfile(
                  id: _brandId,
                  ownerType: 'service',
                  ownerId: widget.id ?? '',
                  logoBytes: _logo,
                  primaryColor: _primary.text.trim(),
                  secondaryColor: _secondary.text.trim(),
                  accentColor: _accent.text.trim(),
                  template: _template,
                  tagline: _tagline.text,
                  tradingName: _trading.text,
                  contactPhone: _phone.text,
                  contactWhatsapp: _whatsapp.text,
                  contactEmail: _email.text,
                  contactAddress: _address.text,
                )
              : null,
        ),
      );
      return true;
    });
    if (!mounted) return;
    setState(() => _saving = false);
    if (saved != true) return;
    refresh(ref);
    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) return const Scaffold(body: LoadingView());
    return PageScaffold(
      title: widget.id == null ? 'New service' : 'Edit service',
      bottom: FilledButton(onPressed: _saving ? null : _save, child: const Text('Save service')),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
        children: [
          InvoxaField(label: 'Name', controller: _name),
          InvoxaField(label: 'Description', controller: _description, maxLines: 3),
          InvoxaField(label: 'Category', controller: _category),
          InvoxaField(label: 'Default price', controller: _price, keyboardType: const TextInputType.numberWithOptions(decimal: true)),
          DropdownButtonFormField<String>(
            initialValue: _unit,
            decoration: const InputDecoration(labelText: 'Default unit'),
            items: [for (final unit in UnitType.values) DropdownMenuItem(value: unit.storage, child: Text(unit.label))],
            onChanged: (value) => setState(() => _unit = value ?? 'item'),
          ),
          if (_unit == 'custom') ...[
            const SizedBox(height: 12),
            InvoxaField(label: 'Custom unit', controller: _customUnit),
          ],
          const SizedBox(height: 12),
          DropdownButtonFormField<String>(
            initialValue: _currency,
            decoration: const InputDecoration(labelText: 'Currency'),
            items: [for (final code in supportedCurrencies.keys) DropdownMenuItem(value: code, child: Text('$code ${supportedCurrencies[code]}'))],
            onChanged: (value) => setState(() => _currency = value ?? 'NGN'),
          ),
          const SizedBox(height: 12),
          DropdownButtonFormField<String?>(
            initialValue: _banks.any((bank) => bank.id == _bankId) ? _bankId : null,
            decoration: const InputDecoration(labelText: 'Bank account'),
            items: [
              const DropdownMenuItem(value: null, child: Text('Business default')),
              for (final bank in _banks) DropdownMenuItem(value: bank.id, child: Text(bank.displayLabel)),
            ],
            onChanged: (value) => setState(() => _bankId = value),
          ),
          SwitchListTile(contentPadding: EdgeInsets.zero, title: const Text('Active'), value: _active, onChanged: (value) => setState(() => _active = value)),
          const SectionTitle('Branding'),
          SegmentedButton<bool>(
            segments: const [
              ButtonSegment(value: false, label: Text('Business')),
              ButtonSegment(value: true, label: Text('This service')),
            ],
            selected: {_customBrand},
            onSelectionChanged: (value) => setState(() => _customBrand = value.first),
          ),
          const SizedBox(height: 8),
          Text(_customBrand
              ? 'Invoices that contain only this service use this name, logo, colours, and contact details.'
              : 'Invoices use the main business branding.'),
          if (_customBrand) ...[
            const SizedBox(height: 12),
            OutlinedButton(
              onPressed: () async {
                final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
                if (picked == null) return;
                final bytes = normalizeImage(await picked.readAsBytes());
                if (bytes == null) {
                  if (context.mounted) showNotice(context, 'Choose an image file.');
                  return;
                }
                setState(() => _logo = bytes);
              },
              child: Text(_logo == null ? 'Add service logo' : 'Change service logo'),
            ),
            const SizedBox(height: 12),
            InvoxaField(label: 'Trading name', controller: _trading),
            InvoxaField(label: 'Tagline', controller: _tagline),
            InvoxaField(label: 'Phone', controller: _phone, keyboardType: TextInputType.phone),
            InvoxaField(label: 'WhatsApp', controller: _whatsapp, keyboardType: TextInputType.phone),
            InvoxaField(label: 'Email', controller: _email),
            InvoxaField(label: 'Address', controller: _address, maxLines: 2),
            InvoxaField(label: 'Primary colour', controller: _primary),
            InvoxaField(label: 'Secondary colour', controller: _secondary),
            InvoxaField(label: 'Accent colour', controller: _accent),
            Wrap(
              spacing: 8,
              children: [
                for (final template in InvoiceTemplate.values)
                  ChoiceChip(label: Text(template.label), selected: _template == template, onSelected: (_) => setState(() => _template = template)),
              ],
            ),
          ],
          if (widget.id != null)
            TextButton(
              onPressed: () async {
                final ok = await confirmAction(
                  context,
                  title: 'Delete this service?',
                  body: 'A service that is already on an invoice cannot be deleted. Mark it inactive instead.',
                  confirm: 'Delete',
                  destructive: true,
                );
                if (!ok || !context.mounted) return;
                final removed = await guard(context, () async {
                  await ref.read(storeProvider).deleteService(widget.id!);
                  return true;
                });
                if (removed == true && context.mounted) {
                  refresh(ref);
                  context.pop();
                }
              },
              child: const Text('Delete service'),
            ),
        ],
      ),
    );
  }
}
