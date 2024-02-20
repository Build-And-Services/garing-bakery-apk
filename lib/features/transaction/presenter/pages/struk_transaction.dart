import 'package:flutter/material.dart';

class StrukTransactionPage extends StatelessWidget {
  const StrukTransactionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () => Navigator.pop(context),
          child: const Icon(
            Icons.arrow_back_ios,
          ),
        ),
        backgroundColor: Colors.green,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        color: Colors.green,
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              // height: 200,
              padding: const EdgeInsets.all(20),
              margin: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Gading Bakery"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
