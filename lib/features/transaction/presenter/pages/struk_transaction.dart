import 'package:bluetooth_print/bluetooth_print_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:garing_bakery_apk/core/config/theme.dart';
import 'package:garing_bakery_apk/core/helpers/format_rupiah.dart';
import 'package:garing_bakery_apk/core/models/arguments/ArgumentStruck.dart';
import 'package:garing_bakery_apk/core/widgets/loading_widget.dart';
import 'package:garing_bakery_apk/core/widgets/no_data_widget.dart';
import 'package:garing_bakery_apk/core/widgets/problem_get_widget.dart';
import 'package:garing_bakery_apk/features/printer/data/service/struck_service.dart';
import 'package:garing_bakery_apk/features/transaction/data/model/reponse_add.dart';
import 'package:garing_bakery_apk/features/transaction/data/service/transaction_service.dart';
import 'package:garing_bakery_apk/features/transaction/presenter/provider/print_provider.dart';
import 'package:garing_bakery_apk/features/transaction/presenter/widgets/button_print.dart';
import 'package:garing_bakery_apk/features/transaction/presenter/widgets/dropdown_print.dart';
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

  Future getDataStruck() async {
    final dataStruck = await SettingStruckService.getData();
    setState(() {
      struck = dataStruck;
    });
  }

  @override
  void initState() {
    getDataStruck();
    super.initState();
  }

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
                            struck != null
                                ? struck["company"]
                                : "Gading Bakery",
                            style: GoogleFonts.poppins(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            struck != null ? struck["alamat"] : " ",
                            style: GoogleFonts.poppins(
                              color: Colors.grey,
                              fontSize: 8.sp,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            struck != null
                                ? "No Hp: " + struck["notelp"]
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
                                  'Tanggal : ${DateFormat('EEEE, d MMMM yyyy', 'id_ID').format(data.createdAt)}',
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
              ButtonPrint(detail: data.details)
            ],
          ),
        );
      },
    );
  }

  Widget withoutArgumentWidget(
      BuildContext context, TransactionAddResponse data) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: Colors.green,
      child: SingleChildScrollView(
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
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
                        footerDetailInvoice('Uang', formatRupiah(data.nominal)),
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
  }
}

class ButtonPrint extends StatelessWidget {
  const ButtonPrint({
    super.key,
    required this.detail,
  });

  final List<DetailTransactionsResponse> detail;

  @override
  Widget build(BuildContext context) {
    final printProvider = context.watch<PrintProvider>();

    return InkWell(
      onTap: () async {
        if (!printProvider.connected) {
          debugPrint("belum connect");
          if (printProvider.device != null) {
            debugPrint("mencoba connect");
            printProvider.connect(printProvider.device!);
          }
        } else {
          debugPrint("connected");
          debugPrint(printProvider.device!.name);
          Map<String, dynamic> config = {};
          List<LineText> list = [];
          list.add(LineText(linefeed: 1));

          list.add(
            LineText(
              type: LineText.TYPE_TEXT,
              content: "Gading Bakery",
              weight: 2,
              width: 2,
              height: 2,
              align: LineText.ALIGN_CENTER,
              linefeed: 1,
            ),
          );
          list.add(LineText(linefeed: 1));

          list.add(
            LineText(
              type: LineText.TYPE_TEXT,
              content: "Address: jln. Pattimura, Kab. Gresik, Prov. Jawa Timur",
              align: LineText.ALIGN_CENTER,
              linefeed: 1,
            ),
          );
          list.add(LineText(linefeed: 1));
          list.add(
            LineText(
              type: LineText.TYPE_TEXT,
              content: "No. telp: 083853797950",
              weight: 0,
              align: LineText.ALIGN_CENTER,
              linefeed: 1,
            ),
          );
          list.add(LineText(linefeed: 1));

          list.add(LineText(linefeed: 1));

          for (var i = 0; i < detail.length; i++) {
            list.add(
              LineText(
                type: LineText.TYPE_TEXT,
                content: detail[i].productsName,
                weight: 0,
                align: LineText.ALIGN_LEFT,
                linefeed: 1,
              ),
            );

            list.add(
              LineText(
                type: LineText.TYPE_TEXT,
                content: "${detail[i].sellingPrice} x ${detail[i].quantity}",
                align: LineText.ALIGN_LEFT,
                linefeed: 0,
                x: 0,
              ),
            );
            final total =
                formatRupiah(detail[i].sellingPrice * detail[i].quantity);
            debugPrint(total.length.toString());
            list.add(
              LineText(
                type: LineText.TYPE_TEXT,
                content: total,
                align: LineText.ALIGN_RIGHT,
                linefeed: 0,
                x: 200 - total.length,
              ),
            );
            list.add(LineText(linefeed: 1));
          }
          list.add(LineText(linefeed: 1));
          list.add(
            LineText(
              type: LineText.TYPE_TEXT,
              content: "Terima Kasih sudah berbelanja.",
              align: LineText.ALIGN_CENTER,
              linefeed: 1,
            ),
          );
          list.add(LineText(linefeed: 1));
          list.add(LineText(linefeed: 1));

          debugPrint(list.toString());

          await printProvider.bluetoothPrint.printReceipt(config, list);
        }
        // Navigator.push(
        //     context, MaterialPageRoute(builder: (_) => const PrintPage()));
      },
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 15,
          horizontal: 12,
        ),
        width: MediaQuery.of(context).size.width,
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        decoration: const BoxDecoration(
          color: MyTheme.brown,
          borderRadius: BorderRadius.all(
            Radius.circular(16),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.print,
              color: Colors.white,
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              printProvider.tips,
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DropdownPrint extends StatelessWidget {
  const DropdownPrint({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final printProvider = context.watch<PrintProvider>();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => printProvider.initBluetooth());

    return StreamBuilder<List<BluetoothDevice>>(
        stream: printProvider.bluetoothPrint.scanResults,
        initialData: const [],
        builder: (context, snapshot) {
          return Container(
            margin: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 10,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: MyTheme.primary),
            ),
            width: MediaQuery.of(context).size.width,
            child: DropdownButtonHideUnderline(
              child: ButtonTheme(
                  alignedDropdown: true,
                  child: DropdownButton(
                    borderRadius: BorderRadius.circular(8),
                    value: printProvider.device?.address == null
                        ? null
                        : !snapshot.data!.any((e) =>
                                e.address == printProvider.device!.address)
                            ? null
                            : printProvider.device?.address,
                    items: snapshot.data!
                        .map((e) => DropdownMenuItem(
                              value: e.address,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(e.name ?? 'No name device'),
                                  Text(e.address ?? 'No address device'),
                                ],
                              ),
                              onTap: () {
                                printProvider.setDevice = e;
                                // if (printProvider.device != null) {
                                //   printProvider.bluetoothPrint.connect(e);
                                // }
                              },
                            ))
                        .toList(),
                    onChanged: (value) {},
                  )),
            ),
          );
        });
  }
}

class ItemDetailWidget extends StatelessWidget {
  const ItemDetailWidget({
    super.key,
    required this.detail,
  });
  final List<DetailTransactionsResponse> detail;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Column(
            children: detail
                .map((product) => InvoiceItemWidget(product: product))
                .toList(),
            // children: [
            //   InvoiceItemWidget(),
            //   InvoiceItemWidget(),
            //   InvoiceItemWidget()
            // ],
          ),
        ],
      ),
    );
  }
}

class InvoiceItemWidget extends StatelessWidget {
  const InvoiceItemWidget({
    super.key,
    required this.product,
  });

  final DetailTransactionsResponse product;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: Text(
            product.productsName,
            style: GoogleFonts.poppins(
              color: Colors.black,
              fontSize: 12.sp,
              fontWeight: FontWeight.normal,
            ),
            // maxLines: 1,
            // overflow: TextOverflow.ellipsis,
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          flex: 2,
          child: Text(
            product.sellingPrice.toString(),
            style: GoogleFonts.poppins(
              color: Colors.black,
              fontSize: 12.sp,
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Text(
            product.quantity.toString(),
            style: GoogleFonts.poppins(
              color: Colors.black,
              fontSize: 12.sp,
              fontWeight: FontWeight.normal,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        Expanded(
          flex: 2,
          child: Text(
            (product.sellingPrice * product.quantity).toString(),
            style: GoogleFonts.poppins(
              color: Colors.black,
              fontSize: 12.sp,
              fontWeight: FontWeight.normal,
            ),
            textAlign: TextAlign.end,
          ),
        ),
      ],
    );
  }
}
