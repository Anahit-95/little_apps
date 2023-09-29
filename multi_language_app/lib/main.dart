import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multi_language_app/controller/language_controller.dart';
import 'package:multi_language_app/utils/app_constants.dart';

import './screens/splash_screen.dart';
import 'utils/app-routes.dart';
import 'utils/messages.dart';
import 'utils/dep.dart' as dep;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Map<String, Map<String, String>> _languages = await dep.init();

  runApp(MyApp(languages: _languages));
}

class MyApp extends StatelessWidget {
  const MyApp({required this.languages});
  final Map<String, Map<String, String>> languages;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LocalizationController>(
        builder: (localizationController) {
      return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        locale: localizationController.locale,
        translations: Messages(languages: languages),
        fallbackLocale: Locale(AppConstants.languages[0].languageCode,
            AppConstants.languages[0].countryCode),
        initialRoute: RouteHelper.getSplashRoute(),
        getPages: RouteHelper.routes,
      );
    });
  }
}
