import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:garing_bakery_apk/core/config/theme.dart';
import 'package:garing_bakery_apk/core/helpers/format_rupiah.dart';
import 'package:garing_bakery_apk/core/models/arguments/ArgumentStruck.dart';
import 'package:garing_bakery_apk/core/widgets/loading_widget.dart';
import 'package:garing_bakery_apk/core/widgets/no_data_widget.dart';
import 'package:garing_bakery_apk/core/widgets/problem_get_widget.dart';
import 'package:garing_bakery_apk/features/transaction/data/model/reponse_add.dart';
import 'package:garing_bakery_apk/features/transaction/data/service/transaction_service.dart';
import 'package:garing_bakery_apk/features/transaction/presenter/provider/print_provider.dart';
import 'package:garing_bakery_apk/features/transaction/presenter/widgets/button_print.dart';
import 'package:garing_bakery_apk/features/transaction/presenter/widgets/dropdown_print.dart';
import 'package:garing_bakery_apk/features/transaction/presenter/widgets/item_detail_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class StrukTransactionPage extends StatefulWidget {
  const StrukTransactionPage({super.key, required this.data});
  final ArgumentStruct data;

  @override
  State<StrukTransactionPage> createState() => _StrukTransactionPageState();
}

class _StrukTransactionPageState extends State<StrukTransactionPage> {
  PrintProvider? printProvider;

  @override
  Widget build(BuildContext context) {
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
      ),
      body: futureBuilder(widget.data.id!),
    );
  }

  Widget headerDetailInvoice(String title, {TextAlign? align}) {
    return Container(
      // color: Colors.grey,
      child: Text(
        title,
        style: GoogleFonts.poppins(
          color: Colors.black,
          fontSize: 12.sp,
          fontWeight: FontWeight.bold,
        ),
        textAlign: align,
      ),
    );
  }

  Widget footerDetailInvoice(String title, String value) {
    return Container(
      // color: Colors.grey,
      child: Row(
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
      ),
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
        return Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: const Color.fromARGB(255, 237, 237, 237),
          child: Column(
            children: [
              Expanded(
                child: Container(
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
                  child: ListView(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Gading Bakery",
                            style: GoogleFonts.poppins(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Address: Jln. Pattimura, Kab. Gresik, Prov. Jawa Timur',
                            style: GoogleFonts.poppins(
                              color: Colors.grey,
                              fontSize: 8.sp,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            'No Telp: 083853797950',
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
                                  'No. Faktur: 786324-23423-33434',
                                  style: GoogleFonts.poppins(
                                    color: Colors.grey,
                                    fontSize: 10.sp,
                                  ),
                                ),
                                Text(
                                  'Tanggal : ${DateFormat('EEEE, d MMMM yyyy', 'id_ID').format(data.createdAt)}',
                                  style: GoogleFonts.poppins(
                                    color: Colors.grey,
                                    fontSize: 10.sp,
                                  ),
                                ),
                                Text(
                                  'Alamat : Jln. Pattimura',
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
                              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 100,
              ),
              const DropdownPrint(),
              const ButtonPrint()
            ],
          ),
        );
      },
    );
  }
}
