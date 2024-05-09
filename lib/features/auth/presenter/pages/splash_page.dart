import 'dart:async';

import 'package:blue_thermal_printer/blue_thermal_printer.dart';
import 'package:flutter/material.dart';
import 'package:garing_bakery_apk/core/config/theme.dart';
import 'package:garing_bakery_apk/core/models/user_model.dart';
import 'package:garing_bakery_apk/features/auth/data/service/token_service.dart';
import 'package:garing_bakery_apk/features/auth/presenter/pages/auth_page.dart';
import 'package:garing_bakery_apk/features/auth/presenter/provider/auth_provider.dart';
import 'package:garing_bakery_apk/features/dashboard/presenter/pages/dashboard_page.dart';
import 'package:garing_bakery_apk/features/printer/data/service/struck_service.dart';
import 'package:garing_bakery_apk/features/transaction/presenter/provider/print_provider.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with TickerProviderStateMixin {
  late Timer _timer;
  int duration = 1;
  late final AnimationController _animate = AnimationController(
    duration: Duration(seconds: duration),
    vsync: this,
  )..repeat(
      reverse: true,
    );

  late final Animation<double> _animation = CurvedAnimation(
    parent: _animate,
    curve: Curves.fastOutSlowIn,
  );

  Future removeScreen() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    // ignore: use_build_context_synchronously
    final printProvider = context.read<PrintProvider>();

    final company = prefs.getString("company");
    final alamat = prefs.getString("alamat");
    final notelp = prefs.getString("notelp");
    final footer = prefs.getString("footer");
    if (company == null || alamat == null || notelp == null || footer == null) {
      await SettingStruckService.saveData("PT. kosong", "Candradimuka No. 10",
          "08xxxx", "Terima Kasih sudah belanja");
    }
    UserModel? userModel;
    if (prefs.getString("token") != null) {
      userModel = await TokenService.getCacheUser();
    }

    // check device
    final printName = prefs.getString("print_name");
    final printAddress = prefs.getString("print_address");
    if (printName != null || printAddress != null) {
      List<BluetoothDevice> devices = await printProvider.getDevices();
      for (var i = 0; i < devices.length; i++) {
        if (printName == devices[i].name! &&
            printAddress == devices[i].address!) {
          printProvider.connect(device: devices[i]);
        }
      }
    }
    return _timer = Timer(
      Duration(seconds: duration + 1),
      () {
        if (prefs.getString("token") != null) {
          AuthProvider authProvider = context.read<AuthProvider>();
          if (userModel != null) {
            authProvider.setUserCache = userModel;
          }
          Navigator.of(context).pushAndRemoveUntil(
            PageTransition(
              child: DashboardPage(),
              type: PageTransitionType.fade,
              duration: const Duration(
                milliseconds: 900,
              ),
            ),
            (route) => false,
          );
        } else {
          Navigator.of(context).pushAndRemoveUntil(
            PageTransition(
              child: const AuthLogin(),
              type: PageTransitionType.fade,
              duration: const Duration(
                milliseconds: 900,
              ),
            ),
            (route) => false,
          );
        }
      },
    );
  }

  @override
  void initState() {
    super.initState();
    removeScreen();
  }

  @override
  void dispose() {
    _animate.dispose();
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: MyTheme.white,
        body: Center(
          child: ScaleTransition(
            scale: _animation,
            child: const Image(
              width: 350,
              image: AssetImage("assets/images/logogading.png"),
            ),
          ),
        ),
      ),
    );
  }
}
