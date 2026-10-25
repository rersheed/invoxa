import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

import '../../app/providers.dart';
import '../../core/images.dart';
import '../../core/invoicing/enums.dart';
import '../../core/theme/app_theme.dart';
import '../../core/widgets/ui.dart';
import '../../domain/models.dart';
import '../shared/support.dart';

class SplashPage extends ConsumerStatefulWidget {
  const SplashPage({super.key});

  @override
  ConsumerState<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends ConsumerState<SplashPage> {
  @override
  void initState() {
    super.initState();
    Future<void>(() async {
      final store = ref.read(storeProvider);
      await store.ensureDefaults();
      final settings = await store.loadSettings();
      ref.read(gateProvider).apply(settings, locked: settings.pinEnabled);
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: InvoxaColors.navy,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.receipt_long, color: Colors.white, size: 48),
            SizedBox(height: 16),
            Text('INVOXA', style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.w700, letterSpacing: 1.2)),
          ],
        ),
      ),
    );
  }
}

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 32, 24, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Spacer(),
              Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(color: InvoxaColors.navy, borderRadius: BorderRadius.circular(18)),
                child: const Icon(Icons.receipt_long, color: Colors.white, size: 32),
              ),
              const SizedBox(height: 28),
              const Text(
                'Your Business. Your Invoices. Your Control.',
                style: TextStyle(fontSize: 34, height: 1.15, fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 16),
              Text(
                'Create professional invoices, manage payments, and grow your business — even without internet.',
                style: TextStyle(
                  fontSize: 17,
                  height: 1.45,
                  color: Theme.of(context).brightness == Brightness.dark ? InvoxaColors.darkMuted : InvoxaColors.muted,
                ),
              ),
              const Spacer(),
              FilledButton(onPressed: () => context.go('/setup/business'), child: const Text('Get Started')),
            ],
          ),
        ),
      ),
    );
  }
}

class BusinessSetupPage extends ConsumerStatefulWidget {
  const BusinessSetupPage({super.key, this.setup = false});

  final bool setup;

  @override
  ConsumerState<BusinessSetupPage> createState() => _BusinessSetupPageState();
}

class _BusinessSetupPageState extends ConsumerState<BusinessSetupPage> {
  final _name = TextEditingController();
  final _trading = TextEditingController();
  final _phone = TextEditingController();
  final _whatsapp = TextEditingController();
  final _email = TextEditingController();
  final _address = TextEditingController();
  final _website = TextEditingController();
  final _registration = TextEditingController();
  final _tin = TextEditingController();
  final _description = TextEditingController();
  String _currency = 'NGN';
  Uint8List? _logo;
  var _loading = true;
  var _saving = false;
  String _id = '';

  @override
  void initState() {
    super.initState();
    Future<void>(() async {
      final business = await ref.read(storeProvider).business();
      if (!mounted) return;
      if (business != null) {
        _id = business.id;
        _name.text = business.legalName;
        _trading.text = business.tradingName ?? '';
        _phone.text = business.phone;
        _whatsapp.text = business.whatsapp;
        _email.text = business.email;
        _address.text = business.address;
        _website.text = business.website ?? '';
        _registration.text = business.registrationNumber ?? '';
        _tin.text = business.tin ?? '';
        _description.text = business.description ?? '';
        _currency = business.defaultCurrency;
      }
      final brand = business == null
          ? null
          : await ref.read(storeProvider).brandFor(ownerType: 'business', ownerId: business.id);
      _logo = brand?.logoBytes ?? ref.read(onboardingDraftProvider).logo;
      if (mounted) setState(() => _loading = false);
    });
  }

  @override
  void dispose() {
    for (final controller in [_name, _trading, _phone, _whatsapp, _email, _address, _website, _registration, _tin, _description]) {
      controller.dispose();
    }
    super.dispose();
  }

  Future<void> _pickLogo() async {
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picked == null) return;
    final bytes = normalizeImage(await picked.readAsBytes());
    if (!mounted) return;
    if (bytes == null) {
      showNotice(context, 'Choose an image file for the logo.');
      return;
    }
    setState(() => _logo = bytes);
    ref.read(onboardingDraftProvider).logo = bytes;
  }

  Future<void> _save() async {
    if (_saving) return;
    setState(() => _saving = true);
    final saved = await guard(context, () async {
      await ref.read(storeProvider).saveBusiness(
        BusinessProfile(
          id: _id,
          legalName: _name.text,
          tradingName: _trading.text,
          phone: _phone.text,
          whatsapp: _whatsapp.text,
          email: _email.text,
          address: _address.text,
          website: _website.text,
          registrationNumber: _registration.text,
          tin: _tin.text,
          defaultCurrency: _currency,
          description: _description.text,
        ),
      );
      final business = await ref.read(storeProvider).business();
      if (business != null && _logo != null) {
        final brand = await ref.read(storeProvider).brandFor(ownerType: 'business', ownerId: business.id);
        if (brand != null) {
          await ref.read(storeProvider).saveBrand(
            BrandProfile(
              id: brand.id,
              ownerType: brand.ownerType,
              ownerId: brand.ownerId,
              logoBytes: _logo,
              signatureBytes: brand.signatureBytes,
              primaryColor: brand.primaryColor,
              secondaryColor: brand.secondaryColor,
              accentColor: brand.accentColor,
              tagline: brand.tagline,
              footer: brand.footer,
              template: brand.template,
              tradingName: brand.tradingName,
              contactPhone: brand.contactPhone,
              contactWhatsapp: brand.contactWhatsapp,
              contactEmail: brand.contactEmail,
              contactAddress: brand.contactAddress,
            ),
          );
        }
      }
      return true;
    });
    if (!mounted) return;
    setState(() => _saving = false);
    if (saved != true) return;
    refresh(ref);
    if (widget.setup) {
      context.go('/setup/branding');
    } else {
      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) return const Scaffold(body: LoadingView());
    return PageScaffold(
      title: widget.setup ? 'Your business' : 'Business profile',
      bottom: FilledButton(onPressed: _saving ? null : _save, child: Text(widget.setup ? 'Continue' : 'Save')),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
        children: [
          const Text('This is what customers see on your invoices.'),
          const SizedBox(height: 16),
          _LogoButton(bytes: _logo, onPick: _pickLogo),
          const SizedBox(height: 16),
          InvoxaField(label: 'Business name', controller: _name),
          InvoxaField(label: 'Trading name (optional)', controller: _trading),
          InvoxaField(label: 'Phone', controller: _phone, keyboardType: TextInputType.phone),
          InvoxaField(label: 'WhatsApp (optional)', controller: _whatsapp, keyboardType: TextInputType.phone),
          InvoxaField(label: 'Email (optional)', controller: _email, keyboardType: TextInputType.emailAddress),
          InvoxaField(label: 'Address (optional)', controller: _address, maxLines: 2),
          InvoxaField(label: 'Website (optional)', controller: _website),
          InvoxaField(label: 'Registration number (optional)', controller: _registration),
          InvoxaField(label: 'TIN (optional)', controller: _tin),
          DropdownButtonFormField<String>(
            initialValue: _currency,
            decoration: const InputDecoration(labelText: 'Default currency'),
            items: [
              for (final entry in supportedCurrencies.entries)
                DropdownMenuItem(value: entry.key, child: Text('${entry.value} ${entry.key}')),
            ],
            onChanged: (value) => setState(() => _currency = value ?? 'NGN'),
          ),
          const SizedBox(height: 12),
          InvoxaField(label: 'Description (optional)', controller: _description, maxLines: 3),
        ],
      ),
    );
  }
}

class _LogoButton extends StatelessWidget {
  const _LogoButton({required this.bytes, required this.onPick});

  final Uint8List? bytes;
  final VoidCallback onPick;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPick,
      child: Row(
        children: [
          if (bytes == null)
            const Icon(Icons.add_photo_alternate_outlined)
          else
            ClipRRect(borderRadius: BorderRadius.circular(8), child: Image.memory(bytes!, width: 42, height: 42, fit: BoxFit.cover)),
          const SizedBox(width: 12),
          Text(bytes == null ? 'Add logo' : 'Change logo'),
        ],
      ),
    );
  }
}

class BrandingSetupPage extends ConsumerStatefulWidget {
  const BrandingSetupPage({super.key, this.setup = false});

  final bool setup;

  @override
  ConsumerState<BrandingSetupPage> createState() => _BrandingSetupPageState();
}

class _BrandingSetupPageState extends ConsumerState<BrandingSetupPage> {
  final _tagline = TextEditingController();
  final _footer = TextEditingController();
  final _primary = TextEditingController(text: '#1B2A4A');
  final _secondary = TextEditingController(text: '#243B67');
  final _accent = TextEditingController(text: '#0E8F62');
  InvoiceTemplate _template = InvoiceTemplate.corporate;
  Uint8List? _logo;
  Uint8List? _signature;
  BrandProfile? _brand;
  BusinessProfile? _business;
  var _loading = true;
  var _saving = false;

  @override
  void initState() {
    super.initState();
    Future<void>(() async {
      final business = await ref.read(storeProvider).business();
      final brand = business == null
          ? null
          : await ref.read(storeProvider).brandFor(ownerType: 'business', ownerId: business.id);
      if (!mounted) return;
      _business = business;
      _brand = brand;
      if (brand != null) {
        _tagline.text = brand.tagline ?? '';
        _footer.text = brand.footer ?? '';
        _primary.text = brand.primaryColor;
        _secondary.text = brand.secondaryColor;
        _accent.text = brand.accentColor;
        _template = brand.template;
        _logo = brand.logoBytes;
        _signature = brand.signatureBytes;
      }
      final draft = ref.read(onboardingDraftProvider);
      _logo ??= draft.logo;
      _signature ??= draft.signature;
      setState(() => _loading = false);
    });
  }

  @override
  void dispose() {
    _tagline.dispose();
    _footer.dispose();
    _primary.dispose();
    _secondary.dispose();
    _accent.dispose();
    super.dispose();
  }

  Future<Uint8List?> _pick() async {
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picked == null) return null;
    final bytes = normalizeImage(await picked.readAsBytes());
    if (bytes == null && mounted) showNotice(context, 'Choose an image file.');
    return bytes;
  }

  Future<void> _save() async {
    if (_saving || _brand == null || _business == null) return;
    if (parseHex(_primary.text) == null || parseHex(_secondary.text) == null || parseHex(_accent.text) == null) {
      showNotice(context, 'Use colours like #1B2A4A.');
      return;
    }
    setState(() => _saving = true);
    final saved = await guard(context, () async {
      await ref.read(storeProvider).saveBrand(
        BrandProfile(
          id: _brand!.id,
          ownerType: 'business',
          ownerId: _business!.id,
          logoBytes: _logo,
          signatureBytes: _signature,
          primaryColor: _primary.text.trim(),
          secondaryColor: _secondary.text.trim(),
          accentColor: _accent.text.trim(),
          tagline: _tagline.text,
          footer: _footer.text,
          template: _template,
        ),
      );
      return true;
    });
    if (!mounted) return;
    setState(() => _saving = false);
    if (saved != true) return;
    refresh(ref);
    if (widget.setup) {
      context.go('/setup/banks');
    } else {
      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) return const Scaffold(body: LoadingView());
    final primary = parseHex(_primary.text) ?? InvoxaColors.navy;
    final accent = parseHex(_accent.text) ?? InvoxaColors.emerald;
    return PageScaffold(
      title: widget.setup ? 'Branding' : 'Logo and colours',
      bottom: FilledButton(onPressed: _saving ? null : _save, child: Text(widget.setup ? 'Continue' : 'Save')),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
        children: [
          const Text('Invoices use these colours. You can still pick a template later.'),
          const SizedBox(height: 16),
          _PreviewCard(
            name: _business?.displayName ?? 'Your business',
            tagline: _tagline.text,
            primary: primary,
            accent: accent,
            template: _template.label,
            logo: _logo,
          ),
          const SizedBox(height: 16),
          OutlinedButton(onPressed: () async {
            final bytes = await _pick();
            if (bytes != null) setState(() => _logo = bytes);
          }, child: Text(_logo == null ? 'Add logo' : 'Change logo')),
          const SizedBox(height: 8),
          OutlinedButton(onPressed: () async {
            final bytes = await _pick();
            if (bytes != null) setState(() => _signature = bytes);
          }, child: Text(_signature == null ? 'Add signature' : 'Change signature')),
          const SizedBox(height: 12),
          InvoxaField(label: 'Primary colour', controller: _primary, onChanged: (_) => setState(() {})),
          _Swatches(onPick: (hex) => setState(() => _primary.text = hex)),
          InvoxaField(label: 'Secondary colour', controller: _secondary, onChanged: (_) => setState(() {})),
          InvoxaField(label: 'Invoice accent', controller: _accent, onChanged: (_) => setState(() {})),
          _Swatches(onPick: (hex) => setState(() => _accent.text = hex)),
          InvoxaField(label: 'Tagline', controller: _tagline, onChanged: (_) => setState(() {})),
          InvoxaField(label: 'Invoice footer', controller: _footer, maxLines: 2),
          const SectionTitle('Preferred template'),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (final template in InvoiceTemplate.values)
                ChoiceChip(
                  label: Text(template.label),
                  selected: _template == template,
                  onSelected: (_) => setState(() => _template = template),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class _Swatches extends StatelessWidget {
  const _Swatches({required this.onPick});

  final ValueChanged<String> onPick;

  static const _colors = ['#1B2A4A', '#243B67', '#0E8F62', '#8A5A00', '#9C2F2F', '#3D3A36'];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Wrap(
        spacing: 8,
        children: [
          for (final hex in _colors)
            InkWell(
              onTap: () => onPick(hex),
              borderRadius: BorderRadius.circular(16),
              child: Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(color: parseHex(hex), shape: BoxShape.circle),
              ),
            ),
        ],
      ),
    );
  }
}

class _PreviewCard extends StatelessWidget {
  const _PreviewCard({
    required this.name,
    required this.tagline,
    required this.primary,
    required this.accent,
    required this.template,
    this.logo,
  });

  final String name;
  final String tagline;
  final Color primary;
  final Color accent;
  final String template;
  final Uint8List? logo;

  @override
  Widget build(BuildContext context) {
    return InvoxaCard(
      padding: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(color: primary, borderRadius: const BorderRadius.vertical(top: Radius.circular(20))),
            child: Row(
              children: [
                if (logo != null) ...[
                  ClipRRect(borderRadius: BorderRadius.circular(8), child: Image.memory(logo!, width: 36, height: 36, fit: BoxFit.cover)),
                  const SizedBox(width: 12),
                ],
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(name, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 16)),
                      if (tagline.trim().isNotEmpty)
                        Text(tagline, style: const TextStyle(color: Colors.white70, fontSize: 12)),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(child: Text('INV-2026-0001\nSample customer', style: TextStyle(color: primary, fontWeight: FontWeight.w600))),
                Text('₦25,000', style: TextStyle(color: accent, fontWeight: FontWeight.w700, fontSize: 18)),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: Text('$template template', style: const TextStyle(fontSize: 12)),
          ),
        ],
      ),
    );
  }
}

class BankSetupPage extends ConsumerStatefulWidget {
  const BankSetupPage({super.key, this.setup = false});

  final bool setup;

  @override
  ConsumerState<BankSetupPage> createState() => _BankSetupPageState();
}

class _BankSetupPageState extends ConsumerState<BankSetupPage> {
  List<BankAccount> _accounts = const [];
  var _loading = true;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final accounts = await ref.read(storeProvider).bankAccounts();
    if (mounted) {
      setState(() {
        _accounts = accounts;
        _loading = false;
      });
    }
  }

  Future<void> _edit([BankAccount? account]) async {
    final saved = await showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (context) => _BankForm(account: account),
    );
    if (saved == true) {
      refresh(ref);
      await _load();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) return const Scaffold(body: LoadingView());
    return PageScaffold(
      title: widget.setup ? 'Bank accounts' : 'Bank accounts',
      bottom: widget.setup
          ? FilledButton(onPressed: () => context.go('/setup/ready'), child: const Text('Continue'))
          : null,
      fab: FloatingActionButton.extended(onPressed: () => _edit(), icon: const Icon(Icons.add), label: const Text('Add account')),
      body: _accounts.isEmpty
          ? const EmptyView(
              title: 'No bank account yet',
              body: 'Add the account customers should pay into. You can skip this and add one later.',
              icon: Icons.account_balance_outlined,
            )
          : ListView(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 96),
              children: [
                for (final account in _accounts)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: InvoxaCard(
                      onTap: () => _edit(account),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(account.displayLabel, style: const TextStyle(fontWeight: FontWeight.w600)),
                                const SizedBox(height: 4),
                                Text('${account.accountName}\n${account.accountNumber}'),
                              ],
                            ),
                          ),
                          if (account.isDefault)
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                              decoration: BoxDecoration(
                                color: InvoxaColors.emerald.withValues(alpha: 0.14),
                                borderRadius: BorderRadius.circular(999),
                              ),
                              child: const Text('Default', style: TextStyle(color: InvoxaColors.emerald, fontWeight: FontWeight.w600)),
                            ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
    );
  }
}

class _BankForm extends ConsumerStatefulWidget {
  const _BankForm({this.account});

  final BankAccount? account;

  @override
  ConsumerState<_BankForm> createState() => _BankFormState();
}

class _BankFormState extends ConsumerState<_BankForm> {
  late final TextEditingController _bank;
  late final TextEditingController _name;
  late final TextEditingController _number;
  late final TextEditingController _label;
  late bool _default;
  late bool _active;
  var _saving = false;

  @override
  void initState() {
    super.initState();
    final account = widget.account;
    _bank = TextEditingController(text: account?.bankName ?? '');
    _name = TextEditingController(text: account?.accountName ?? '');
    _number = TextEditingController(text: account?.accountNumber ?? '');
    _label = TextEditingController(text: account?.label ?? '');
    _default = account?.isDefault ?? true;
    _active = account?.isActive ?? true;
  }

  @override
  void dispose() {
    _bank.dispose();
    _name.dispose();
    _number.dispose();
    _label.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (_saving) return;
    setState(() => _saving = true);
    final saved = await guard(context, () async {
      await ref.read(storeProvider).saveBank(
        BankAccount(
          id: widget.account?.id ?? '',
          bankName: _bank.text,
          accountName: _name.text,
          accountNumber: _number.text,
          label: _label.text,
          isDefault: _default,
          isActive: _active,
        ),
      );
      return true;
    });
    if (!mounted) return;
    setState(() => _saving = false);
    if (saved == true) Navigator.pop(context, true);
  }

  Future<void> _delete() async {
    final account = widget.account;
    if (account == null) return;
    final ok = await confirmAction(
      context,
      title: 'Remove this account?',
      body: 'Invoices already issued keep the bank details printed on them.',
      confirm: 'Remove',
      destructive: true,
    );
    if (!ok || !mounted) return;
    final removed = await guard(context, () async {
      await ref.read(storeProvider).deleteBank(account.id);
      return true;
    });
    if (removed == true && mounted) Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(20, 0, 20, 20 + MediaQuery.viewInsetsOf(context).bottom),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          InvoxaField(label: 'Bank', controller: _bank),
          InvoxaField(label: 'Account name', controller: _name),
          InvoxaField(label: 'Account number', controller: _number, keyboardType: TextInputType.number),
          InvoxaField(label: 'Label (optional)', controller: _label, hint: 'Main account'),
          SwitchListTile(contentPadding: EdgeInsets.zero, title: const Text('Default account'), value: _default, onChanged: (value) => setState(() => _default = value)),
          SwitchListTile(contentPadding: EdgeInsets.zero, title: const Text('Active'), value: _active, onChanged: (value) => setState(() => _active = value)),
          const SizedBox(height: 8),
          FilledButton(onPressed: _saving ? null : _save, child: const Text('Save account')),
          if (widget.account != null)
            TextButton(onPressed: _delete, child: const Text('Remove account')),
        ],
      ),
    );
  }
}

class ReadyPage extends ConsumerWidget {
  const ReadyPage({super.key});

  Future<void> _finish(WidgetRef ref, BuildContext context, String location) async {
    final settings = await ref.read(storeProvider).loadSettings();
    await ref.read(storeProvider).saveSettings(settings.copyWith(onboardingComplete: true));
    ref.read(gateProvider).apply(settings.copyWith(onboardingComplete: true), locked: false);
    refresh(ref);
    if (context.mounted) context.go(location);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Spacer(),
              const Icon(Icons.verified_outlined, color: InvoxaColors.emerald, size: 48),
              const SizedBox(height: 16),
              const Text('Your business is ready!', style: TextStyle(fontSize: 32, fontWeight: FontWeight.w700, height: 1.15)),
              const SizedBox(height: 12),
              const Text('Create your first invoice, or look around the dashboard. Everything stays on this phone.'),
              const Spacer(),
              FilledButton(
                onPressed: () => _finish(ref, context, '/invoices/new'),
                child: const Text('Create Your First Invoice'),
              ),
              const SizedBox(height: 12),
              OutlinedButton(
                onPressed: () => _finish(ref, context, '/home'),
                child: const Text('Explore Dashboard'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
