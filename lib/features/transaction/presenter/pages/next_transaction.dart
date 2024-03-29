import 'package:flutter/material.dart';
import 'package:garing_bakery_apk/core/config/theme.dart';
import 'package:garing_bakery_apk/core/helpers/format_rupiah.dart';
import 'package:garing_bakery_apk/core/routes/app.dart';
import 'package:garing_bakery_apk/features/transaction/data/model/reponse_add.dart';
import 'package:garing_bakery_apk/features/transaction/presenter/provider/cart_provider.dart';
import 'package:provider/provider.dart';

class NextTransaction extends StatelessWidget {
  const NextTransaction({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> keys = [
      "7",
      "8",
      "9",
      "C",
      "4",
      "5",
      "6",
      "x",
      "1",
      "2",
      "3",
      "z",
      "0",
      "000",
      ".",
      "selesai"
    ];
    final cartProvider = context.watch<CartProvider>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: MyTheme.primary,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          "Total: ${cartProvider.getTotal}",
          style: const TextStyle(
            color: MyTheme.primary,
            fontWeight: FontWeight.w400,
          ),
        ),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(
            4.0,
          ),
          child: Container(
            color: const Color.fromARGB(
              255,
              182,
              182,
              182,
            ),
            height: 0.5,
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(
          10,
        ),
        child: Column(
          children: [
            InputNominal(
              cartProvider: cartProvider,
            ),
            // TODO: not responsive for tablet, just hp heri which support
            Expanded(
              child: GridView.count(
                crossAxisCount: 4,
                childAspectRatio: 0.69,
                children: List.generate(keys.length, (index) {
                  return InkWell(
                    onTap: () {
                      cartProvider.setNominal = keys[index];
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 10,
                      ),
                      child: keys[index] == "x"
                          ? const Icon(
                              Icons.backspace_outlined,
                              color: MyTheme.primary,
                            )
                          : keys[index] == "z"
                              ? const Icon(
                                  Icons.money,
                                  color: MyTheme.primary,
                                )
                              : keys[index] == "selesai"
                                  ? InkWell(
                                      onTap: () async {
                                        if (cartProvider.checkNominal()) {
                                          cartProvider
                                              .addTransaction()
                                              .then((result) {
                                            TransactionAddResponse? data =
                                                result;
                                            if (data != null) {
                                              Navigator.pushReplacementNamed(
                                                context,
                                                Routes.TRANSACTIONS_SUCCESS,
                                                arguments: data,
                                              );
                                            } else {
                                              Navigator.popUntil(context,
                                                  (route) {
                                                return route.isFirst;
                                              });
                                            }
                                          });
                                        }
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: cartProvider.checkNominal()
                                              ? const Color.fromARGB(
                                                  255, 95, 204, 98)
                                              : const Color.fromARGB(
                                                  255, 209, 239, 210),
                                          borderRadius: const BorderRadius.all(
                                            Radius.circular(5),
                                          ),
                                        ),
                                        child: !cartProvider.isLoading
                                            ? const Icon(
                                                Icons.check,
                                                color: Colors.white,
                                                size: 60,
                                              )
                                            : const Center(
                                                child:
                                                    CircularProgressIndicator(),
                                              ),
                                      ),
                                    )
                                  : Center(
                                      child: Text(
                                        keys[index],
                                        style: const TextStyle(
                                          fontSize: 34.0,
                                          fontWeight: FontWeight.w700,
                                          color: Color.fromARGB(
                                            255,
                                            118,
                                            115,
                                            115,
                                          ),
                                        ),
                                      ),
                                    ),
                    ),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class InputNominal extends StatelessWidget {
  const InputNominal({
    super.key,
    required this.cartProvider,
  });

  final CartProvider cartProvider;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(
        vertical: 40,
      ),
      child: Center(
        child: Text(
          formatRupiah(cartProvider.nominal),
          style: TextStyle(
            color: Colors.green[800],
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
