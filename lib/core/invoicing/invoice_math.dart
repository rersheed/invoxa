import '../errors.dart';

class InvoiceTotals {
  const InvoiceTotals({
    required this.subtotalMinor,
    required this.discountMinor,
    required this.taxMinor,
    required this.chargesMinor,
    required this.grandMinor,
  });

  final int subtotalMinor;
  final int discountMinor;
  final int taxMinor;
  final int chargesMinor;
  final int grandMinor;
}

/// Half-up line total. [quantityMilli] is thousandths of a unit.
int lineTotalMinor(int quantityMilli, int unitPriceMinor) {
  if (quantityMilli < 0 || unitPriceMinor < 0) {
    throw InvoxaException('Quantity and price must be zero or positive.');
  }
  final product = quantityMilli * unitPriceMinor;
  return (product + 500) ~/ 1000;
}

int taxOnMinor(int taxableMinor, int rateBps) {
  if (taxableMinor < 0 || rateBps < 0) {
    throw InvoxaException('Tax inputs must be zero or positive.');
  }
  return (taxableMinor * rateBps + 5000) ~/ 10000;
}

int outstandingMinor(int grandMinor, int paidMinor) {
  final value = grandMinor - paidMinor;
  return value < 0 ? 0 : value;
}

InvoiceTotals computeTotals({
  required List<({int quantityMilli, int unitPriceMinor})> lines,
  required int discountMinor,
  required int taxRateBps,
  required int chargesMinor,
}) {
  if (discountMinor < 0 || chargesMinor < 0 || taxRateBps < 0) {
    throw InvoxaException('Discount, tax, and charges must be zero or positive.');
  }
  var subtotal = 0;
  for (final line in lines) {
    subtotal += lineTotalMinor(line.quantityMilli, line.unitPriceMinor);
  }
  if (discountMinor > subtotal) {
    throw InvoxaException('Discount cannot be more than the subtotal.');
  }
  final taxable = subtotal - discountMinor;
  final tax = taxOnMinor(taxable, taxRateBps);
  return InvoiceTotals(
    subtotalMinor: subtotal,
    discountMinor: discountMinor,
    taxMinor: tax,
    chargesMinor: chargesMinor,
    grandMinor: taxable + tax + chargesMinor,
  );
}
