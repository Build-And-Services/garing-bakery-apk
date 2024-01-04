import 'package:flutter/material.dart';
import 'package:garing_bakery_apk/core/config/theme.dart';
import 'package:garing_bakery_apk/core/routes/app.dart';

class TransactionPage extends StatelessWidget {
  const TransactionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: MyTheme.primary,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Kasir',
          style: TextStyle(color: MyTheme.primary, fontWeight: FontWeight.w700),
        ),
      ),
      body: const Center(
        child: Column(
          children: [
            Expanded(child: Text("data")),
            ButtonCheckout(),
          ],
        ),
      ),
    );
  }
}

class ButtonCheckout extends StatelessWidget {
  const ButtonCheckout({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 20,
        horizontal: 40,
      ),
      width: MediaQuery.of(context).size.width - 20,
      height: 90,
      child: InkWell(
        onTap: () {
          debugPrint("hallo");
        },
        child: Container(
          decoration: const BoxDecoration(
            color: MyTheme.primary,
            borderRadius: BorderRadius.all(
              Radius.circular(100),
            ),
          ),
          child: const Center(
            child: Text(
              "Silahkan pilih roti",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontSize: 18,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
