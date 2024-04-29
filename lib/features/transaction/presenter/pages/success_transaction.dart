import 'package:bluetooth_print/bluetooth_print_model.dart';
import 'package:flutter/material.dart';
import 'package:garing_bakery_apk/core/helpers/format_rupiah.dart';
import 'package:garing_bakery_apk/core/models/arguments/ArgumentStruck.dart';
import 'package:garing_bakery_apk/core/routes/app.dart';
import 'package:garing_bakery_apk/features/printer/data/service/struck_service.dart';
import 'package:garing_bakery_apk/features/transaction/data/model/reponse_add.dart';
import 'package:garing_bakery_apk/features/transaction/presenter/provider/cart_provider.dart';
import 'package:garing_bakery_apk/features/transaction/presenter/provider/print_provider.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class SuccessTransaction extends StatelessWidget {
  const SuccessTransaction({super.key, required this.result});
  final TransactionAddResponse result;
  @override
  Widget build(BuildContext context) {
    final cartProvider = context.read<CartProvider>();
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(
            vertical: 50,
          ),
          width: MediaQuery.of(context).size.width,
          color: Colors.white,
          child: Column(
            children: [
              const SuccessBanner(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Total Pembelian",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.grey,
                      ),
                    ),
                    Text(
                      formatRupiah(result.totalPrice),
                      style: const TextStyle(
                        fontSize: 20,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Nominal",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.grey,
                      ),
                    ),
                    Text(
                      formatRupiah(result.nominal),
                      style: const TextStyle(
                        fontSize: 20,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              KembalianWidget(
                kembalian: result.change,
              ),
              const SizedBox(
                height: 50,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  children: [
                    const ButtonNewTransaction(),
                    const SizedBox(
                      height: 20,
                    ),
                    PrintButtonWidget(
                      result: result,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ButtonSuccessWidget(
                        title: "Lihat Struk",
                        aksi: () {
                          Navigator.pushNamed(
                            context,
                            Routes.TRANSACTIONS_STRUK,
                            arguments: ArgumentStruct(
                              result.id,
                              null,
                            ),
                          );
                        }),
                    const SizedBox(
                      height: 20,
                    ),
                    ButtonSuccessWidget(
                      title: "Back to Dashboard",
                      aksi: () {
                        print("jalan ga");
                        cartProvider.setCartList = [];
                        cartProvider.setNominal = "C";
                        Navigator.popUntil(
                          context,
                          (route) => route.isFirst,
                        );
                      },
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class ButtonSuccessWidget extends StatelessWidget {
  String title;
  Function()? aksi;
  ButtonSuccessWidget({
    super.key,
    required this.title,
    this.aksi,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: aksi,
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 15,
          horizontal: 20,
        ),
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          border: Border.all(
            color: const Color.fromARGB(255, 20, 120, 25),
          ),
          borderRadius: const BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        child: Text(
          title,
          style: const TextStyle(
            color: Color.fromARGB(255, 20, 120, 25),
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class PrintButtonWidget extends StatelessWidget {
  const PrintButtonWidget({
    super.key,
    required this.result,
  });
  final TransactionAddResponse result;

  @override
  Widget build(BuildContext context) {
    final printProvider = context.watch<PrintProvider>();
    return InkWell(
      onTap: () async {
        if (!printProvider.connected) {
          return;
        }
        final struck = await SettingStruckService.getData();

        Map<String, dynamic> config = {};
        List<LineText> list = [];
        list.add(LineText(linefeed: 1));

        list.add(
          LineText(
            type: LineText.TYPE_TEXT,
            content: struck != null ? struck["company"] : "xxxx",
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
            // ignore: unnecessary_null_comparison, prefer_interpolation_to_compose_strings
            content: struck != null ? struck["alamat"] : "Gading Bakery",
            align: LineText.ALIGN_CENTER,
            linefeed: 1,
          ),
        );
        list.add(LineText(linefeed: 1));
        list.add(
          LineText(
            type: LineText.TYPE_TEXT,
            content: struck != null ? "No Hp: " + struck["notelp"] : "No Hp: ",
            weight: 0,
            align: LineText.ALIGN_CENTER,
            linefeed: 1,
          ),
        );
        list.add(LineText(linefeed: 1));
        DateFormat formatter = DateFormat('EEEE, dd MMMM yyyy', 'id_ID');
        list.add(
          LineText(
            type: LineText.TYPE_TEXT,
            content: formatter.format(result.createdAt),
            weight: 0,
            align: LineText.ALIGN_LEFT,
            linefeed: 1,
          ),
        );
        list.add(LineText(linefeed: 1));

        var pembayaran = 0;

        for (var i = 0; i < result.details.length; i++) {
          list.add(
            LineText(
              type: LineText.TYPE_TEXT,
              content: result.details[i].productsName,
              weight: 0,
              align: LineText.ALIGN_LEFT,
              linefeed: 1,
            ),
          );

          list.add(
            LineText(
              type: LineText.TYPE_TEXT,
              content:
                  "${result.details[i].sellingPrice} x ${result.details[i].quantity}",
              align: LineText.ALIGN_LEFT,
              linefeed: 0,
              x: 0,
            ),
          );
          final total = formatRupiah(
              result.details[i].sellingPrice * result.details[i].quantity);
          pembayaran +=
              result.details[i].sellingPrice * result.details[i].quantity;
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
            content: "Total",
            align: LineText.ALIGN_LEFT,
            linefeed: 0,
            x: 0,
          ),
        );

        list.add(
          LineText(
            type: LineText.TYPE_TEXT,
            content: formatRupiah(pembayaran),
            align: LineText.ALIGN_LEFT,
            linefeed: 0,
            x: 200 - formatRupiah(pembayaran).length,
          ),
        );
        list.add(LineText(linefeed: 1));
        list.add(
          LineText(
            type: LineText.TYPE_TEXT,
            content: "CASH",
            align: LineText.ALIGN_LEFT,
            linefeed: 0,
            x: 0,
          ),
        );

        list.add(
          LineText(
            type: LineText.TYPE_TEXT,
            content: formatRupiah(result.nominal),
            align: LineText.ALIGN_LEFT,
            linefeed: 0,
            x: 200 - formatRupiah(result.nominal).length,
          ),
        );

        list.add(LineText(linefeed: 1));

        list.add(
          LineText(
            type: LineText.TYPE_TEXT,
            content: "Kembalian",
            align: LineText.ALIGN_LEFT,
            linefeed: 0,
            x: 0,
          ),
        );

        list.add(
          LineText(
            type: LineText.TYPE_TEXT,
            content: formatRupiah(result.change),
            align: LineText.ALIGN_LEFT,
            linefeed: 0,
            x: 200 - formatRupiah(result.change).length,
          ),
        );

        list.add(LineText(linefeed: 1));
        list.add(LineText(linefeed: 1));

        list.add(
          LineText(
            type: LineText.TYPE_TEXT,
            content: struck != null
                ? struck["footer"]
                : "Terima Kasih Sudah berbelanja",
            align: LineText.ALIGN_CENTER,
            linefeed: 1,
          ),
        );
        list.add(LineText(linefeed: 1));
        list.add(LineText(linefeed: 1));

        debugPrint(list.toString());

        await printProvider.bluetoothPrint.printReceipt(config, list);
      },
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          border: Border.all(
            color: const Color.fromARGB(255, 20, 120, 25),
          ),
          borderRadius: const BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        child: Row(
          children: [
            const Icon(
              Icons.print_outlined,
              color: Color.fromARGB(255, 20, 120, 25),
              size: 30,
            ),
            const SizedBox(
              width: 20,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Cetak Struk",
                  style: TextStyle(
                    color: Color.fromARGB(255, 20, 120, 25),
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  printProvider.connected
                      ? "Langsung Cetak"
                      : "Printer belum di setting",
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 10,
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

class ButtonNewTransaction extends StatelessWidget {
  const ButtonNewTransaction({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(Routes.TRANSACTIONS);
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(
          20,
        ),
        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 20, 120, 25),
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        child: const Text(
          "Transaksi Baru",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}

class KembalianWidget extends StatelessWidget {
  const KembalianWidget({
    super.key,
    required this.kembalian,
  });

  final int kembalian;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            "Kembalian",
            style: TextStyle(
              fontSize: 20,
              color: Colors.grey,
            ),
          ),
          Text(
            formatRupiah(kembalian),
            style: const TextStyle(
              fontSize: 20,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}

class SuccessBanner extends StatelessWidget {
  const SuccessBanner({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: Container(
            width: 100,
            height: 100,
            decoration: const BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.all(
                Radius.circular(
                  50,
                ),
              ),
            ),
            child: const Icon(
              Icons.check,
              color: Colors.white,
              size: 40,
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        const Text(
          "Good Job",
          style: TextStyle(
            color: Color.fromARGB(255, 128, 128, 128),
            fontWeight: FontWeight.w800,
            fontSize: 30,
          ),
        ),
        const Text(
          "Transaksi Berhasil",
          style: TextStyle(
            color: Color.fromARGB(255, 128, 128, 128),
            fontWeight: FontWeight.w500,
            fontSize: 22,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
