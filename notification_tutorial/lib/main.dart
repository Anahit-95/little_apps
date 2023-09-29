import 'package:flutter/material.dart';
import 'package:awesome_notifications/awesome_notifications.dart';

import './home_page.dart';

//for timer
import './timer/stopwatch.dart';
import 'plant_statsPage.dart';
import 'widgets.dart';

void main() {
  AwesomeNotifications()
      .initialize('resource://drawable/res_notification_app_icon', [
    NotificationChannel(
      channelKey: 'basic_channel',
      channelName: 'Basic Notifications',
      channelDescription: 'Description',
      defaultColor: Colors.teal,
      importance: NotificationImportance.High,
      channelShowBadge: true,
    ),
    NotificationChannel(
      channelKey: 'scheduled_channel',
      channelName: 'Scheduled Notifications',
      channelDescription: 'Scheluded description',
      defaultColor: Colors.teal,
      locked: true,
      importance: NotificationImportance.Max,
      soundSource: 'resource://raw/res_custom_notification',
      enableLights: true,
      channelShowBadge: true,
      ledColor: Colors.white,
      enableVibration: true,
    )
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.teal,
        secondaryHeaderColor: Colors.tealAccent,
      ),
      // theme: ThemeData.dark().copyWith(
      //   scaffoldBackgroundColor: Colors.black,
      // ),
      title: 'Green Thumbs',
      // home: HomePage(),
      home: MyHomePage(),
      routes: {
        PlantStatsPage.routeName: (context) => PlantStatsPage(),
      },
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

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
              // Navigator.of(context).pushNamed(PlantStatsPage.routeName);
            },
            icon: Icon(
              Icons.insert_chart_outlined_rounded,
              size: 30,
            ),
          ),
        ],
      ),
      body: Center(child: Stopwatch()),
    );
  }
}
