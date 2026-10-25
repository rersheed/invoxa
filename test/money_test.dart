import 'package:flutter_test/flutter_test.dart';
import 'package:invoxa/core/errors.dart';
import 'package:invoxa/core/invoicing/invoice_math.dart';
import 'package:invoxa/core/money/money.dart';

void main() {
  test('line totals use half-up minor units', () {
    expect(lineTotalMinor(1000, 7500000), 7500000);
    expect(lineTotalMinor(1500, 10000), 15000);
    expect(lineTotalMinor(1, 1), 0);
    expect(lineTotalMinor(500, 1), 1);
    expect(lineTotalMinor(0, 5000), 0);
    expect(lineTotalMinor(1999, 100), 200);
  });

  test('discount, tax, charges and multiple lines', () {
    final totals = computeTotals(
      lines: [
        (quantityMilli: 2000, unitPriceMinor: 500000),
        (quantityMilli: 1500, unitPriceMinor: 200000),
      ],
      discountMinor: 100000,
      taxRateBps: 750,
      chargesMinor: 25000,
    );
    expect(totals.subtotalMinor, 1300000);
    expect(totals.discountMinor, 100000);
    expect(totals.taxMinor, 90000);
    expect(totals.grandMinor, 1315000);
    expect(outstandingMinor(totals.grandMinor, 315000), 1000000);
  });

  test('discount cannot exceed the subtotal', () {
    expect(
      () => computeTotals(
        lines: [(quantityMilli: 1000, unitPriceMinor: 100)],
        discountMinor: 101,
        taxRateBps: 0,
        chargesMinor: 0,
      ),
      throwsA(isA<InvoxaException>()),
    );
  });

  test('large amounts stay exact', () {
    const price = 99999999999;
    expect(lineTotalMinor(1000, price), price);
    final totals = computeTotals(
      lines: [(quantityMilli: 3000, unitPriceMinor: price)],
      discountMinor: 0,
      taxRateBps: 0,
      chargesMinor: 0,
    );
    expect(totals.grandMinor, price * 3);
  });

  test('money and tax parsing avoid binary floats', () {
    expect(parseMoneyToMinor('₦75,000'), 7500000);
    expect(parseMoneyToMinor('1500.50'), 150050);
    expect(formatMoney(7500000, 'NGN'), '₦75,000');
    expect(formatMoney(150050, 'NGN'), '₦1,500.50');
    expect(parsePercentToBps('7.5'), 750);
    expect(parsePercentToBps('7.25'), 725);
    expect(formatBps(750), '7.5');
    expect(parseQuantityMilli('1.5'), 1500);
    expect(formatQuantity(1500), '1.5');
    expect(() => parseMoneyToMinor('12.345'), throwsA(isA<InvoxaException>()));
  });
}
