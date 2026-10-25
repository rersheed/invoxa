abstract class ReminderScheduler {
  Future<void> schedule({
    required int id,
    required DateTime when,
    required String title,
    required String body,
    required String payload,
  });

  Future<void> cancel(int id);
}

class NoopReminderScheduler implements ReminderScheduler {
  @override
  Future<void> cancel(int id) async {}

  @override
  Future<void> schedule({
    required int id,
    required DateTime when,
    required String title,
    required String body,
    required String payload,
  }) async {}
}

class RecordingScheduler implements ReminderScheduler {
  final scheduled = <int, String>{};
  final cancelled = <int>[];

  @override
  Future<void> cancel(int id) async {
    cancelled.add(id);
    scheduled.remove(id);
  }

  @override
  Future<void> schedule({
    required int id,
    required DateTime when,
    required String title,
    required String body,
    required String payload,
  }) async {
    scheduled[id] = body;
  }
}
