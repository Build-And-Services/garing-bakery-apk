import 'package:flutter/material.dart';
import 'package:garing_bakery_apk/core/helpers/format_rupiah.dart';
import 'package:garing_bakery_apk/core/models/arguments/ArgumentStruck.dart';
import 'package:garing_bakery_apk/core/routes/app.dart';
import 'package:garing_bakery_apk/features/transaction/data/model/reponse_add.dart';
import 'package:garing_bakery_apk/features/transaction/presenter/provider/cart_provider.dart';
import 'package:garing_bakery_apk/features/transaction/presenter/widgets/success/success_widget.dart';
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
