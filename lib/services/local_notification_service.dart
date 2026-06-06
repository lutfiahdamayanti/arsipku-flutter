import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotificationService {

  static final FlutterLocalNotificationsPlugin
      flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static Future init() async {

    const AndroidInitializationSettings
        initializationSettingsAndroid =
        AndroidInitializationSettings(
      '@mipmap/ic_launcher',
    );

    const InitializationSettings
        initializationSettings =
        InitializationSettings(
      android:
          initializationSettingsAndroid,
    );

    await flutterLocalNotificationsPlugin
        .initialize(
      initializationSettings,
    );
  }

  static Future showNotification({

    required String title,

    required String body,

  }) async {

    const AndroidNotificationDetails
        androidDetails =
        AndroidNotificationDetails(

      "arsip_channel",

      "Arsip Notification",

      importance:
          Importance.max,

      priority:
          Priority.high,

      playSound: true,

    );

    const NotificationDetails
        details =
        NotificationDetails(

      android:
          androidDetails,

    );

    await flutterLocalNotificationsPlugin.show(

      DateTime.now()
          .millisecondsSinceEpoch ~/1000,

      title,

      body,

      details,

    );
  }
}