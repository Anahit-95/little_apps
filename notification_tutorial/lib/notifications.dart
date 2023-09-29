import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import './utilities.dart';
import 'plant_statsPage.dart';

Future<void> createPlantFoodNotification() async {
  String timezon = await AwesomeNotifications().getLocalTimeZoneIdentifier();

  await AwesomeNotifications().createNotification(
    content: NotificationContent(
      id: createUniqueId(),
      channelKey: 'basic_channel',
      title:
          '${Emojis.money_money_bag + Emojis.plant_cactus} Buy Plant Food!!!',
      body: 'Florist at 123 Main St. has 2 in stock',
      bigPicture: 'asset://assets/notification_map.png',
      notificationLayout: NotificationLayout.BigPicture,
    ),
    schedule:
        NotificationInterval(interval: 10, timeZone: timezon, repeats: false),
  );
}

Future<void> createWaterReminderNotification(
    NotificationWeekAndTime notificationSchedule) async {
  await AwesomeNotifications().createNotification(
    content: NotificationContent(
      id: createUniqueId(),
      channelKey: 'scheduled_channel',
      title: '${Emojis.wheater_droplet} Add some water to your plant!',
      body: 'Water your plant regularly to keep it healthy.',
      notificationLayout: NotificationLayout.Default,
      customSound: 'resource://raw/res_custom_notification',
      showWhen: true,
    ),
    actionButtons: [
      NotificationActionButton(
        key: 'MARK_DONE',
        label: 'Mark Done',
      ),
    ],
    schedule: NotificationCalendar(
      weekday: notificationSchedule.dayOfTheWeek,
      hour: notificationSchedule.timeOfDay.hour,
      minute: notificationSchedule.timeOfDay.minute,
      second: 0,
      millisecond: 0,
      repeats: true,
    ),
  );
}

Future<void> canselScheduledNotifications() async {
  await AwesomeNotifications().cancelAllSchedules();
}

class NotificationController {
  static Future<void> startListeningNotificationEvents(context) async {
    AwesomeNotifications().setListeners(
        onActionReceivedMethod: (receivedAction) async {
      NotificationController.onActionReceivedMethod(receivedAction, context);
    }, onNotificationCreatedMethod: (receivedNotification) async {
      NotificationController.onNotificationCreatedMethod(
          receivedNotification, context);
    });
  }

  /// Use this method to detect when a new notification or a schedule is created
  @pragma("vm:entry-point")
  static Future<void> onNotificationCreatedMethod(
      ReceivedNotification receivedNotification, context) async {
    // Your code goes here
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content:
            Text('Notification Created on ${receivedNotification.channelKey}'),
      ),
    );
  }

  /// Use this method to detect every time that a new notification is displayed
  @pragma("vm:entry-point")
  static Future<void> onNotificationDisplayedMethod(
      ReceivedNotification receivedNotification) async {
    // Your code goes here
  }

  /// Use this method to detect if the user dismissed a notification
  @pragma("vm:entry-point")
  static Future<void> onDismissActionReceivedMethod(
      ReceivedAction receivedAction) async {
    // Your code goes here
  }

  /// Use this method to detect when the user taps on a notification or action button
  @pragma("vm:entry-point")
  static Future<void> onActionReceivedMethod(
      ReceivedAction receivedAction, context) async {
    // Your code goes here

    if (receivedAction.channelKey == 'basic_channel' &&
        defaultTargetPlatform == TargetPlatform.iOS) {
      AwesomeNotifications().getGlobalBadgeCounter().then(
            (value) => AwesomeNotifications().setGlobalBadgeCounter(value - 1),
          );
    }
    // Navigate into pages, avoiding to open the notification details page over another details page already opened
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => PlantStatsPage()),
      (route) => route.isFirst,
    );
  }
}
