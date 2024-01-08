import 'dart:async';

import 'package:flutter/material.dart';
import 'package:garing_bakery_apk/core/config/theme.dart';
import 'package:garing_bakery_apk/features/auth/presenter/pages/auth_page.dart';
import 'package:page_transition/page_transition.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with TickerProviderStateMixin {
  late Timer _timer;
  int duration = 2;
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

  removeScreen() {
    return _timer = Timer(
      Duration(seconds: duration + 1),
      () {
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
