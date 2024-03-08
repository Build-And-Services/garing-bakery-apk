import 'package:flutter/material.dart';
import 'package:garing_bakery_apk/core/config/theme.dart';
import 'package:garing_bakery_apk/core/routes/app.dart';
import 'package:garing_bakery_apk/core/widgets/drawer_widget.dart';

class CartSubPage extends StatelessWidget {
  const CartSubPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerPage(),
      appBar: MyTheme.appBar("Riwayat Transaksi", []),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(
            top: 20,
          ),
          padding: const EdgeInsets.all(10.0),
          child: const Column(
            children: [
              HistoryTransactionFilter(
                title: 'Riwayat Transaksi hari ini',
                filter: 'day',
              ),
              HistoryTransactionFilter(
                title: 'Riwayat Transaksi bulan ini',
                filter: 'month',
              ),
              HistoryTransactionFilter(
                title: 'Riwayat Transaksi tahun ini',
                filter: 'year',
              ),
              HistoryTransactionFilter(
                title: 'Riwayat Transaksi semua',
                filter: 'all',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HistoryTransactionFilter extends StatelessWidget {
  final String title;
  final String filter;
  const HistoryTransactionFilter({
    Key? key,
    required this.title,
    required this.filter,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.of(context).pushNamed(
        Routes.TRANSACTIONS_SHOW,
        arguments: filter,
      ),
      child: Container(
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
          title: Text(title),
        ),
      ),
    );
  }
}
