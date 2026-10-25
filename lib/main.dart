import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app/gate.dart';
import 'app/providers.dart';
import 'app/router.dart';
import 'core/invoicing/enums.dart';
import 'core/theme/app_theme.dart';
import 'data/db/app_database.dart';
import 'data/invoxa_store.dart';
import 'data/local_notifications.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final opens = ValueNotifier<String?>(null);
  final notifications = LocalReminderScheduler(opens);
  await notifications.init();
  final database = AppDatabase.defaults();
  final store = InvoxaStore(database, scheduler: notifications);
  await store.ensureDefaults();
  runApp(
    ProviderScope(
      overrides: [
        storeProvider.overrideWithValue(store),
        gateProvider.overrideWithValue(AppGate()),
        schedulerProvider.overrideWithValue(notifications),
        notificationOpens.overrideWithValue(opens),
      ],
      child: const InvoxaApp(),
    ),
  );
}

class InvoxaApp extends ConsumerStatefulWidget {
  const InvoxaApp({super.key});

  @override
  ConsumerState<InvoxaApp> createState() => _InvoxaAppState();
}

class _InvoxaAppState extends ConsumerState<InvoxaApp> with WidgetsBindingObserver {
  ThemeChoice _theme = ThemeChoice.system;
  DateTime _active = DateTime.now();
  DateTime? _left;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _timer = Timer.periodic(const Duration(seconds: 5), (_) => _idle());
    ref.read(notificationOpens).addListener(_opened);
    _loadTheme();
    final pending = ref.read(notificationOpens).value;
    if (pending != null && pending.isNotEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) => _opened());
    }
  }

  Future<void> _loadTheme() async {
    final settings = await ref.read(storeProvider).loadSettings();
    if (mounted) setState(() => _theme = settings.themeMode);
  }

  void _opened() {
    final id = ref.read(notificationOpens).value;
    if (id == null || id.isEmpty) return;
    ref.read(notificationOpens).value = null;
    final gate = ref.read(gateProvider);
    gate.pendingInvoice = id;
    if (!gate.ready || gate.locked || !gate.onboarded) return;
    ref.read(routerProvider).go('/invoices/$id');
  }

  void _idle() {
    final gate = ref.read(gateProvider);
    if (!gate.pinEnabled || gate.locked || !gate.onboarded || gate.autoLockSeconds <= 0) return;
    if (DateTime.now().difference(_active).inSeconds >= gate.autoLockSeconds) {
      gate.update(ready: true, onboarded: true, locked: true);
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final gate = ref.read(gateProvider);
    if (state == AppLifecycleState.paused) _left = DateTime.now();
    if (state == AppLifecycleState.resumed) {
      final left = _left;
      if (left != null && gate.pinEnabled && gate.onboarded && !gate.locked) {
        final away = DateTime.now().difference(left);
        if (away >= Duration(seconds: gate.autoLockSeconds)) {
          gate.update(ready: true, onboarded: true, locked: true);
        }
      }
      _active = DateTime.now();
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<int>(revisionProvider, (_, _) => _loadTheme());
    return MaterialApp.router(
      title: 'INVOXA',
      debugShowCheckedModeBanner: false,
      theme: invoxaTheme(Brightness.light),
      darkTheme: invoxaTheme(Brightness.dark),
      themeMode: themeModeOf(_theme),
      routerConfig: ref.watch(routerProvider),
      builder: (context, child) {
        return Listener(
          behavior: HitTestBehavior.translucent,
          onPointerDown: (_) => _active = DateTime.now(),
          child: child ?? const SizedBox.shrink(),
        );
      },
    );
  }
}
