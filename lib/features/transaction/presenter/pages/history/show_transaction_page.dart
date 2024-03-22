import 'package:flutter/material.dart';
import 'package:garing_bakery_apk/core/config/theme.dart';
import 'package:garing_bakery_apk/core/helpers/format_rupiah.dart';
import 'package:garing_bakery_apk/core/models/arguments/ArgumentStruck.dart';
import 'package:garing_bakery_apk/core/routes/app.dart';
import 'package:garing_bakery_apk/core/widgets/no_data_widget.dart';
import 'package:garing_bakery_apk/features/transaction/data/model/response_transaction.dart';
import 'package:garing_bakery_apk/features/transaction/presenter/provider/transaction_provider.dart';
import 'package:google_fonts/google_fonts.dart';

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
    // final transactionProvider = context.watch<TransactionProvider>();
    // transactionProvider.getTransaction(widget.filter);
    return Scaffold(
      appBar: widget.filter == 'all'
          ? MyTheme.appBar("Riwayat Semua Transaksi", [])
          : widget.filter == "month"
              ? MyTheme.appBar("Riwayat Transaksi Bulan ini", [])
              : widget.filter == "year"
                  ? MyTheme.appBar("Riwayat Transaksi Tahun ini", [])
                  : MyTheme.appBar("Riwayat Transaksi Hari ini", []),
      body: RefreshIndicator(
        onRefresh: () async {},
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: FutureBuilder<List<RespTransactionModel>>(
                  future: transactionProvider.getTransaction(widget.filter),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const NoDataWidget();
                    }
                    return ListView.builder(
                      itemCount: snapshot.data?.length,
                      itemBuilder: (context, index) {
                        RespTransactionModel transaction =
                            snapshot.data![index];
                        return ListTile(
                          onTap: () => Navigator.of(context).pushNamed(
                            Routes.TRANSACTIONS_STRUK,
                            arguments: ArgumentStruct(
                              transaction.id,
                              null,
                            ),
                          ),
                          leading: const Icon(
                            Icons.person,
                          ),
                          title: Text(
                            transaction.userId,
                            style: GoogleFonts.poppins(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          subtitle: Text(
                            "Jumlah: ${transaction.productLength}",
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          trailing: Column(
                            children: [
                              Text(
                                formatRupiah(transaction.totalPembelian),
                                style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                transaction.createdAt,
                              )
                            ],
                          ),
                        );
                      },
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
