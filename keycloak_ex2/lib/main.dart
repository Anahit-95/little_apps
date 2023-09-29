import 'package:flutter/material.dart';

import 'home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'OpenId Client Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // fontFamily: 'Times New Roman',
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF1A5073),
        ),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}
