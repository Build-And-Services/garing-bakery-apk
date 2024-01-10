import 'package:flutter/material.dart';
import 'package:garing_bakery_apk/core/config/theme.dart';
import 'package:garing_bakery_apk/core/widgets/drawer_widget.dart';

class CartSubPage extends StatelessWidget {
  const CartSubPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerPage(),
      appBar: AppBar(
        title: const Text(
          'Riwayat Transaksi',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: MyTheme.primary,
      ),
      body: Container(
        margin: const EdgeInsets.only(
          top: 20,
        ),
        padding: const EdgeInsets.all(10.0),
        child: const Column(
          children: [
            HistoryTransactionFilter(),
            HistoryTransactionFilter(),
            HistoryTransactionFilter(),
          ],
        ),
      ),
    );
  }
}

class HistoryTransactionFilter extends StatelessWidget {
  const HistoryTransactionFilter({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        bottom: 10,
      ),
      decoration: BoxDecoration(
        border: Border.all(
          color: const Color.fromARGB(103, 116, 116, 116),
          width: 1,
          style: BorderStyle.solid,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        trailing: GestureDetector(
          child: const Icon(
            Icons.remove_red_eye,
            color: Colors.green,
          ),
        ),
        focusColor: Colors.amberAccent,
        leading: const Icon(
          Icons.date_range,
          color: MyTheme.primary,
        ),
        title: const Text("Riwayat transaksi untuk hari ini"),
      ),
    );
  }
}
