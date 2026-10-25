import 'package:flutter/foundation.dart';

import '../domain/models.dart';

class AppGate extends ChangeNotifier {
  bool ready = false;
  bool onboarded = false;
  bool locked = false;
  bool pinEnabled = false;
  bool protectSensitive = true;
  int autoLockSeconds = 60;
  String? pendingInvoice;
  String? nextLocation;

  void apply(AppSettingsData settings, {bool? locked}) {
    pinEnabled = settings.pinEnabled;
    protectSensitive = settings.protectSensitive;
    autoLockSeconds = settings.autoLockSeconds;
    update(ready: true, onboarded: settings.onboardingComplete, locked: locked ?? this.locked);
  }

  void update({required bool ready, required bool onboarded, required bool locked}) {
    final changed = this.ready != ready || this.onboarded != onboarded || this.locked != locked;
    this.ready = ready;
    this.onboarded = onboarded;
    this.locked = locked;
    if (changed) notifyListeners();
  }

  void unlockTowards(String location) {
    nextLocation = location;
    update(ready: true, onboarded: onboarded, locked: false);
  }
}

class OnboardingDraft {
  Uint8List? logo;
  Uint8List? signature;
}
