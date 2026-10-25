import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/db/app_database.dart';
import '../data/invoxa_store.dart';
import '../data/reminder_scheduler.dart';
import 'gate.dart';

final gateProvider = Provider<AppGate>((ref) => AppGate());

final schedulerProvider = Provider<ReminderScheduler>((ref) => NoopReminderScheduler());

final notificationOpens = Provider<ValueNotifier<String?>>((ref) => ValueNotifier<String?>(null));

final onboardingDraftProvider = Provider<OnboardingDraft>((ref) => OnboardingDraft());

final storeProvider = Provider<InvoxaStore>((ref) {
  final database = AppDatabase.defaults();
  ref.onDispose(database.close);
  return InvoxaStore(database, scheduler: ref.watch(schedulerProvider));
});

class Revision extends Notifier<int> {
  @override
  int build() => 0;

  void bump() => state++;
}

final revisionProvider = NotifierProvider<Revision, int>(Revision.new);

void refresh(WidgetRef ref) => ref.read(revisionProvider.notifier).bump();
