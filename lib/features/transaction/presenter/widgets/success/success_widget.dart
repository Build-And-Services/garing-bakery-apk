import 'package:flutter/material.dart';
import 'package:garing_bakery_apk/core/config/theme.dart';
import 'package:garing_bakery_apk/core/helpers/format_rupiah.dart';
import 'package:garing_bakery_apk/core/routes/app.dart';
import 'package:garing_bakery_apk/features/transaction/data/model/reponse_add.dart';
import 'package:garing_bakery_apk/features/transaction/presenter/provider/print_provider.dart';
import 'package:provider/provider.dart';

class ButtonSuccessWidget extends StatelessWidget {
  final String title;
  final Function()? aksi;
  const ButtonSuccessWidget({
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
    return FutureBuilder(
        future: printProvider.bluetoothPrint.isConnected,
        builder: (context, snapshot) {
          bool connected = false;
          if (snapshot.data != null) {
            connected = snapshot.data!;
          }

          return InkWell(
            onTap: () async {
              if ((await printProvider.bluetoothPrint.isConnected)!) {
                printProvider.print(result).then((value) {
                  if (!value) {
                    return MyTheme.alertError(
                      context,
                      "Terjadi Kesalahan",
                    );
                  }
                });
              } else {
                // ignore: use_build_context_synchronously
                return MyTheme.alertError(
                  context,
                  "Anda belum terkoneksi dengan printer",
                );
              }
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
                        connected
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
        });
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
