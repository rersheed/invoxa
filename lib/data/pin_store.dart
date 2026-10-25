import 'dart:convert';

import 'package:cryptography/cryptography.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class PinStore {
  PinStore({FlutterSecureStorage? storage}) : _storage = storage ?? const FlutterSecureStorage();

  static const _key = 'invoxa.pin';
  final FlutterSecureStorage _storage;

  Future<String> _hash(String pin) async {
    final digest = await Sha256().hash(utf8.encode('invoxa-pin:$pin'));
    return base64Encode(digest.bytes);
  }

  Future<void> save(String pin) => _hash(pin).then((value) => _storage.write(key: _key, value: value));

  Future<bool> matches(String pin) async {
    final stored = await _storage.read(key: _key);
    if (stored == null || stored.isEmpty) return false;
    return stored == await _hash(pin);
  }

  Future<void> clear() => _storage.delete(key: _key);
}

final pinStore = PinStore();
