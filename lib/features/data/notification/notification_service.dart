import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:testproject/features/models/last_house_selected.dart';

class NotificationApi {
  static final _notification = FlutterLocalNotificationsPlugin();

  static Future init() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    final DarwinInitializationSettings initializationSettingsDarwin =
        DarwinInitializationSettings(
            onDidReceiveLocalNotification: (id, title, body, payload) => null);
    const LinuxInitializationSettings initializationSettingsLinux =
        LinuxInitializationSettings(defaultActionName: 'Open notification');
    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid,
            iOS: initializationSettingsDarwin,
            macOS: initializationSettingsDarwin,
            linux: initializationSettingsLinux);
    await _notification.initialize(initializationSettings,
        onDidReceiveNotificationResponse: (details) => null);
  }

  static Future showPeriodicNotification() async {
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails('channel 2', 'your channel name',
            channelDescription: 'your channel description',
            importance: Importance.max,
            priority: Priority.high,
            ticker: 'ticker');
    const NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails);
    if (LastHouseSelected.lastHouseSelected != null) {
      int floor =
          LastHouseSelected.lastHouseSelected!.listFloor.indexOf(true) + 1;
      await _notification.periodicallyShow(
          1,
          'Notification',
          'Floor in the last house ${floor.toString()}',
          RepeatInterval.everyMinute,
          notificationDetails);
    }
  }
}
