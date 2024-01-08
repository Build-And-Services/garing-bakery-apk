import 'package:flutter/material.dart';
import 'package:garing_bakery_apk/core/config/theme.dart';
import 'package:garing_bakery_apk/features/auth/presenter/provider/auth_provider.dart';
import 'package:garing_bakery_apk/features/auth/presenter/widgets/input_login_widget.dart';
import 'package:provider/provider.dart';

class AuthLogin extends StatefulWidget {
  const AuthLogin({super.key});

  @override
  State<AuthLogin> createState() => _AuthPage();
}

class _AuthPage extends State<AuthLogin> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Consumer<AuthProvider>(
            builder: (context, authProvider, _) {
              return SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 50,
                      ),
                      Image.asset(
                        "assets/images/logogading.png",
                        height: 250,
                        width: double.infinity,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      InputAuthWidget(
                        label: "Email",
                        placeholder: "Masukan email",
                        validation: authProvider.validationEmail,
                        controller: authProvider.email,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      InputAuthWidget(
                        label: "password",
                        placeholder: "Masukan Password",
                        obscure: true,
                        validation: authProvider.validationPassword,
                        controller: authProvider.password,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      MaterialButton(
                        color: MyTheme.secondary,
                        height: 20,
                        minWidth: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          side: const BorderSide(
                            color: MyTheme.secondary,
                          ),
                        ),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            try {
                              authProvider.startLoading();
                              authProvider.login().then((value) {
                                authProvider.stopLoading();
                                if (authProvider.message != null) {
                                  dialogMessage(context, authProvider);
                                }
                              });
                            } catch (e) {
                              authProvider.stopLoading();
                            }
                          }
                        },
                        child: authProvider.isloading
                            ? const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CircularProgressIndicator(
                                    color: Colors.white,
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Text(
                                    "Tunggu sebentar",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                    ),
                                  )
                                ],
                              )
                            : const Text(
                                "Login",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                ),
                              ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Gading Bakery",
                            style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  dialogMessage(BuildContext context, AuthProvider authProvider) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Alert Message'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(authProvider.message as String),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Ok'),
              onPressed: () {
                authProvider.clear();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
