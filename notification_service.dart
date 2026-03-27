import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  static final FlutterLocalNotificationsPlugin notificationsPlugin =
  FlutterLocalNotificationsPlugin();

  static Future init() async {
    const AndroidInitializationSettings androidSettings =
    AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings settings =
    InitializationSettings(android: androidSettings);

    await notificationsPlugin.initialize(settings);

    await notificationsPlugin
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();
  }

  // 🔔 instant
  static Future showNotification() async {
    await notificationsPlugin.show(
      0,
      "Medicine Reminder",
      "Time to take your medicine 💊",
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'simple_channel',
          'Simple Notifications',
          importance: Importance.max,
          priority: Priority.high,
        ),
      ),
    );
  }

  // ⏰ scheduled (SAFE)
  static Future scheduleNotification(
      int id, String title, DateTime time) async {
    final delay = time.difference(DateTime.now());

    if (delay.isNegative) return;

    await Future.delayed(delay, () {
      showNotification();
    });
  }

  static Future cancelNotification(int id) async {
    await notificationsPlugin.cancel(id);
  }
}
