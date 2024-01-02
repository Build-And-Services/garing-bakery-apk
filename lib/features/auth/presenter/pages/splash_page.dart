import 'package:flutter/material.dart';
import 'package:garing_bakery_apk/core/routes/app.dart';
import 'package:garing_bakery_apk/features/auth/presenter/pages/auth_page.dart';
import 'package:garing_bakery_apk/features/auth/presenter/provider/auth_provider.dart';
import 'package:garing_bakery_apk/main.dart';
import 'package:provider/provider.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
    );
  }
}
