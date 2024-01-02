// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:garing_bakery_apk/features/auth/presenter/pages/auth_page.dart';
import 'package:garing_bakery_apk/features/auth/presenter/pages/splash_page.dart';
import 'package:garing_bakery_apk/features/dashboard/presenter/pages/dashboard_page.dart';

class Routes {
  static const String SPLASH = '/splash';
  static const String LOGIN = '/login';
  static const String DASHBOARD = '/dashboard';

  static Route<dynamic> generateRoute(settings) {
    switch (settings.name) {
      case Routes.SPLASH:
        return MaterialPageRoute(
            builder: (BuildContext context) => const SplashPage());
      case Routes.LOGIN:
        return MaterialPageRoute(
            builder: (BuildContext context) => const AuthPage());
      case Routes.DASHBOARD:
        return MaterialPageRoute(
            builder: (BuildContext context) => const DashboardPage());
      default:
        return MaterialPageRoute(
            builder: (BuildContext context) => const SplashPage());
    }
  }
}
