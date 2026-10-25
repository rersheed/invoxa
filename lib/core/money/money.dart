import '../errors.dart';
import '../invoicing/enums.dart';

/// Formats [minor] units for [currency] without using binary floating point.
/// Whole amounts omit the decimal part so ₦75,000 stays readable.
String formatMoney(int minor, String currency, {bool forceDecimals = false}) {
  final negative = minor < 0;
  final abs = minor.abs();
  final whole = abs ~/ 100;
  final frac = abs % 100;
  final symbol = supportedCurrencies[currency] ?? '$currency ';
  final body = StringBuffer(symbol)..write(_group(whole.toString()));
  if (forceDecimals || frac != 0) {
    body
      ..write('.')
      ..write(frac.toString().padLeft(2, '0'));
  }
  return negative ? '-$body' : body.toString();
}

String _group(String digits) {
  final buffer = StringBuffer();
  for (var i = 0; i < digits.length; i++) {
    if (i > 0 && (digits.length - i) % 3 == 0) buffer.write(',');
    buffer.write(digits[i]);
  }
  return buffer.toString();
}

/// Parses `1500`, `1,500.50`, or `₦1500` into minor units.
int parseMoneyToMinor(String raw) {
  var text = raw.trim().replaceAll(',', '').replaceAll(' ', '');
  for (final symbol in supportedCurrencies.values) {
    text = text.replaceAll(symbol.trim(), '');
  }
  text = text.replaceAll('₦', '').replaceAll('₵', '');
  if (text.isEmpty) {
    throw InvoxaException('Enter an amount.');
  }
  final match = RegExp(r'^(\d+)(?:\.(\d{1,2}))?$').firstMatch(text);
  if (match == null) {
    throw InvoxaException('Enter an amount like 1500 or 1500.50.');
  }
  final whole = int.parse(match.group(1)!);
  final frac = (match.group(2) ?? '').padRight(2, '0');
  return whole * 100 + (frac.isEmpty ? 0 : int.parse(frac));
}

/// `7.5` percent becomes 750 basis points. One basis point is 0.01%.
int parsePercentToBps(String raw) {
  final text = raw.trim();
  if (text.isEmpty) return 0;
  final match = RegExp(r'^(\d{1,3})(?:\.(\d{1,2}))?$').firstMatch(text);
  if (match == null) {
    throw InvoxaException('Enter a tax rate like 7.5.');
  }
  final whole = int.parse(match.group(1)!);
  final frac = (match.group(2) ?? '').padRight(2, '0');
  final bps = whole * 100 + int.parse(frac);
  if (bps > 10000) {
    throw InvoxaException('Tax rate cannot exceed 100%.');
  }
  return bps;
}

String formatBps(int bps) {
  final whole = bps ~/ 100;
  final frac = bps % 100;
  if (frac == 0) return '$whole';
  if (frac % 10 == 0) return '$whole.${frac ~/ 10}';
  return '$whole.${frac.toString().padLeft(2, '0')}';
}

int parseQuantityMilli(String raw) {
  final text = raw.trim();
  final match = RegExp(r'^(\d+)(?:\.(\d{1,3}))?$').firstMatch(text);
  if (match == null) {
    throw InvoxaException('Enter a quantity like 1 or 1.5.');
  }
  final whole = int.parse(match.group(1)!);
  final frac = (match.group(2) ?? '').padRight(3, '0');
  return whole * 1000 + int.parse(frac);
}

String formatQuantity(int milli) {
  final whole = milli ~/ 1000;
  final frac = milli % 1000;
  if (frac == 0) return '$whole';
  final decimals = frac.toString().padLeft(3, '0').replaceFirst(RegExp(r'0+$'), '');
  return '$whole.$decimals';
}

String unitLabel(String unit, String? customUnit) {
  if (unit == UnitType.custom.name) {
    final custom = customUnit?.trim() ?? '';
    return custom.isEmpty ? 'Custom' : custom;
  }
  return UnitTypeLabel.parse(unit).label;
}
