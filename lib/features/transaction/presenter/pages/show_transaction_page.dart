import 'package:flutter/material.dart';
import 'package:garing_bakery_apk/core/config/theme.dart';
import 'package:garing_bakery_apk/core/helpers/format_rupiah.dart';
import 'package:garing_bakery_apk/features/transaction/data/model/response_transaction.dart';
import 'package:garing_bakery_apk/features/transaction/presenter/provider/transaction_provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class TransactionShowPage extends StatefulWidget {
  const TransactionShowPage({super.key});

  @override
  State<TransactionShowPage> createState() => _TransactionShowPageState();
}

class _TransactionShowPageState extends State<TransactionShowPage> {
  var transactionProvider = TransactionProvider();
  @override
  void initState() {
    transactionProvider =
        Provider.of<TransactionProvider>(context, listen: false);
    transactionProvider.getTransaction();
    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final transactionProvider = context.watch<TransactionProvider>();
    // if (transactionProvider.isLoading) {
    //   transactionProvider.getTransaction();
    //   return const Scaffold(body: Center(child: CircularProgressIndicator()));
    // }
    return Scaffold(
      appBar: MyTheme.appBar("Riwayat Hari ini", []),
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
                itemCount: transactionProvider.transactions.length,
                itemBuilder: (context, index) {
                  RespTransactionModel transaction =
                      transactionProvider.transactions[index];
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
                      "Jumlah Barang: ${transaction.orderItems.length}",
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
