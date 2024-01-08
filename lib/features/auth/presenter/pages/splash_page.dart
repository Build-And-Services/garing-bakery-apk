import 'dart:async';

import 'package:flutter/material.dart';
import 'package:garing_bakery_apk/core/config/theme.dart';
import 'package:garing_bakery_apk/core/routes/app.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  late Timer _timer;
  removeScreen() {
    return _timer = Timer(const Duration(seconds: 2), () {
      Navigator.of(context).pushReplacementNamed(Routes.LOGIN);
    });
  }

  @override
  void initState() {
    super.initState();
    removeScreen();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
        backgroundColor: MyTheme.primary,
        body: Center(
          child: Image(
            width: 350,
            image: AssetImage("assets/images/logogading.png"),
          ),
        ),
      ),
    );
  }
}
