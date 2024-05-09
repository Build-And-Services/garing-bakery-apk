import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:garing_bakery_apk/core/config/theme.dart';
import 'package:garing_bakery_apk/core/helpers/format_rupiah.dart';
import 'package:garing_bakery_apk/core/models/arguments/argument_struck.dart';
import 'package:garing_bakery_apk/core/widgets/loading_widget.dart';
import 'package:garing_bakery_apk/core/widgets/no_data_widget.dart';
import 'package:garing_bakery_apk/core/widgets/problem_get_widget.dart';
import 'package:garing_bakery_apk/features/printer/data/service/struck_service.dart';
import 'package:garing_bakery_apk/features/transaction/data/model/reponse_add.dart';
import 'package:garing_bakery_apk/features/transaction/data/service/transaction_service.dart';
import 'package:garing_bakery_apk/features/transaction/presenter/provider/print_provider.dart';
import 'package:garing_bakery_apk/features/transaction/presenter/widgets/item_detail_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class StrukTransactionPage extends StatefulWidget {
  const StrukTransactionPage({super.key, required this.data});
  final ArgumentStruct data;

  @override
  State<StrukTransactionPage> createState() => _StrukTransactionPageState();
}

class _StrukTransactionPageState extends State<StrukTransactionPage> {
  PrintProvider? printProvider;
  late Map<String, dynamic> struck;
  late TransactionAddResponse dataPrint;

  Future getDataStruck() async {
    final dataStruck = await SettingStruckService.getData();
    final data = await TransactionService.detailTransaction(widget.data.id!);
    setState(() {
      struck = dataStruck;
      dataPrint = data;
    });
  }

  @override
  void initState() {
    getDataStruck();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    printProvider = context.watch<PrintProvider>();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Struk',
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        leading: InkWell(
          onTap: () => Navigator.pop(context),
          child: const Icon(
            Icons.arrow_back_ios,
          ),
        ),
        backgroundColor: MyTheme.primary,
        actions: [
          InkWell(
            onTap: () {
              if (printProvider != null) {
                printProvider?.print(dataPrint);
              }
            },
            child: const Icon(
              Icons.print,
            ),
          ),
          const SizedBox(
            width: 20,
          ),
        ],
      ),
      body: futureBuilder(widget.data.id!),
    );
  }

  Widget headerDetailInvoice(String title, {TextAlign? align}) {
    return Text(
      title,
      style: GoogleFonts.poppins(
        color: Colors.black,
        fontSize: 12.sp,
        fontWeight: FontWeight.bold,
      ),
      textAlign: align,
    );
  }

  Widget footerDetailInvoice(String title, String value) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: GoogleFonts.poppins(
              color: Colors.black,
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.start,
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: GoogleFonts.poppins(
              color: Colors.black,
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.end,
          ),
        ),
      ],
    );
  }

  Widget futureBuilder(int id) {
    return FutureBuilder<TransactionAddResponse>(
      future: TransactionService.detailTransaction(id),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const LoadingWidget();
        }
        if (snapshot.hasError) {
          return const ProblemWidget();
        }
        if (!snapshot.hasData) {
          return const NoDataWidget();
        }

        TransactionAddResponse data = snapshot.data!;
        return SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: const Color.fromARGB(255, 237, 237, 237),
            child: Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 50,
                  ),
                  margin: const EdgeInsets.all(20),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        struck["company"] ?? "Gading Bakery",
                        style: GoogleFonts.poppins(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        struck["alamat"] ?? " ",
                        style: GoogleFonts.poppins(
                          color: Colors.grey,
                          fontSize: 8.sp,
                        ),
                      ),
                      Text(
                        struck["notelp"] != null
                            ? "No Hp: ${struck["notelp"]}"
                            : "No Hp: ",
                        style: GoogleFonts.poppins(
                          color: Colors.grey,
                          fontSize: 8.sp,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Divider(
                        color: Colors.grey,
                        thickness: 1,
                        indent: 20,
                        endIndent: 20,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Tanggal : ${DateFormat('EEEE, d MMMM yyyy, HH:mm:ss', 'id_ID').format(data.createdAt)}',
                              style: GoogleFonts.poppins(
                                color: Colors.grey,
                                fontSize: 10.sp,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Divider(
                        color: Colors.grey,
                        thickness: 1,
                        indent: 20,
                        endIndent: 20,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              flex: 3,
                              child: headerDetailInvoice('Produk'),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              flex: 2,
                              child: headerDetailInvoice('Harga'),
                            ),
                            Expanded(
                              flex: 1,
                              child: headerDetailInvoice('QTY'),
                            ),
                            Expanded(
                              flex: 2,
                              child: headerDetailInvoice('Total',
                                  align: TextAlign.end),
                            ),
                          ],
                        ),
                      ),
                      const Divider(
                        color: Colors.grey,
                        thickness: 1,
                        indent: 20,
                        endIndent: 20,
                      ),
                      ItemDetailWidget(detail: data.details),
                      const Divider(
                        color: Colors.grey,
                        thickness: 1,
                        indent: 20,
                        endIndent: 20,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          children: [
                            footerDetailInvoice(
                                'Total', formatRupiah(data.totalPrice)),
                            footerDetailInvoice(
                                'Uang', formatRupiah(data.nominal)),
                            footerDetailInvoice(
                                'Kembalian', formatRupiah(data.change)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
