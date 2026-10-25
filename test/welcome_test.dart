import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:invoxa/core/reports/figures.dart';
import 'package:invoxa/features/dashboard/dashboard_page.dart';
import 'package:invoxa/features/onboarding/setup_pages.dart';

void main() {
  testWidgets('welcome uses the product copy', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: WelcomePage()));
    expect(find.text('Your Business. Your Invoices. Your Control.'), findsOneWidget);
    expect(
      find.text('Create professional invoices, manage payments, and grow your business — even without internet.'),
      findsOneWidget,
    );
    expect(find.text('Get Started'), findsOneWidget);
  });

  testWidgets('dashboard keeps invoiced and received apart', (tester) async {
    await tester.binding.setSurfaceSize(const Size(800, 2600));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: DashboardView(
            greeting: 'Good morning',
            businessName: 'Ada Stores',
            figures: const DashboardFigures(
              currency: 'NGN',
              invoicedMinor: 25000000,
              receivedMinor: 10000000,
              outstandingMinor: 15000000,
              overdueMinor: 25000000,
              excludedOtherCurrency: 0,
              months: [MonthPoint(label: 'Oct 2026', invoicedMinor: 25000000, collectedMinor: 10000000)],
              byService: [NamedTotal(name: 'Design', minor: 25000000)],
              recentInvoiceIds: [],
              recentPaymentIds: [],
            ),
            insights: const ['You have ₦250,000 in overdue invoices.'],
            recentInvoices: const [],
            recentPayments: const [],
            onInvoice: (_) {},
            onNewInvoice: () {},
            onRecordPayment: () {},
            onCustomers: () {},
            onServices: () {},
            onPayment: (_) {},
          ),
        ),
      ),
    );
    expect(find.text("Here's how your business is doing."), findsOneWidget);
    expect(find.text('Total invoiced'), findsOneWidget);
    expect(find.text('Total received'), findsOneWidget);
    expect(find.text('₦250,000'), findsWidgets);
    expect(find.text('₦100,000'), findsOneWidget);
    expect(find.text('You have ₦250,000 in overdue invoices.'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('large amounts stay inside the dashboard cards', (tester) async {
    await tester.binding.setSurfaceSize(const Size(360, 800));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: DashboardView(
            greeting: 'Good evening',
            businessName: 'Ada Stores',
            figures: const DashboardFigures(
              currency: 'NGN',
              invoicedMinor: 8600000000,
              receivedMinor: 6100000000,
              outstandingMinor: 2500000000,
              overdueMinor: 25000000,
              excludedOtherCurrency: 0,
              months: [MonthPoint(label: 'Oct', invoicedMinor: 1, collectedMinor: 1)],
              byService: [],
              recentInvoiceIds: [],
              recentPaymentIds: [],
            ),
            insights: const [],
            recentInvoices: const [],
            recentPayments: const [],
            onInvoice: _ignore,
            onNewInvoice: _ignore0,
            onRecordPayment: _ignore0,
            onCustomers: _ignore0,
            onServices: _ignore0,
            onPayment: _ignore,
          ),
        ),
      ),
    );
    expect(tester.takeException(), isNull);
  });
}

void _ignore0() {}

void _ignore(String value) {}
