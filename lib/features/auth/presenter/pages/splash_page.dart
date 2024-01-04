import 'package:flutter/material.dart';
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
  @override
  void initState() {
    if (mounted) {
      Future.delayed(const Duration(seconds: 1)).then((value) {
        bool isLogin =
            Provider.of<AuthProvider>(context, listen: false).isLogin;
        if (isLogin) {
          Navigator.of(context).pushReplacementNamed(Routes.DASHBOARD);
        } else {
          Navigator.of(context).pushReplacementNamed(Routes.LOGIN);
        }
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            children: [
              const Text('splash page'),
              InkWell(
                onTap: () async {
                  Navigator.of(context, rootNavigator: true)
                      .pushNamed(Routes.LOGIN);
                },
                child: Column(
                  children: [
                    const Text("pindah"),
                    Text(
                      '${context.watch<Counter>().count}',
                      key: const Key('counterState'),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
