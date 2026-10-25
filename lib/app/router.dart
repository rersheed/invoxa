import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../features/customers/customer_pages.dart';
import '../features/dashboard/dashboard_page.dart';
import '../features/invoices/invoice_detail_page.dart';
import '../features/invoices/invoice_editor_page.dart';
import '../features/invoices/invoice_list_page.dart';
import '../features/onboarding/setup_pages.dart';
import '../features/payments/payment_pages.dart';
import '../features/reminders/reminder_page.dart';
import '../features/reports/reports_page.dart';
import '../features/security/lock_page.dart';
import '../features/services/service_pages.dart';
import '../features/settings/settings_pages.dart';
import 'providers.dart';

final rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');

class AppShell extends StatelessWidget {
  const AppShell({super.key, required this.shell});

  final StatefulNavigationShell shell;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: shell,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push('/invoices/new'),
        icon: const Icon(Icons.add),
        label: const Text('New invoice'),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: shell.currentIndex,
        onDestinationSelected: (index) => shell.goBranch(index, initialLocation: index == shell.currentIndex),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.receipt_long_outlined), selectedIcon: Icon(Icons.receipt_long), label: 'Invoices'),
          NavigationDestination(icon: Icon(Icons.people_outline), selectedIcon: Icon(Icons.people), label: 'Customers'),
          NavigationDestination(icon: Icon(Icons.bar_chart_outlined), selectedIcon: Icon(Icons.bar_chart), label: 'Reports'),
          NavigationDestination(icon: Icon(Icons.settings_outlined), selectedIcon: Icon(Icons.settings), label: 'Settings'),
        ],
      ),
    );
  }
}

final routerProvider = Provider<GoRouter>((ref) {
  final gate = ref.read(gateProvider);
  final router = GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: '/splash',
    refreshListenable: gate,
    redirect: (context, state) {
      final location = state.matchedLocation;
      if (!gate.ready) return location == '/splash' ? null : '/splash';
      if (gate.locked) return location == '/lock' ? null : '/lock';
      if (!gate.onboarded) {
        const allowed = {'/welcome', '/setup/business', '/setup/branding', '/setup/banks', '/setup/ready'};
        return allowed.contains(location) ? null : '/welcome';
      }
      final next = gate.nextLocation;
      if (next != null) {
        if (location == next) {
          gate.nextLocation = null;
          return null;
        }
        return next;
      }
      if (location == '/splash' || location == '/lock' || location == '/welcome' || location.startsWith('/setup')) {
        return '/home';
      }
      return null;
    },
    routes: [
      GoRoute(path: '/splash', builder: (context, state) => const SplashPage()),
      GoRoute(path: '/welcome', builder: (context, state) => const WelcomePage()),
      GoRoute(path: '/lock', builder: (context, state) => const LockPage()),
      GoRoute(path: '/setup/business', builder: (context, state) => const BusinessSetupPage(setup: true)),
      GoRoute(path: '/setup/branding', builder: (context, state) => const BrandingSetupPage(setup: true)),
      GoRoute(path: '/setup/banks', builder: (context, state) => const BankSetupPage(setup: true)),
      GoRoute(path: '/setup/ready', builder: (context, state) => const ReadyPage()),
      StatefulShellRoute.indexedStack(
        builder: (context, state, shell) => AppShell(shell: shell),
        branches: [
          StatefulShellBranch(routes: [GoRoute(path: '/home', builder: (context, state) => const DashboardPage())]),
          StatefulShellBranch(routes: [GoRoute(path: '/invoices', builder: (context, state) => const InvoiceListPage())]),
          StatefulShellBranch(routes: [GoRoute(path: '/customers', builder: (context, state) => const CustomerListPage())]),
          StatefulShellBranch(routes: [GoRoute(path: '/reports', builder: (context, state) => const ReportsPage())]),
          StatefulShellBranch(routes: [GoRoute(path: '/settings', builder: (context, state) => const SettingsHubPage())]),
        ],
      ),
      GoRoute(
        path: '/invoices/new',
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) => InvoiceEditorPage(customerId: state.uri.queryParameters['customer']),
      ),
      GoRoute(
        path: '/invoices/:id/edit',
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) => InvoiceEditorPage(invoiceId: state.pathParameters['id']),
      ),
      GoRoute(
        path: '/invoices/:id/preview',
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) => InvoicePreviewPage(id: state.pathParameters['id']!),
      ),
      GoRoute(
        path: '/invoices/:id/history',
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) => InvoiceHistoryPage(id: state.pathParameters['id']!),
      ),
      GoRoute(
        path: '/invoices/:id/pay',
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) => RecordPaymentPage(invoiceId: state.pathParameters['id']),
      ),
      GoRoute(
        path: '/invoices/:id/reminders',
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) => ReminderPage(invoiceId: state.pathParameters['id']),
      ),
      GoRoute(
        path: '/invoices/:id',
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) => InvoiceDetailPage(id: state.pathParameters['id']!),
      ),
      GoRoute(
        path: '/customers/new',
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) => const CustomerEditorPage(),
      ),
      GoRoute(
        path: '/customers/:id/edit',
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) => CustomerEditorPage(id: state.pathParameters['id']),
      ),
      GoRoute(
        path: '/customers/:id',
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) => CustomerProfilePage(id: state.pathParameters['id']!),
      ),
      GoRoute(path: '/services', parentNavigatorKey: rootNavigatorKey, builder: (context, state) => const ServiceListPage()),
      GoRoute(
        path: '/services/new',
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) => const ServiceEditorPage(),
      ),
      GoRoute(
        path: '/services/:id',
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) => ServiceEditorPage(id: state.pathParameters['id']),
      ),
      GoRoute(path: '/payments', parentNavigatorKey: rootNavigatorKey, builder: (context, state) => const PaymentHistoryPage()),
      GoRoute(
        path: '/payments/record',
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) => const RecordPaymentPage(),
      ),
      GoRoute(
        path: '/receipts/:id',
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) => ReceiptPreviewPage(paymentId: state.pathParameters['id']!),
      ),
      GoRoute(path: '/reminders', parentNavigatorKey: rootNavigatorKey, builder: (context, state) => const ReminderPage()),
      GoRoute(path: '/settings/business', parentNavigatorKey: rootNavigatorKey, builder: (context, state) => const SettingsBusinessPage()),
      GoRoute(path: '/settings/branding', parentNavigatorKey: rootNavigatorKey, builder: (context, state) => const SettingsBrandingPage()),
      GoRoute(path: '/settings/banks', parentNavigatorKey: rootNavigatorKey, builder: (context, state) => const SettingsBankPage()),
      GoRoute(path: '/settings/templates', parentNavigatorKey: rootNavigatorKey, builder: (context, state) => const InvoiceTemplatesPage()),
      GoRoute(path: '/settings/messages', parentNavigatorKey: rootNavigatorKey, builder: (context, state) => const MessageTemplatesPage()),
      GoRoute(path: '/settings/app', parentNavigatorKey: rootNavigatorKey, builder: (context, state) => const AppPreferencesPage()),
      GoRoute(
        path: '/settings/notifications',
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) => const NotificationSettingsPage(),
      ),
      GoRoute(path: '/settings/security', parentNavigatorKey: rootNavigatorKey, builder: (context, state) => const SecuritySettingsPage()),
      GoRoute(path: '/settings/backup', parentNavigatorKey: rootNavigatorKey, builder: (context, state) => const BackupPage()),
    ],
  );
  ref.onDispose(router.dispose);
  return router;
});
