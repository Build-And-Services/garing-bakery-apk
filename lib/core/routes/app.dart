// ignore_for_file: constant_identifier_names
import 'package:flutter/material.dart';
import 'package:garing_bakery_apk/features/auth/presenter/pages/auth_page.dart';
import 'package:garing_bakery_apk/features/auth/presenter/pages/splash_page.dart';
import 'package:garing_bakery_apk/features/category/presenter/pages/add_category_page.dart';
import 'package:garing_bakery_apk/features/dashboard/presenter/pages/dashboard_page.dart';
import 'package:garing_bakery_apk/features/product/presenter/pages/add_product_page.dart';
import 'package:garing_bakery_apk/features/reports/presenter/pages/reports_page.dart';
import 'package:garing_bakery_apk/features/reports/presenter/pages/reports_sales_page.dart';
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

  static const String ADD_CATEGORY = '/add_category';

  // reports
  static const String REPORTS = '/reports';
  static const String REPORTS_SALES = '/reports_sales';

  static Route<dynamic> generateRoute(settings) {
    switch (settings.name) {
      case Routes.DASHBOARD:
        return PageTransition(
          child: const DashboardPage(),
          type: PageTransitionType.fade,
        );
      case Routes.SPLASH:
        return PageTransition(
          child: const SplashPage(),
          type: PageTransitionType.bottomToTop,
        );
      case Routes.LOGIN:
        return PageTransition(
          child: const AuthLogin(),
          type: PageTransitionType.fade,
        );
      case Routes.TRANSACTIONS:
        return PageTransition(
          child: const TransactionPage(),
          type: PageTransitionType.bottomToTop,
        );
      case Routes.TRANSACTIONS_SHOW:
        final filter = settings.arguments as String;
        return PageTransition(
          child: TransactionShowPage(
            filter: filter,
          ),
          type: PageTransitionType.rightToLeft,
        );
      case Routes.ADD_PRODUCT:
        return PageTransition(
          child: const AddProductPage(),
          type: PageTransitionType.rightToLeftWithFade,
        );
      case Routes.ADD_CATEGORY:
        return PageTransition(
          child: const AddCategoryPage(),
          type: PageTransitionType.rightToLeftWithFade,
        );
      case Routes.REPORTS:
        return PageTransition(
          child: const ReportsPage(),
          type: PageTransitionType.fade,
        );
      case Routes.REPORTS_SALES:
        return PageTransition(
          child: const ReportsSalesPage(),
          type: PageTransitionType.fade,
        );
      default:
        return PageTransition(
          child: const DashboardPage(),
          type: PageTransitionType.fade,
        );
    }
  }
}
