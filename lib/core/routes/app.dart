// ignore_for_file: constant_identifier_names

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:garing_bakery_apk/features/auth/presenter/pages/auth_page.dart';
import 'package:garing_bakery_apk/features/auth/presenter/pages/splash_page.dart';
import 'package:garing_bakery_apk/features/dashboard/presenter/pages/dashboard_page.dart';
import 'package:garing_bakery_apk/features/transaction/presenter/pages/transaction_page.dart';
import 'package:page_transition/page_transition.dart';

class Routes {
  static const String SPLASH = '/splash';
  static const String LOGIN = '/login';
  static const String DASHBOARD = '/dashboard';
  static const String TRANSACTIONS = '/transactions';

  static Route<dynamic> generateRoute(settings) {
    switch (settings.name) {
      case Routes.SPLASH:
        return PageTransition(
            child: const SplashPage(), type: PageTransitionType.bottomToTop);
      case Routes.LOGIN:
        return MaterialPageRoute(
            builder: (BuildContext context) => const AuthPage());
      case Routes.DASHBOARD:
        return MaterialPageRoute(
            builder: (BuildContext context) => const DashboardPage());
      case Routes.TRANSACTIONS:
        return PageTransition(
            child: const TransactionPage(), type: PageTransitionType.fade);
      default:
        return PageTransition(
            child: const SplashPage(), type: PageTransitionType.fade);
    }
  }
}
