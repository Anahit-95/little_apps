import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotificationService {
  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static void initialize(BuildContext context) {
    InitializationSettings initializationSettings =
        const InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher'),
    );
    _notificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (detail) {
        Navigator.of(context).pushNamed(detail.payload!);
      },
    );
  }

  static void display(RemoteMessage message) async {
    try {
      final id = DateTime.now().millisecondsSinceEpoch ~/ 1000;

      NotificationDetails notificationDetails = const NotificationDetails(
        android: AndroidNotificationDetails(
          'dbfood',
          'dbfood channel'
              'This is our channel',
          importance: Importance.max,
          priority: Priority.high,
        ),
      );
      await _notificationsPlugin.show(
        id,
        message.notification!.title,
        message.notification!.body,
        notificationDetails,
        payload: message.data['routePage'],
      );
    } on Exception catch (e) {
      print(e);
    }
  }
}
