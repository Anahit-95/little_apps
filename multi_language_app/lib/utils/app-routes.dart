import 'package:get/get.dart';
import '../screens/language_screen.dart';
import '../screens/splash_screen.dart';

class RouteHelper {
  static const String initial = '/';
  static const String splash = '/splash';
  static const String language = '/language';
  static String getSplashRoute() => '$splash';
  static String getInitialRoute() => '$initial';
  static String getLanguageRoute() => '$language';

  static List<GetPage> routes = [
    GetPage(
      name: splash,
      page: () {
        return SplashScreen();
      },
    ),
    // GetPage(name: initial, page: () {
    //   return HomePage();
    // }),
    GetPage(
      name: language,
      page: () {
        return LanguageScreen();
      },
    )
  ];
}
