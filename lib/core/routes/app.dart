// ignore_for_file: constant_identifier_names
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
        return PageTransition(
            child: const AuthLogin(), type: PageTransitionType.fade);
      case Routes.DASHBOARD:
        return PageTransition(
            child: const DashboardPage(), type: PageTransitionType.fade);
      case Routes.TRANSACTIONS:
        return PageTransition(
            child: const TransactionPage(),
            type: PageTransitionType.bottomToTop);
      default:
        return PageTransition(
            child: const SplashPage(), type: PageTransitionType.fade);
    }
  }
}
