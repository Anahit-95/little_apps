import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/app-routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController _controller;
  GlobalKey<ScaffoldState> _globalKey = GlobalKey();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 2))
          ..forward();
    animation = CurvedAnimation(parent: _controller, curve: Curves.linear);
    Timer(
      const Duration(seconds: 3),
      () => Get.offNamed(
        RouteHelper.getLanguageRoute(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKey,
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ScaleTransition(
            scale: animation,
            child: Center(
              child: Image.asset(
                'img/logo.png',
                width: 200,
              ),
            ),
          ),
          Center(
            child: Image.asset(
              'img/logo2.png',
              width: 150,
            ),
          )
        ],
      ),
    );
  }
}
