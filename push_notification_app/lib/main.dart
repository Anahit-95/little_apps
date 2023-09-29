import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import './services/local_notification_service.dart';
import 'timer_app/timer_screen.dart';
import 'push_fcm/main_screen.dart';
import './green_page.dart';
import './red_page.dart';

//Receive message when app is in background solution for on message
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print('Handling a background message ${message.messageId}');
  print(message.data.toString());
  print(message.notification!.title);
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // await FirebaseMessaging.instance.getInitialMessage();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // home: const MainScreen(),
      // home: const TimerScreen(),
      home: MyHomePage(
        title: 'Flutter Demo Home Page',
      ),
      routes: {
        'red': (_) => RedPage(),
        'green': (_) => GreenPage(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();

    LocalNotificationService.initialize(context);

    // gives you the message on which user taps
    // and it opened the app from terminated state
    FirebaseMessaging.instance.getInitialMessage().then((message) {
      if (message != null) {
        final routeFromMessage = message.data["routePage"];
        Navigator.of(context).pushNamed(routeFromMessage);
      }
    });

    // foreground work
    FirebaseMessaging.onMessage.listen((message) {
      if (message.notification != null) {
        print(message.notification!.body);
        print(message.notification!.title);
      }
      LocalNotificationService.display(message);
    });

    // When the app is in background but opened and user taps on the notification
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      final routeFromMessage = message.data["routePage"];
      Navigator.of(context).pushNamed(routeFromMessage);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Center(
          child: Text(
            'You will receive message soon',
            style: TextStyle(fontSize: 34),
          ),
        ),
      ),
    );
  }
}
