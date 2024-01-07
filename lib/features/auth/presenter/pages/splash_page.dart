import 'dart:async';

import 'package:flutter/material.dart';
import 'package:garing_bakery_apk/core/config/theme.dart';
import 'package:garing_bakery_apk/core/routes/app.dart';
import 'package:garing_bakery_apk/features/auth/presenter/provider/auth_provider.dart';
import 'package:garing_bakery_apk/main.dart';
import 'package:provider/provider.dart';

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

  // @override
  // void initState() {
  //   if (mounted) {
  //     Future.delayed(const Duration(seconds: 3)).then((value) {
  //       bool isLogin =
  //           Provider.of<AuthProvider>(context, listen: false).isLogin;
  //       if (isLogin) {
  //         Navigator.of(context).pushReplacementNamed(Routes.DASHBOARD);
  //       } else {
  //         Navigator.of(context).pushReplacementNamed(Routes.LOGIN);
  //       }
  //     });
  //   }
  //   super.initState();
  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
        backgroundColor: MyTheme.primary,
        body: Center(
<<<<<<< HEAD
          child: Image(
            width: 350,
            image: AssetImage("assets/images/logogading.png"),
=======
          child: Column(
            children: [
              const Text('splash page'),
              InkWell(
                onTap: () async {
                  Navigator.of(context, rootNavigator: true)
                      .pushNamed(Routes.LOGIN);
                },
                child: const Column(
                  children: [
                    Text("pindah"),
                  ],
                ),
              )
            ],
>>>>>>> a5b0dbd (feat: dashboard layout)
          ),
        ),
      ),
    );
  }
}
