// ignore_for_file: constant_identifier_names
import 'package:flutter/material.dart';
import 'package:garing_bakery_apk/features/auth/presenter/pages/auth_page.dart';
import 'package:garing_bakery_apk/features/auth/presenter/pages/splash_page.dart';
import 'package:garing_bakery_apk/features/dashboard/presenter/pages/dashboard_page.dart';
import 'package:garing_bakery_apk/features/product/presenter/pages/add_product_page.dart';
import 'package:garing_bakery_apk/features/transaction/presenter/pages/show_transaction_page.dart';
import 'package:garing_bakery_apk/features/transaction/presenter/pages/transaction_page.dart';
import 'package:page_transition/page_transition.dart';

class Routes {
  static const String SPLASH = '/splash';
  static const String LOGIN = '/login';
  static const String DASHBOARD = '/dashboard';
  static const String TRANSACTIONS = '/transactions';
  static const String TRANSACTIONS_SHOW = '/transactions_show';

  // product
  static const String ADD_PRODUCT = '/add_product';

  static Route<dynamic> generateRoute(settings) {
    switch (settings.name) {
      case Routes.DASHBOARD:
        return PageTransition(
            child: const DashboardPage(), type: PageTransitionType.fade);
      case Routes.SPLASH:
        return PageTransition(
            child: const SplashPage(), type: PageTransitionType.bottomToTop);
      case Routes.LOGIN:
        return PageTransition(
            child: const AuthLogin(), type: PageTransitionType.fade);
      case Routes.TRANSACTIONS:
        return PageTransition(
            child: const TransactionPage(),
            type: PageTransitionType.bottomToTop);
      case Routes.TRANSACTIONS_SHOW:
        return PageTransition(
            child: const TransactionShowPage(),
            type: PageTransitionType.bottomToTop);
      case Routes.ADD_PRODUCT:
        return PageTransition(
            child: AddProductPage(),
            type: PageTransitionType.rightToLeftWithFade);
      default:
        return PageTransition(
            child: const DashboardPage(), type: PageTransitionType.fade);
    }
  }
}
