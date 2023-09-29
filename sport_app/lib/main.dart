import 'package:flutter/material.dart';
import 'package:get/get.dart';

import './home_page.dart';
import 'video_info.dart';

void main() {
  runApp(const MyApp());
}

//Open AI API_KEY = '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'

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
      // home: VideoInfo(),
    );
  }
}
