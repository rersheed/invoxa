import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:timezone/data/latest.dart' as tzdata;
import 'package:timezone/timezone.dart' as tz;

import 'reminder_scheduler.dart';

class LocalReminderScheduler implements ReminderScheduler {
  LocalReminderScheduler(this.opened);

  final ValueNotifier<String?> opened;
  final FlutterLocalNotificationsPlugin _plugin = FlutterLocalNotificationsPlugin();
  var _ready = false;

  Future<void> init() async {
    try {
      tzdata.initializeTimeZones();
      final info = await FlutterTimezone.getLocalTimezone();
      tz.setLocalLocation(tz.getLocation(info.identifier));
    } on Object {
      tzdata.initializeTimeZones();
      tz.setLocalLocation(tz.UTC);
    }
    try {
      await _plugin.initialize(
        settings: const InitializationSettings(
          android: AndroidInitializationSettings('@drawable/ic_stat_invoxa'),
        ),
        onDidReceiveNotificationResponse: _onResponse,
      );
      final launch = await _plugin.getNotificationAppLaunchDetails();
      final payload = launch?.notificationResponse?.payload;
      if ((launch?.didNotificationLaunchApp ?? false) && payload != null && payload.isNotEmpty) {
        opened.value = payload;
      }
      _ready = true;
    } on Object {
      _ready = false;
    }
  }

  void _onResponse(NotificationResponse response) {
    final payload = response.payload;
    if (payload != null && payload.isNotEmpty) opened.value = payload;
  }

  Future<bool> requestPermission() async {
    final android = _plugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>();
    final granted = await android?.requestNotificationsPermission();
    return granted ?? false;
  }

  Future<bool> requestExactAlarms() async {
    final android = _plugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>();
    final granted = await android?.requestExactAlarmsPermission();
    return granted ?? false;
  }

  Future<AndroidScheduleMode> _mode() async {
    try {
      final android = _plugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>();
      final exact = await android?.canScheduleExactNotifications() ?? false;
      if (exact) return AndroidScheduleMode.exactAllowWhileIdle;
    } on Object {
      // Fall through to an inexact alarm. Android can deny exact alarms.
    }
    return AndroidScheduleMode.inexactAllowWhileIdle;
  }

  @override
  Future<void> cancel(int id) async {
    if (!_ready || id == 0) return;
    try {
      await _plugin.cancel(id: id);
    } on Object {
      // A missing alarm is already gone.
    }
  }

  @override
  Future<void> schedule({
    required int id,
    required DateTime when,
    required String title,
    required String body,
    required String payload,
  }) async {
    if (!_ready) return;
    final details = const NotificationDetails(
      android: AndroidNotificationDetails(
        'invoxa.reminders',
        'Invoice reminders',
        channelDescription: 'Due dates and overdue invoices',
        importance: Importance.high,
        priority: Priority.high,
      ),
    );
    final scheduled = tz.TZDateTime.from(when, tz.local);
    try {
      await _plugin.zonedSchedule(
        id: id,
        title: title,
        body: body,
        scheduledDate: scheduled,
        notificationDetails: details,
        androidScheduleMode: await _mode(),
        payload: payload,
      );
    } on PlatformException {
      await _plugin.zonedSchedule(
        id: id,
        title: title,
        body: body,
        scheduledDate: scheduled,
        notificationDetails: details,
        androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
        payload: payload,
      );
    }
  }
}
