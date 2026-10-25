import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:invoxa/core/backup/backup_codec.dart';
import 'package:invoxa/core/errors.dart';

void main() {
  test('rejects a corrupt file and a bad password', () async {
    final codec = BackupCodec();
    expect(codec.decode(Uint8List.fromList([1, 2, 3])), throwsA(isA<InvoxaException>()));
    expect(
      codec.decode(Uint8List.fromList(utf8.encode('{"format":"nope"}'))),
      throwsA(isA<InvoxaException>()),
    );

    final encoded = await codec.encode(
      BackupDocument(
        exportedAt: DateTime.utc(2026, 10, 25),
        tables: {for (final name in backupTables) name: <Map<String, Object?>>[]},
      ),
      password: 'right-password',
      iterations: 2000,
    );
    expect(
      codec.decode(encoded, password: 'wrong-password'),
      throwsA(predicate((error) => error is InvoxaException && error.message.contains('Wrong password'))),
    );
    final decoded = await codec.decode(encoded, password: 'right-password');
    expect(decoded.tables['invoices'], isEmpty);

    final damaged = Uint8List.fromList(encoded);
    damaged[damaged.length - 5] ^= 0x5a;
    expect(codec.decode(damaged, password: 'right-password'), throwsA(isA<InvoxaException>()));
  });
}
