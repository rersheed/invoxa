import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:local_auth/local_auth.dart';

import '../../app/providers.dart';
import '../../core/theme/app_theme.dart';
import '../../core/widgets/ui.dart';
import '../../data/pin_store.dart';

class LockPage extends ConsumerStatefulWidget {
  const LockPage({super.key});

  @override
  ConsumerState<LockPage> createState() => _LockPageState();
}

class _LockPageState extends ConsumerState<LockPage> {
  final _pin = TextEditingController();
  var _checking = false;
  var _biometrics = false;

  @override
  void initState() {
    super.initState();
    Future<void>(() async {
      final settings = await ref.read(storeProvider).loadSettings();
      if (!settings.biometricEnabled) return;
      try {
        final auth = LocalAuthentication();
        final available = await auth.canCheckBiometrics;
        if (!mounted) return;
        setState(() => _biometrics = available);
        if (available) await _biometric();
      } on Object {
        if (mounted) setState(() => _biometrics = false);
      }
    });
  }

  @override
  void dispose() {
    _pin.dispose();
    super.dispose();
  }

  Future<void> _unlock() async {
    if (_checking) return;
    setState(() => _checking = true);
    final ok = await pinStore.matches(_pin.text.trim());
    if (!mounted) return;
    setState(() => _checking = false);
    if (!ok) {
      showNotice(context, 'That PIN does not match.');
      return;
    }
    final gate = ref.read(gateProvider);
    gate.unlockTowards(gate.pendingInvoice == null ? '/home' : '/invoices/${gate.pendingInvoice}');
    gate.pendingInvoice = null;
  }

  Future<void> _biometric() async {
    try {
      final ok = await LocalAuthentication().authenticate(
        localizedReason: 'Unlock INVOXA',
        biometricOnly: true,
      );
      if (!ok || !mounted) return;
      final gate = ref.read(gateProvider);
      gate.unlockTowards(gate.pendingInvoice == null ? '/home' : '/invoices/${gate.pendingInvoice}');
      gate.pendingInvoice = null;
    } on Object {
      if (mounted) showNotice(context, 'Biometrics could not unlock the app. Use your PIN.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Spacer(),
              const Text('INVOXA', style: TextStyle(color: InvoxaColors.navy, fontWeight: FontWeight.w700, letterSpacing: 1.1)),
              const SizedBox(height: 12),
              const Text('Unlock', style: TextStyle(fontSize: 32, fontWeight: FontWeight.w700)),
              const SizedBox(height: 8),
              const Text('Your invoices stay on this phone.'),
              const SizedBox(height: 20),
              TextField(
                controller: _pin,
                obscureText: true,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'PIN'),
                onSubmitted: (_) => _unlock(),
              ),
              const SizedBox(height: 16),
              FilledButton(onPressed: _checking ? null : _unlock, child: const Text('Unlock')),
              if (_biometrics) ...[
                const SizedBox(height: 12),
                OutlinedButton(onPressed: _biometric, child: const Text('Use biometrics')),
              ],
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
