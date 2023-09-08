import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:lunch_app/home/home_page_buttons.dart';

import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest_all.dart' as tz;
import 'dart:async';

class notification {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  Future<void> initilizeNotification() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings("@mipmap/ic_launcher");
    const InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  Future<void> showNotification(int id, String title, String body) async {
    tz.initializeTimeZones();
    var SheduleDate1 = tz.TZDateTime.from(
        DateTime(now.year, now.month, now.day, 10, 0, 0), tz.local);
    var SheduleDate2 = tz.TZDateTime.from(
        DateTime(now.year, now.month, now.day, 10, 30, 0), tz.local);

    var nextDay = DateTime.now().add(Duration(days: 1));
    var nextDay10 = tz.TZDateTime.from(
        DateTime(nextDay.year, nextDay.month, nextDay.day, 10, 0, 0), tz.local);
    var nextDay1030 = tz.TZDateTime.from(
        DateTime(nextDay.year, nextDay.month, nextDay.day, 10, 30, 0),
        tz.local);

    await _scheduleNotification(id, title, body, SheduleDate1);
    await _scheduleNotification(id + 1, title, body, nextDay10);
    await _scheduleNotification(id + 2, "Alert..❗️",
        "time is too short..🕚  update your food broooo ;", SheduleDate2);
    await _scheduleNotification(id + 3, "Alert..❗️",
        "time is too short..🕚  update your food broooo ;", nextDay1030);
  }

  Future<void> _scheduleNotification(
      int id, String title, String body, tz.TZDateTime SheduleDate1) async {
    await flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      SheduleDate1,
      NotificationDetails(
        android: AndroidNotificationDetails(
          id.toString(),
          "update your lunch ",
          importance: Importance.max,
          priority: Priority.max,
          icon: "@mipmap/ic_launcher",
        ),
      ),
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }
}
