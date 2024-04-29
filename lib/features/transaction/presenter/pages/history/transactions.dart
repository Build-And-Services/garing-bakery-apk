import 'package:flutter/material.dart';
import 'package:garing_bakery_apk/core/config/theme.dart';
import 'package:garing_bakery_apk/core/widgets/drawer_widget.dart';
import 'package:garing_bakery_apk/features/transaction/presenter/widgets/history/history_transaction_filter_widget.dart';

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
