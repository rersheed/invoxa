import 'dart:io';

import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:invoxa/data/db/app_database.dart';
import 'package:sqlite3/sqlite3.dart';

void main() {
  test('version 1 settings gain the insight flag', () async {
    final fresh = AppDatabase(NativeDatabase.memory());
    final create = await fresh
        .customSelect("SELECT sql FROM sqlite_master WHERE name = 'app_settings'")
        .map((row) => row.read<String>('sql'))
        .getSingle();
    await fresh.close();

    const column =
        ', "insight_enabled" INTEGER NOT NULL DEFAULT 1 CHECK ("insight_enabled" IN (0, 1))';
    expect(create, contains(column));
    final legacy = create.replaceFirst(column, '');
    expect(legacy.toLowerCase(), isNot(contains('insight_enabled')));

    final raw = sqlite3.openInMemory();
    raw.execute(legacy);
    raw.execute('PRAGMA user_version = 1');
    raw.execute(
      "INSERT INTO app_settings (id, created_at, updated_at) VALUES ('app', 0, 0)",
    );

    final upgraded = AppDatabase(NativeDatabase.opened(raw));
    final columns = await upgraded.customSelect('PRAGMA table_info(app_settings)').get();
    final names = columns.map((row) => row.read<String>('name')).toList();
    expect(names, contains('insight_enabled'));
    final row = await upgraded.select(upgraded.appSettings).getSingle();
    expect(row.insightEnabled, isTrue);
    expect(upgraded.schemaVersion, 2);
    await upgraded.close();
  });

  test('a corrupt database file cannot be read as empty data', () async {
    final directory = await Directory.systemTemp.createTemp('invoxa-corrupt');
    final file = File('${directory.path}/broken.sqlite')..writeAsStringSync('this is not a database');
    final db = AppDatabase(NativeDatabase(file));
    await expectLater(db.customSelect('SELECT 1').get(), throwsA(anything));
    await db.close();
  });
}
