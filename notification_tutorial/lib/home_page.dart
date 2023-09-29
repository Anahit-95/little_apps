import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:notification_tutorial/utilities.dart';

import './notifications.dart';
import './plant_statsPage.dart';
import './widgets.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Allow Notifications'),
            content: Text('Our app would like to send you notifications'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  'Don\'t allow',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 18,
                  ),
                ),
              ),
              TextButton(
                onPressed: () => AwesomeNotifications()
                    .requestPermissionToSendNotifications()
                    .then(
                      (_) => Navigator.pop(context),
                    ),
                child: const Text(
                  'Allow',
                  style: TextStyle(
                    color: Colors.teal,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        );
      }
    });

    // AwesomeNotifications().createdStream.listen((notification) {
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     SnackBar(
    //       content: Text('Notification Created on ${notification.channelKey}'),
    //     ),
    //   );
    // });

    // AwesomeNotifications().actionStream.listen((notification) {
    //   if (notification.channelKey == 'basic_channel' &&
    //       defaultTargetPlatform == TargetPlatform.iOS) {
    //     AwesomeNotifications().getGlobalBadgeCounter().then(
    //           (value) =>
    //               AwesomeNotifications().setGlobalBadgeCounter(value - 1),
    //         );
    //   }
    //   Navigator.pushAndRemoveUntil(
    //     context,
    //     MaterialPageRoute(builder: (_) => PlantStatsPage()),
    //     (route) => route.isFirst,
    //   );
    // });

    // AwesomeNotifications().setListeners(
    //     onActionReceivedMethod: (receivedAction) async {
    //   NotificationController.onActionReceivedMethod(receivedAction, context);
    // }, onNotificationCreatedMethod: (receivedNotification) async {
    //   NotificationController.onNotificationCreatedMethod(
    //       receivedNotification, context);
    // });

    super.initState();
  }

  // @override
  // void dispose() {
  //   AwesomeNotifications().actionSink.close();
  //   AwesomeNotifications().createdSink.close();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: AppBarTitle(),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => PlantStatsPage(),
                ),
              );
            },
            icon: Icon(
              Icons.insert_chart_outlined_rounded,
              size: 30,
            ),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            PlantImage(),
            SizedBox(
              height: 25,
            ),
            HomePageButtons(
              onPressedOne: createPlantFoodNotification,
              onPressedTwo: () async {
                NotificationWeekAndTime? pickedSchedule =
                    await pickSchedule(context);
                if (pickedSchedule != null) {
                  createWaterReminderNotification(pickedSchedule);
                }
              },
              onPressedThree: canselScheduledNotifications,
            )
          ],
        ),
      ),
    );
  }
}
