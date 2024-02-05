import 'package:flutter/material.dart';
import 'package:garing_bakery_apk/core/config/theme.dart';
import 'package:garing_bakery_apk/core/helpers/format_rupiah.dart';
import 'package:garing_bakery_apk/features/transaction/data/model/response_transaction.dart';
import 'package:garing_bakery_apk/features/transaction/presenter/provider/transaction_provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class TransactionShowPage extends StatefulWidget {
  final String filter;
  const TransactionShowPage({super.key, required this.filter});

  @override
  State<TransactionShowPage> createState() => _TransactionShowPageState();
}

class _TransactionShowPageState extends State<TransactionShowPage> {
  var transactionProvider = TransactionProvider();

  @override
  Widget build(BuildContext context) {
    final transactionProvider = context.read<TransactionProvider>();
    transactionProvider.getTransaction(widget.filter);
    return Scaffold(
      appBar: widget.filter == 'all'
          ? MyTheme.appBar("Riwayat Semua Transaksi", [])
          : widget.filter == "month"
              ? MyTheme.appBar("Riwayat Transaksi Bulan ini", [])
              : widget.filter == "year"
                  ? MyTheme.appBar("Riwayat Transaksi Tahun ini", [])
                  : MyTheme.appBar("Riwayat Transaksi Hari ini", []),
      body: RefreshIndicator(
        onRefresh: () async {
          transactionProvider.setLoading = true;
        },
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: widget.filter == 'all'
                    ? transactionProvider.transactions.length
                    : widget.filter == "month"
                        ? transactionProvider.transactionsMonth.length
                        : widget.filter == "year"
                            ? transactionProvider.transactionsYear.length
                            : transactionProvider.transactionsDay.length,
                itemBuilder: (context, index) {
                  RespTransactionModel transaction = widget.filter == 'all'
                      ? transactionProvider.transactions[index]
                      : widget.filter == "month"
                          ? transactionProvider.transactionsMonth[index]
                          : widget.filter == "year"
                              ? transactionProvider.transactionsYear[index]
                              : transactionProvider.transactionsDay[index];
                  return ListTile(
                    leading: const Icon(Icons.person),
                    title: Text(
                      transaction.userId,
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    subtitle: Text(
                      "Jumlah Barang: ${transaction.productLength}",
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    trailing: Text(
                      formatRupiah(transaction.totalPembelian),
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
