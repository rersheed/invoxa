import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:cryptography/cryptography.dart';

import '../errors.dart';
import '../invoicing/invoice_math.dart';

const backupFormat = 'invoxa-backup';
const backupVersion = 1;
const backupIterations = 120000;

const backupTables = <String>[
  'businesses',
  'brandProfiles',
  'bankAccounts',
  'services',
  'customers',
  'invoices',
  'invoiceItems',
  'payments',
  'receipts',
  'reminders',
  'messageTemplates',
  'appSettings',
  'backupMetadata',
];

class BackupDocument {
  BackupDocument({required this.exportedAt, required this.tables});

  final DateTime exportedAt;
  final Map<String, List<Map<String, Object?>>> tables;
}

class BackupCodec {
  BackupCodec({Random? random}) : _random = random ?? Random.secure();

  final Random _random;

  Future<Uint8List> encode(
    BackupDocument document, {
    String? password,
    int iterations = backupIterations,
  }) async {
    final tables = _normalize(document.tables);
    final tablesJson = jsonEncode(tables);
    final hash = await _sha256(utf8.encode(tablesJson));
    final payload = <String, Object?>{
      'format': backupFormat,
      'version': backupVersion,
      'exportedAt': document.exportedAt.toUtc().toIso8601String(),
      'encrypted': false,
      'contentSha256': hash,
      'tables': tables,
    };
    final clear = utf8.encode(jsonEncode(payload));
    if (password == null || password.isEmpty) {
      return Uint8List.fromList(clear);
    }
    final salt = _bytes(16);
    final nonce = _bytes(12);
    final key = await _key(password, salt, iterations);
    final box = await AesGcm.with256bits().encrypt(clear, secretKey: key, nonce: nonce);
    final wrapper = <String, Object?>{
      'format': backupFormat,
      'version': backupVersion,
      'exportedAt': document.exportedAt.toUtc().toIso8601String(),
      'encrypted': true,
      'kdf': 'PBKDF2-HMAC-SHA256',
      'iterations': iterations,
      'salt': base64Encode(salt),
      'nonce': base64Encode(box.nonce),
      'ciphertext': base64Encode(box.cipherText),
      'mac': base64Encode(box.mac.bytes),
    };
    return Uint8List.fromList(utf8.encode(jsonEncode(wrapper)));
  }

  Future<BackupDocument> decode(Uint8List bytes, {String? password}) async {
    final Object? root;
    try {
      root = jsonDecode(utf8.decode(bytes));
    } on FormatException {
      throw InvoxaException('This file is not an INVOXA backup.');
    }
    if (root is! Map) {
      throw InvoxaException('This file is not an INVOXA backup.');
    }
    final map = root.cast<String, Object?>();
    if (map['format'] != backupFormat) {
      throw InvoxaException('This file is not an INVOXA backup.');
    }
    final version = map['version'];
    if (version is! int) {
      throw InvoxaException('This backup is missing a version.');
    }
    if (version > backupVersion) {
      throw InvoxaException('This backup was made by a newer version of INVOXA.');
    }
    if (version < 1) {
      throw InvoxaException('This backup version is not supported.');
    }
    Map<String, Object?> payload = map;
    if (map['encrypted'] == true) {
      if (password == null || password.isEmpty) {
        throw InvoxaException('This backup is encrypted. Enter its password.');
      }
      try {
        final salt = base64Decode(map['salt'] as String);
        final nonce = base64Decode(map['nonce'] as String);
        final cipherText = base64Decode(map['ciphertext'] as String);
        final mac = base64Decode(map['mac'] as String);
        final iterations = map['iterations'];
        if (iterations is! int || iterations < 1) {
          throw const FormatException('iterations');
        }
        final key = await _key(password, salt, iterations);
        final clear = await AesGcm.with256bits().decrypt(
          SecretBox(cipherText, nonce: nonce, mac: Mac(mac)),
          secretKey: key,
        );
        final decoded = jsonDecode(utf8.decode(clear));
        if (decoded is! Map) throw const FormatException('payload');
        payload = decoded.cast<String, Object?>();
      } on InvoxaException {
        rethrow;
      } on SecretBoxAuthenticationError {
        throw InvoxaException('Wrong password, or the backup is damaged.');
      } on Object {
        throw InvoxaException('Wrong password, or the backup is damaged.');
      }
    }
    final tablesRaw = payload['tables'];
    if (tablesRaw is! Map) {
      throw InvoxaException('This backup is missing its data.');
    }
    final tables = <String, List<Map<String, Object?>>>{};
    for (final name in backupTables) {
      final value = tablesRaw[name];
      if (value is! List) {
        throw InvoxaException('This backup is missing $name.');
      }
      tables[name] = value.map((row) {
        if (row is! Map) throw InvoxaException('A $name row is damaged.');
        return row.cast<String, Object?>();
      }).toList();
    }
    final expected = payload['contentSha256'];
    final actual = await _sha256(utf8.encode(jsonEncode(_normalize(tables))));
    if (expected != actual) {
      throw InvoxaException('This backup is damaged or incomplete.');
    }
    validateBackup(tables);
    final exportedAt = DateTime.tryParse('${payload['exportedAt']}')?.toUtc() ?? DateTime.now().toUtc();
    return BackupDocument(exportedAt: exportedAt, tables: tables);
  }

  Map<String, List<Map<String, Object?>>> _normalize(
    Map<String, List<Map<String, Object?>>> tables,
  ) {
    return {for (final name in backupTables) name: tables[name] ?? const []};
  }

  Uint8List _bytes(int length) =>
      Uint8List.fromList(List<int>.generate(length, (_) => _random.nextInt(256)));

  Future<SecretKey> _key(String password, List<int> salt, int iterations) {
    return Pbkdf2.hmacSha256(iterations: iterations, bits: 256).deriveKeyFromPassword(
      password: password,
      nonce: salt,
    );
  }

  Future<String> _sha256(List<int> bytes) async {
    final hash = await Sha256().hash(bytes);
    return hash.bytes.map((byte) => byte.toRadixString(16).padLeft(2, '0')).join();
  }
}

void validateBackup(Map<String, List<Map<String, Object?>>> tables) {
  final businessIds = _ids(tables['businesses']!, 'business');
  final bankIds = _ids(tables['bankAccounts']!, 'bank account');
  final serviceIds = _ids(tables['services']!, 'service');
  final customerIds = _ids(tables['customers']!, 'customer');
  final invoiceIds = _ids(tables['invoices']!, 'invoice');
  final paymentIds = _ids(tables['payments']!, 'payment');

  final numbers = <String>{};
  for (final row in tables['invoices']!) {
    final number = row['number'];
    if (number == null) continue;
    if (number is! String || number.isEmpty) {
      throw InvoxaException('An invoice number is damaged.');
    }
    if (!numbers.add(number)) {
      throw InvoxaException('Invoice number $number appears more than once.');
    }
  }
  final receiptNumbers = <String>{};
  for (final row in tables['receipts']!) {
    final number = _string(row, 'number', 'receipt');
    if (!receiptNumbers.add(number)) {
      throw InvoxaException('Receipt number $number appears more than once.');
    }
    if (!paymentIds.contains(_string(row, 'paymentId', 'receipt'))) {
      throw InvoxaException('A receipt points at a missing payment.');
    }
  }

  final linesByInvoice = <String, List<Map<String, Object?>>>{};
  for (final row in tables['invoiceItems']!) {
    final invoiceId = _string(row, 'invoiceId', 'line');
    if (!invoiceIds.contains(invoiceId)) {
      throw InvoxaException('An invoice line points at a missing invoice.');
    }
    final serviceId = row['serviceId'];
    if (serviceId != null && !serviceIds.contains(serviceId)) {
      throw InvoxaException('An invoice line points at a missing service.');
    }
    linesByInvoice.putIfAbsent(invoiceId, () => []).add(row);
  }
  final paidByInvoice = <String, int>{};
  for (final row in tables['payments']!) {
    final invoiceId = _string(row, 'invoiceId', 'payment');
    if (!invoiceIds.contains(invoiceId)) {
      throw InvoxaException('A payment points at a missing invoice.');
    }
    final amount = _int(row, 'amountMinor', 'payment');
    if (amount <= 0) throw InvoxaException('A payment amount must be greater than zero.');
    paidByInvoice[invoiceId] = (paidByInvoice[invoiceId] ?? 0) + amount;
  }

  for (final row in tables['invoices']!) {
    final id = _string(row, 'id', 'invoice');
    final businessId = _string(row, 'businessId', 'invoice');
    if (!businessIds.contains(businessId) && businessIds.isNotEmpty) {
      throw InvoxaException('An invoice points at a missing business.');
    }
    final customerId = row['customerId'];
    if (customerId != null && !customerIds.contains(customerId)) {
      throw InvoxaException('An invoice points at a missing customer.');
    }
    final bankId = row['bankAccountId'];
    if (bankId != null && !bankIds.contains(bankId)) {
      throw InvoxaException('An invoice points at a missing bank account.');
    }
    final lines = linesByInvoice[id] ?? const [];
    final inputs = <({int quantityMilli, int unitPriceMinor})>[];
    for (final line in lines) {
      final qty = _int(line, 'quantityMilli', 'line');
      final price = _int(line, 'unitPriceMinor', 'line');
      final total = _int(line, 'lineTotalMinor', 'line');
      if (total != lineTotalMinor(qty, price)) {
        throw InvoxaException('An invoice line total does not match its quantity and price.');
      }
      inputs.add((quantityMilli: qty, unitPriceMinor: price));
    }
    final totals = computeTotals(
      lines: inputs,
      discountMinor: _int(row, 'discountMinor', 'invoice'),
      taxRateBps: _int(row, 'taxRateBps', 'invoice'),
      chargesMinor: _int(row, 'chargesMinor', 'invoice'),
    );
    if (totals.subtotalMinor != _int(row, 'subtotalMinor', 'invoice') ||
        totals.taxMinor != _int(row, 'taxMinor', 'invoice') ||
        totals.grandMinor != _int(row, 'grandTotalMinor', 'invoice')) {
      throw InvoxaException('An invoice total does not match its lines.');
    }
    final paid = paidByInvoice[id] ?? 0;
    if (paid > totals.grandMinor) {
      throw InvoxaException('A backup records more payments than the invoice total.');
    }
  }

  for (final row in tables['services']!) {
    if (!businessIds.contains(_string(row, 'businessId', 'service')) && businessIds.isNotEmpty) {
      throw InvoxaException('A service points at a missing business.');
    }
    final bankId = row['bankAccountId'];
    if (bankId != null && !bankIds.contains(bankId)) {
      throw InvoxaException('A service points at a missing bank account.');
    }
    if (_int(row, 'defaultPriceMinor', 'service') < 0) {
      throw InvoxaException('A service price cannot be negative.');
    }
  }
}

Set<String> _ids(List<Map<String, Object?>> rows, String label) {
  final ids = <String>{};
  for (final row in rows) {
    final id = _string(row, 'id', label);
    if (!ids.add(id)) throw InvoxaException('A $label is listed twice.');
  }
  return ids;
}

String _string(Map<String, Object?> row, String key, String label) {
  final value = row[key];
  if (value is! String || value.isEmpty) {
    throw InvoxaException('A $label is missing $key.');
  }
  return value;
}

int _int(Map<String, Object?> row, String key, String label) {
  final value = row[key];
  if (value is! int || value < 0) {
    throw InvoxaException('A $label has a damaged $key.');
  }
  return value;
}
