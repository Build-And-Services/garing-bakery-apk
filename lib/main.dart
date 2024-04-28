import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:garing_bakery_apk/core/config/theme.dart';
import 'package:garing_bakery_apk/core/routes/app.dart';
import 'package:garing_bakery_apk/features/auth/presenter/provider/auth_provider.dart';
import 'package:garing_bakery_apk/features/category/presenter/provider/category_provider.dart';
import 'package:garing_bakery_apk/features/category/presenter/provider/form_category_provider.dart';
import 'package:garing_bakery_apk/features/dashboard/presenter/provider/dashboard_provider.dart';
import 'package:garing_bakery_apk/features/printer/presenter/provider/setting_struck_provider.dart';
import 'package:garing_bakery_apk/features/product/presenter/provider/form_edit_stok_provider.dart';
import 'package:garing_bakery_apk/features/product/presenter/provider/form_provider.dart';
import 'package:garing_bakery_apk/features/product/presenter/provider/product_provider.dart';
import 'package:garing_bakery_apk/features/reports/presenter/provider/reports_sales_provider.dart';
import 'package:garing_bakery_apk/features/transaction/presenter/provider/cart_provider.dart';
import 'package:garing_bakery_apk/features/transaction/presenter/provider/print_provider.dart';
import 'package:garing_bakery_apk/features/transaction/presenter/provider/transaction_provider.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  selectInitialRoute();
}

void selectInitialRoute() async {
  await initializeDateFormatting('id_ID', null);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AuthProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => DashboardProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => ProductProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => TransactionProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => CategoryProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => FormProductProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => FormCategoryProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => CartProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => FormStokProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => ReportsSalesProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => PrintProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => SettingStruckProvider(),
        )
      ],
      child: ScreenUtilInit(
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (_, child) {
            return MaterialApp(
              theme: ThemeData(
                appBarTheme: const AppBarTheme(
                  backgroundColor: MyTheme.primary,
                  iconTheme: IconThemeData(
                    color: Colors.white,
                  ),
                ),
              ),
              debugShowCheckedModeBanner: false,
              initialRoute: Routes.SPLASH,
              onGenerateRoute: (settings) => Routes.generateRoute(
                settings,
              ),
            );
          }),
    ),
  );
}
