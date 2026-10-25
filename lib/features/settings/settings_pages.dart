import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:local_auth/local_auth.dart';
import 'package:path_provider/path_provider.dart';

import '../../app/providers.dart';
import '../../app/version.dart';
import '../../core/format.dart';
import '../../core/invoicing/enums.dart';
import '../../core/money/money.dart';
import '../../core/widgets/ui.dart';
import '../../data/local_notifications.dart';
import '../../data/pin_store.dart';
import '../../domain/models.dart';
import '../onboarding/setup_pages.dart';
import '../shared/support.dart';

class SettingsHubPage extends ConsumerWidget {
  const SettingsHubPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PageScaffold(
      title: 'Settings',
      body: ListView(
        padding: const EdgeInsets.fromLTRB(12, 8, 12, 96),
        children: [
          _tile(context, 'Business profile', '/settings/business'),
          _tile(context, 'Logo and branding', '/settings/branding'),
          _tile(context, 'Bank accounts', '/settings/banks'),
          _tile(context, 'Services', '/services'),
          _tile(context, 'Invoice templates', '/settings/templates'),
          _tile(context, 'WhatsApp templates', '/settings/messages'),
          _tile(context, 'Numbering, tax, and currency', '/settings/app'),
          _tile(context, 'Notifications', '/settings/notifications'),
          _tile(context, 'App lock', '/settings/security'),
          _tile(context, 'Backup and restore', '/settings/backup'),
          _tile(context, 'Payments', '/payments'),
          _tile(context, 'Reminders', '/reminders'),
          const ListTile(
            title: Text('Version $appVersion'),
            subtitle: Text('Invoices, customers, and payments stay on this phone. There is no account and no analytics.'),
          ),
        ],
      ),
    );
  }

  Widget _tile(BuildContext context, String title, String path) {
    return ListTile(
      title: Text(title),
      minTileHeight: 56,
      trailing: const Icon(Icons.chevron_right),
      onTap: () => context.push(path),
    );
  }
}

class InvoiceTemplatesPage extends ConsumerStatefulWidget {
  const InvoiceTemplatesPage({super.key});

  @override
  ConsumerState<InvoiceTemplatesPage> createState() => _InvoiceTemplatesPageState();
}

class _InvoiceTemplatesPageState extends ConsumerState<InvoiceTemplatesPage> {
  InvoiceTemplate? _selected;
  BrandProfile? _brand;

  @override
  void initState() {
    super.initState();
    Future<void>(() async {
      final business = await ref.read(storeProvider).business();
      if (business == null) return;
      final brand = await ref.read(storeProvider).brandFor(ownerType: 'business', ownerId: business.id);
      if (mounted) {
        setState(() {
          _brand = brand;
          _selected = brand?.template;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return PageScaffold(
      title: 'Invoice templates',
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Text('The preferred template is used for new invoices. An issued invoice keeps the template it was created with.'),
          const SizedBox(height: 12),
          RadioGroup<InvoiceTemplate>(
            groupValue: _selected,
            onChanged: (value) async {
              final brand = _brand;
              if (brand == null || value == null) return;
              setState(() => _selected = value);
              await ref.read(storeProvider).saveBrand(
                BrandProfile(
                  id: brand.id,
                  ownerType: brand.ownerType,
                  ownerId: brand.ownerId,
                  logoBytes: brand.logoBytes,
                  signatureBytes: brand.signatureBytes,
                  primaryColor: brand.primaryColor,
                  secondaryColor: brand.secondaryColor,
                  accentColor: brand.accentColor,
                  tagline: brand.tagline,
                  footer: brand.footer,
                  template: value,
                  tradingName: brand.tradingName,
                  contactPhone: brand.contactPhone,
                  contactWhatsapp: brand.contactWhatsapp,
                  contactEmail: brand.contactEmail,
                  contactAddress: brand.contactAddress,
                ),
              );
              refresh(ref);
            },
            child: Column(
              children: [
                for (final template in InvoiceTemplate.values)
                  RadioListTile<InvoiceTemplate>(
                    value: template,
                    title: Text(template.label),
                    subtitle: Text(switch (template) {
                      InvoiceTemplate.corporate => 'Navy band and a filled table header.',
                      InvoiceTemplate.minimal => 'Type and hairlines.',
                      InvoiceTemplate.premium => 'An accent bar and a large total.',
                      InvoiceTemplate.compact => 'Tighter type for long invoices.',
                    }),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MessageTemplatesPage extends ConsumerStatefulWidget {
  const MessageTemplatesPage({super.key});

  @override
  ConsumerState<MessageTemplatesPage> createState() => _MessageTemplatesPageState();
}

class _MessageTemplatesPageState extends ConsumerState<MessageTemplatesPage> {
  List<MessageTemplateItem> _items = const [];
  var _loading = true;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final items = await ref.read(storeProvider).templates();
    if (mounted) {
      setState(() {
        _items = items;
        _loading = false;
      });
    }
  }

  Future<void> _edit(MessageTemplateItem item) async {
    final controller = TextEditingController(text: item.body);
    final saved = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(item.name),
        content: TextField(controller: controller, maxLines: 12),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Back')),
          TextButton(onPressed: () => Navigator.pop(context, true), child: const Text('Save')),
        ],
      ),
    );
    if (saved == true) {
      await ref.read(storeProvider).saveTemplate(
        MessageTemplateItem(id: item.id, type: item.type, name: item.name, body: controller.text, isDefault: item.isDefault),
      );
      await _load();
    }
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) return const Scaffold(body: LoadingView());
    return PageScaffold(
      title: 'Message templates',
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Text('Placeholders such as {customer}, {invoice_number}, {total}, {due_date}, and {bank} are filled when you prepare a message.'),
          for (final item in _items)
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(item.name),
              subtitle: Text(item.body, maxLines: 2, overflow: TextOverflow.ellipsis),
              onTap: () => _edit(item),
            ),
        ],
      ),
    );
  }
}

class AppPreferencesPage extends ConsumerStatefulWidget {
  const AppPreferencesPage({super.key});

  @override
  ConsumerState<AppPreferencesPage> createState() => _AppPreferencesPageState();
}

class _AppPreferencesPageState extends ConsumerState<AppPreferencesPage> {
  AppSettingsData? _settings;
  final _prefix = TextEditingController();
  final _sequence = TextEditingController();
  final _receiptPrefix = TextEditingController();
  final _receiptSequence = TextEditingController();
  final _padding = TextEditingController();
  final _tax = TextEditingController();
  final _notes = TextEditingController();
  final _instructions = TextEditingController();
  var _loading = true;

  @override
  void initState() {
    super.initState();
    Future<void>(() async {
      final settings = await ref.read(storeProvider).loadSettings();
      _settings = settings;
      _prefix.text = settings.invoicePrefix;
      _sequence.text = '${settings.nextInvoiceSequence}';
      _receiptPrefix.text = settings.receiptPrefix;
      _receiptSequence.text = '${settings.nextReceiptSequence}';
      _padding.text = '${settings.numberPadding}';
      _tax.text = formatBps(settings.defaultTaxRateBps);
      _notes.text = settings.defaultNotes;
      _instructions.text = settings.defaultPaymentInstructions;
      if (mounted) setState(() => _loading = false);
    });
  }

  @override
  void dispose() {
    for (final controller in [_prefix, _sequence, _receiptPrefix, _receiptSequence, _padding, _tax, _notes, _instructions]) {
      controller.dispose();
    }
    super.dispose();
  }

  Future<void> _save(AppSettingsData next) async {
    final saved = await guard(context, () async {
      await ref.read(storeProvider).saveSettings(next);
      return true;
    });
    if (saved == true) {
      _settings = next;
      ref.read(gateProvider).apply(next);
      refresh(ref);
      if (mounted) showNotice(context, 'Saved.');
    }
  }

  @override
  Widget build(BuildContext context) {
    final settings = _settings;
    if (_loading || settings == null) return const Scaffold(body: LoadingView());
    return PageScaffold(
      title: 'App settings',
      bottom: FilledButton(
        onPressed: () {
          final sequence = int.tryParse(_sequence.text) ?? settings.nextInvoiceSequence;
          final receipts = int.tryParse(_receiptSequence.text) ?? settings.nextReceiptSequence;
          final padding = int.tryParse(_padding.text) ?? settings.numberPadding;
          _save(
            settings.copyWith(
              invoicePrefix: _prefix.text,
              nextInvoiceSequence: sequence,
              receiptPrefix: _receiptPrefix.text,
              nextReceiptSequence: receipts,
              numberPadding: padding,
              defaultTaxRateBps: parsePercentToBps(_tax.text),
              defaultNotes: _notes.text,
              defaultPaymentInstructions: _instructions.text,
            ),
          );
        },
        child: const Text('Save'),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
        children: [
          const Text('Numbers only move forward. A deleted invoice does not free its number.'),
          InvoxaField(label: 'Invoice prefix', controller: _prefix),
          InvoxaField(label: 'Next invoice number', controller: _sequence, keyboardType: TextInputType.number),
          InvoxaField(label: 'Receipt prefix', controller: _receiptPrefix),
          InvoxaField(label: 'Next receipt number', controller: _receiptSequence, keyboardType: TextInputType.number),
          InvoxaField(label: 'Digits', controller: _padding, keyboardType: TextInputType.number),
          DropdownButtonFormField<String>(
            initialValue: settings.defaultCurrency,
            decoration: const InputDecoration(labelText: 'Currency'),
            items: [for (final code in supportedCurrencies.keys) DropdownMenuItem(value: code, child: Text(code))],
            onChanged: (value) {
              if (value != null) setState(() => _settings = settings.copyWith(defaultCurrency: value));
            },
          ),
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            title: const Text('Add tax by default'),
            value: settings.taxEnabled,
            onChanged: (value) => setState(() => _settings = settings.copyWith(taxEnabled: value)),
          ),
          InvoxaField(label: 'Default tax percent', controller: _tax, keyboardType: const TextInputType.numberWithOptions(decimal: true)),
          DropdownButtonFormField<TermsPreset>(
            initialValue: settings.defaultTermsPreset,
            decoration: const InputDecoration(labelText: 'Default due date'),
            items: [for (final preset in TermsPreset.values) DropdownMenuItem(value: preset, child: Text(preset.label))],
            onChanged: (value) {
              if (value == null) return;
              setState(() => _settings = settings.copyWith(defaultTermsPreset: value, defaultDueDays: value.days));
            },
          ),
          const SizedBox(height: 12),
          InvoxaField(label: 'Saved note', controller: _notes, maxLines: 3),
          InvoxaField(label: 'Default payment instructions', controller: _instructions, maxLines: 3),
          const SectionTitle('Payment methods'),
          for (final method in PaymentMethod.values)
            CheckboxListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(method.label),
              value: settings.methodEnabled(method),
              onChanged: (checked) {
                final next = [...settings.paymentMethods];
                if (checked == true && !next.contains(method)) next.add(method);
                if (checked != true) next.remove(method);
                if (next.isEmpty) return;
                setState(() => _settings = settings.copyWith(paymentMethods: next));
              },
            ),
          const SectionTitle('Appearance'),
          DropdownButtonFormField<ThemeChoice>(
            initialValue: settings.themeMode,
            decoration: const InputDecoration(labelText: 'Theme'),
            items: const [
              DropdownMenuItem(value: ThemeChoice.system, child: Text('Match the phone')),
              DropdownMenuItem(value: ThemeChoice.light, child: Text('Light')),
              DropdownMenuItem(value: ThemeChoice.dark, child: Text('Dark')),
            ],
            onChanged: (value) {
              if (value != null) setState(() => _settings = settings.copyWith(themeMode: value));
            },
          ),
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            title: const Text('Local insights'),
            subtitle: const Text('Short notes on the dashboard, calculated on this phone.'),
            value: settings.insightEnabled,
            onChanged: (value) => setState(() => _settings = settings.copyWith(insightEnabled: value)),
          ),
        ],
      ),
    );
  }
}

class NotificationSettingsPage extends ConsumerStatefulWidget {
  const NotificationSettingsPage({super.key});

  @override
  ConsumerState<NotificationSettingsPage> createState() => _NotificationSettingsPageState();
}

class _NotificationSettingsPageState extends ConsumerState<NotificationSettingsPage> {
  AppSettingsData? _settings;

  @override
  void initState() {
    super.initState();
    Future<void>(() async {
      final settings = await ref.read(storeProvider).loadSettings();
      if (mounted) setState(() => _settings = settings);
    });
  }

  Future<void> _save(AppSettingsData next) async {
    await ref.read(storeProvider).saveSettings(next);
    setState(() => _settings = next);
    refresh(ref);
  }

  @override
  Widget build(BuildContext context) {
    final settings = _settings;
    if (settings == null) return const Scaffold(body: LoadingView());
    return PageScaffold(
      title: 'Notifications',
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Text('Android 13 and later asks before showing notifications. Exact alarms can be denied; INVOXA then uses an inexact alarm, so the time may drift.'),
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            title: const Text('Invoice reminders'),
            value: settings.notificationsEnabled,
            onChanged: (value) => _save(settings.copyWith(notificationsEnabled: value)),
          ),
          ListTile(
            contentPadding: EdgeInsets.zero,
            title: const Text('Days before the due date'),
            trailing: Text('${settings.remindBeforeDays}'),
            onTap: () async {
              final next = settings.remindBeforeDays >= 7 ? 1 : settings.remindBeforeDays + 1;
              await _save(settings.copyWith(remindBeforeDays: next));
            },
          ),
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            title: const Text('On the due date'),
            value: settings.remindOnDue,
            onChanged: (value) => _save(settings.copyWith(remindOnDue: value)),
          ),
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            title: const Text('3 days after'),
            value: settings.remindAfter3,
            onChanged: (value) => _save(settings.copyWith(remindAfter3: value)),
          ),
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            title: const Text('7 days after'),
            value: settings.remindAfter7,
            onChanged: (value) => _save(settings.copyWith(remindAfter7: value)),
          ),
          FilledButton(
            onPressed: () async {
              final scheduler = ref.read(schedulerProvider);
              if (scheduler is LocalReminderScheduler) {
                final granted = await scheduler.requestPermission();
                if (context.mounted) showNotice(context, granted ? 'Notifications allowed.' : 'Notifications were not allowed.');
              }
            },
            child: const Text('Allow notifications'),
          ),
          const SizedBox(height: 8),
          OutlinedButton(
            onPressed: () async {
              final scheduler = ref.read(schedulerProvider);
              if (scheduler is LocalReminderScheduler) {
                final granted = await scheduler.requestExactAlarms();
                if (context.mounted) {
                  showNotice(context, granted ? 'Exact reminders allowed.' : 'Exact alarms were not allowed. Reminders can still be inexact.');
                }
              }
            },
            child: const Text('Allow exact reminders'),
          ),
        ],
      ),
    );
  }
}

class SecuritySettingsPage extends ConsumerStatefulWidget {
  const SecuritySettingsPage({super.key});

  @override
  ConsumerState<SecuritySettingsPage> createState() => _SecuritySettingsPageState();
}

class _SecuritySettingsPageState extends ConsumerState<SecuritySettingsPage> {
  AppSettingsData? _settings;
  var _biometrics = false;

  @override
  void initState() {
    super.initState();
    Future<void>(() async {
      final settings = await ref.read(storeProvider).loadSettings();
      var available = false;
      try {
        final auth = LocalAuthentication();
        available = await auth.canCheckBiometrics || await auth.isDeviceSupported();
      } on Object {
        available = false;
      }
      if (mounted) {
        setState(() {
          _settings = settings;
          _biometrics = available;
        });
      }
    });
  }

  Future<void> _save(AppSettingsData next) async {
    await ref.read(storeProvider).saveSettings(next);
    ref.read(gateProvider).apply(next);
    setState(() => _settings = next);
    refresh(ref);
  }

  Future<void> _enablePin() async {
    final pin = await _askPin(context, title: 'Choose a PIN', confirm: true);
    if (pin == null) return;
    await pinStore.save(pin);
    await _save(_settings!.copyWith(pinEnabled: true));
  }

  Future<void> _disablePin() async {
    final pin = await _askPin(context, title: 'Enter your PIN');
    if (pin == null) return;
    if (!await pinStore.matches(pin)) {
      if (mounted) showNotice(context, 'That PIN does not match.');
      return;
    }
    await pinStore.clear();
    await _save(_settings!.copyWith(pinEnabled: false, biometricEnabled: false));
    ref.read(gateProvider).update(ready: true, onboarded: true, locked: false);
  }

  @override
  Widget build(BuildContext context) {
    final settings = _settings;
    if (settings == null) return const Scaffold(body: LoadingView());
    return PageScaffold(
      title: 'App lock',
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            title: const Text('App PIN'),
            subtitle: const Text('The PIN stays in secure storage on this phone. It is not inside a backup.'),
            value: settings.pinEnabled,
            onChanged: (value) => value ? _enablePin() : _disablePin(),
          ),
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            title: const Text('Biometric unlock'),
            subtitle: Text(_biometrics ? 'Uses the fingerprint or face unlock already on this phone.' : 'This phone has no biometrics enrolled.'),
            value: settings.biometricEnabled,
            onChanged: (!_biometrics || !settings.pinEnabled)
                ? null
                : (value) => _save(settings.copyWith(biometricEnabled: value)),
          ),
          const SectionTitle('Auto-lock'),
          Wrap(
            spacing: 8,
            children: [
              for (final option in const [(0, 'When I leave'), (30, '30 seconds'), (60, '1 minute'), (300, '5 minutes')])
                ChoiceChip(
                  label: Text(option.$2),
                  selected: settings.autoLockSeconds == option.$1,
                  onSelected: settings.pinEnabled ? (_) => _save(settings.copyWith(autoLockSeconds: option.$1)) : null,
                ),
            ],
          ),
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            title: const Text('Ask again for backup and clearing data'),
            value: settings.protectSensitive,
            onChanged: (value) => _save(settings.copyWith(protectSensitive: value)),
          ),
        ],
      ),
    );
  }
}

Future<String?> _askPin(BuildContext context, {required String title, bool confirm = false}) async {
  final first = TextEditingController();
  final second = TextEditingController();
  final value = await showDialog<String>(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(title),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(controller: first, obscureText: true, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: '4 to 6 digits')),
          if (confirm) TextField(controller: second, obscureText: true, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'Repeat PIN')),
        ],
      ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: const Text('Back')),
        TextButton(
          onPressed: () {
            final pin = first.text.trim();
            if (pin.length < 4 || pin.length > 6 || int.tryParse(pin) == null) return;
            if (confirm && pin != second.text.trim()) return;
            Navigator.pop(context, pin);
          },
          child: const Text('Continue'),
        ),
      ],
    ),
  );
  first.dispose();
  second.dispose();
  return value;
}

class BackupPage extends ConsumerStatefulWidget {
  const BackupPage({super.key});

  @override
  ConsumerState<BackupPage> createState() => _BackupPageState();
}

class _BackupPageState extends ConsumerState<BackupPage> {
  final _password = TextEditingController();
  DateTime? _last;
  var _busy = false;

  @override
  void initState() {
    super.initState();
    Future<void>(() async {
      final settings = await ref.read(storeProvider).loadSettings();
      if (mounted) setState(() => _last = settings.lastBackupAt);
    });
  }

  @override
  void dispose() {
    _password.dispose();
    super.dispose();
  }

  Future<bool> _stepUp() async {
    final settings = await ref.read(storeProvider).loadSettings();
    if (!settings.pinEnabled || !settings.protectSensitive) return true;
    if (!mounted) return false;
    final pin = await _askPin(context, title: 'Enter your PIN');
    if (pin == null) return false;
    final ok = await pinStore.matches(pin);
    if (!ok && mounted) showNotice(context, 'That PIN does not match.');
    return ok;
  }

  Future<Uint8List?> _export() async {
    if (!await _stepUp()) return null;
    if (!mounted) return null;
    return guard(context, () => ref.read(storeProvider).exportBackup(password: _password.text.trim().isEmpty ? null : _password.text));
  }

  @override
  Widget build(BuildContext context) {
    return PageScaffold(
      title: 'Backup and restore',
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Text('A backup is a file you keep. If this phone is lost or reset, INVOXA cannot recover what was only stored here. Android Auto Backup is turned off.'),
          const SizedBox(height: 8),
          Text(_last == null ? 'No backup recorded on this phone yet.' : 'Last backup ${formatLongDate(_last!)}.'),
          const SizedBox(height: 12),
          const Text('Leave the password empty for a file you can open without one. A password uses AES-GCM. A lost password cannot be recovered.'),
          const SizedBox(height: 12),
          InvoxaField(label: 'Backup password (optional)', controller: _password),
          FilledButton(
            onPressed: _busy
                ? null
                : () async {
                    setState(() => _busy = true);
                    final bytes = await _export();
                    if (bytes != null) {
                      final name = 'INVOXA-backup-${formatIsoDate(DateTime.now())}.invoxa.json';
                      await shareFile(bytes, name, 'application/json');
                      final settings = await ref.read(storeProvider).loadSettings();
                      if (mounted) setState(() => _last = settings.lastBackupAt);
                    }
                    if (mounted) setState(() => _busy = false);
                  },
            child: const Text('Share backup'),
          ),
          const SizedBox(height: 8),
          OutlinedButton(
            onPressed: _busy
                ? null
                : () async {
                    setState(() => _busy = true);
                    final bytes = await _export();
                    if (bytes != null && context.mounted) {
                      final saved = await saveFile(bytes, 'INVOXA-backup-${formatIsoDate(DateTime.now())}.invoxa.json', 'application/json');
                      if (!context.mounted) return;
                      showNotice(context, saved ? 'Backup saved.' : 'Save cancelled.');
                    }
                    if (mounted) setState(() => _busy = false);
                  },
            child: const Text('Save to a folder'),
          ),
          const SizedBox(height: 8),
          OutlinedButton(
            onPressed: _busy
                ? null
                : () async {
                    if (!await _stepUp()) return;
                    if (!context.mounted) return;
                    await ref.read(storeProvider).checkpoint();
                    final directory = await getApplicationDocumentsDirectory();
                    final file = File('${directory.path}/invoxa.sqlite');
                    if (!file.existsSync()) {
                      if (!context.mounted) return;
                      showNotice(context, 'The database file is not ready yet.');
                      return;
                    }
                    await shareFile(await file.readAsBytes(), 'invoxa.sqlite', 'application/octet-stream');
                  },
            child: const Text('Share database file'),
          ),
          const SectionTitle('Restore'),
          OutlinedButton(
            onPressed: () async {
              if (!await _stepUp()) return;
              if (!context.mounted) return;
              final picked = await FilePicker.pickFile(dialogTitle: 'Choose a backup');
              if (picked == null || !context.mounted) return;
              final bytes = await picked.readAsBytes();
              if (!context.mounted) return;
              final ok = await confirmAction(
                context,
                title: 'Replace everything on this phone?',
                body: 'Restore checks the file before it replaces your invoices, customers, and payments.',
                confirm: 'Restore',
                destructive: true,
              );
              if (!ok || !context.mounted) return;
              final restored = await guard(context, () async {
                await ref.read(storeProvider).restoreBackup(bytes, password: _password.text.trim().isEmpty ? null : _password.text);
                return true;
              });
              if (restored != true || !context.mounted) return;
              await pinStore.clear();
              final settings = await ref.read(storeProvider).loadSettings();
              ref.read(gateProvider).apply(settings, locked: false);
              refresh(ref);
              if (!context.mounted) return;
              showNotice(context, 'Restored. Set a new PIN if you want the app locked.');
            },
            child: const Text('Restore from file'),
          ),
          const SectionTitle('Invoices'),
          OutlinedButton(
            onPressed: () async {
              final csv = await ref.read(storeProvider).exportInvoicesCsv();
              await shareFile(Uint8List.fromList(utf8.encode(csv)), 'INVOXA-invoices.csv', 'text/csv');
            },
            child: const Text('Export invoices'),
          ),
          const SizedBox(height: 8),
          OutlinedButton(
            onPressed: () async {
              final picked = await FilePicker.pickFile(dialogTitle: 'Choose a CSV');
              if (picked == null) return;
              final bytes = await picked.readAsBytes();
              if (!context.mounted) return;
              final count = await guard(context, () => ref.read(storeProvider).importInvoicesCsv(utf8.decode(bytes)));
              if (count == null || !context.mounted) return;
              refresh(ref);
              showNotice(context, 'Imported $count invoice${count == 1 ? '' : 's'}.');
            },
            child: const Text('Import invoices'),
          ),
          const SectionTitle('Clear'),
          OutlinedButton(
            onPressed: () async {
              if (!await _stepUp()) return;
              if (!context.mounted) return;
              final controller = TextEditingController();
              final ok = await showDialog<bool>(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Clear all data?'),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text('Type DELETE to remove the business, invoices, customers, and payments from this phone.'),
                      const SizedBox(height: 12),
                      TextField(controller: controller, decoration: const InputDecoration(labelText: 'DELETE')),
                    ],
                  ),
                  actions: [
                    TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Back')),
                    TextButton(onPressed: () => Navigator.pop(context, controller.text.trim() == 'DELETE'), child: const Text('Clear')),
                  ],
                ),
              );
              controller.dispose();
              if (ok != true || !context.mounted) return;
              await ref.read(storeProvider).clearAll();
              await pinStore.clear();
              final settings = await ref.read(storeProvider).loadSettings();
              ref.read(gateProvider).apply(settings, locked: false);
              refresh(ref);
              if (!context.mounted) return;
              context.go('/welcome');
            },
            child: const Text('Clear all data'),
          ),
        ],
      ),
    );
  }
}

class SettingsBusinessPage extends StatelessWidget {
  const SettingsBusinessPage({super.key});

  @override
  Widget build(BuildContext context) => const BusinessSetupPage();
}

class SettingsBrandingPage extends StatelessWidget {
  const SettingsBrandingPage({super.key});

  @override
  Widget build(BuildContext context) => const BrandingSetupPage();
}

class SettingsBankPage extends StatelessWidget {
  const SettingsBankPage({super.key});

  @override
  Widget build(BuildContext context) => const BankSetupPage();
}
