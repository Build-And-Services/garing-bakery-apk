// ignore_for_file: constant_identifier_names
import 'package:flutter/material.dart';
import 'package:garing_bakery_apk/features/auth/presenter/pages/auth_page.dart';
import 'package:garing_bakery_apk/features/auth/presenter/pages/splash_page.dart';
import 'package:garing_bakery_apk/features/category/presenter/pages/add_category_page.dart';
import 'package:garing_bakery_apk/features/dashboard/presenter/pages/dashboard_page.dart';
import 'package:garing_bakery_apk/features/product/presenter/pages/add_product_page.dart';
import 'package:garing_bakery_apk/features/product/presenter/pages/detail_product_page.dart';
import 'package:garing_bakery_apk/features/product/presenter/pages/detail_stock_product_page.dart';
import 'package:garing_bakery_apk/features/product/presenter/pages/edit_product_page.dart';
import 'package:garing_bakery_apk/features/reports/presenter/pages/reports_page.dart';
import 'package:garing_bakery_apk/features/reports/presenter/pages/reports_sales_page.dart';
import 'package:garing_bakery_apk/features/reports/presenter/pages/reports_stocks/reports_stocks_page.dart';
import 'package:garing_bakery_apk/features/reports/presenter/pages/reports_transaction/reports_transaction_page.dart';
import 'package:garing_bakery_apk/features/transaction/presenter/pages/next_transaction.dart';
import 'package:garing_bakery_apk/features/transaction/presenter/pages/history/show_transaction_page.dart';
import 'package:garing_bakery_apk/features/transaction/presenter/pages/struk_transaction.dart';
import 'package:garing_bakery_apk/features/transaction/presenter/pages/success_transaction.dart';
import 'package:garing_bakery_apk/features/transaction/presenter/pages/transaction_page.dart';
import 'package:page_transition/page_transition.dart';

class Routes {
  static const String SPLASH = '/splash';
  static const String LOGIN = '/login';
  static const String DASHBOARD = '/dashboard';
  static const String TRANSACTIONS = '/transactions';
  static const String TRANSACTIONS_SHOW = '/transactions_show';
  static const String TRANSACTIONS_NEXT = '/transactions_next';
  static const String TRANSACTIONS_SUCCESS = '/transactions_success';
  static const String TRANSACTIONS_STRUK = '/transactions_struk';

  // product
  static const String ADD_PRODUCT = '/add_product';
  static const String EDIT_PRODUCT = '/edit_product';
  static const String DETAIL_PRODUCT = "/detail_product";
  static const String DETAIL_STOCK_PRODUCT = "/detail_stock_product";

  static const String ADD_CATEGORY = '/add_category';

  // reports
  static const String REPORTS = '/reports';
  static const String REPORTS_SALES = '/reports_sales';
  static const String REPORTS_TRANSACTIONS = '/reports_transactions';
  static const String REPORTS_STOCKS = '/reports_stocks';

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
      case Routes.TRANSACTIONS_NEXT:
        return PageTransition(
          child: const NextTransaction(),
          type: PageTransitionType.rightToLeft,
        );
      case Routes.TRANSACTIONS_SUCCESS:
        return PageTransition(
          child: const SuccessTransaction(),
          type: PageTransitionType.fade,
        );
      case Routes.TRANSACTIONS_SHOW:
        final filter = settings.arguments as String;
        return PageTransition(
          child: TransactionShowPage(
            filter: filter,
          ),
          type: PageTransitionType.rightToLeft,
        );
      case Routes.TRANSACTIONS_STRUK:
        return PageTransition(
          child: const StrukTransactionPage(),
          type: PageTransitionType.bottomToTop,
        );
      case Routes.ADD_PRODUCT:
        return PageTransition(
          child: const AddProductPage(),
          type: PageTransitionType.rightToLeftWithFade,
        );
      case Routes.EDIT_PRODUCT:
        final id = settings.arguments.toString();
        return PageTransition(
          child: EditProductPage(id: id),
          type: PageTransitionType.rightToLeft,
        );
      case Routes.DETAIL_PRODUCT:
        final id = settings.arguments.toString();
        return PageTransition(
          child: DetailProductPage(id: id),
          type: PageTransitionType.rightToLeft,
        );
      case Routes.DETAIL_STOCK_PRODUCT:
        final id = settings.arguments.toString();
        return PageTransition(
          child: DetailStockProductPage(id: id),
          type: PageTransitionType.rightToLeft,
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
      case Routes.REPORTS_TRANSACTIONS:
        return PageTransition(
          child: const ReportsTransactionPage(),
          type: PageTransitionType.fade,
        );
      case Routes.REPORTS_STOCKS:
        return PageTransition(
          child: const ReportsStocksPage(),
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
