import 'package:flutter/material.dart';
import 'package:garing_bakery_apk/core/config/theme.dart';
import 'package:garing_bakery_apk/core/routes/app.dart';
import 'package:garing_bakery_apk/features/auth/presenter/provider/auth_provider.dart';
import 'package:garing_bakery_apk/features/dashboard/presenter/provider/dashboard_provider.dart';
import 'package:garing_bakery_apk/features/dashboard/presenter/provider/product_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => DashboardProvider()),
        ChangeNotifierProvider(create: (_) => ProductProvider())
      ],
      child: MaterialApp(
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
        onGenerateRoute: (settings) => Routes.generateRoute(settings),
      ),
    ),
  );
}
