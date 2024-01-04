import 'package:flutter/material.dart';
import 'package:garing_bakery_apk/core/routes/app.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            TextButton(
                onPressed: () => Navigator.of(context)
                    .pushReplacementNamed(Routes.DASHBOARD),
                child: const Text("Login"))
          ],
        ),
      ),
    );
  }
}
