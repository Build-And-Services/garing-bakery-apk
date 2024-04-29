import 'package:flutter/material.dart';
import 'package:garing_bakery_apk/core/config/theme.dart';
import 'package:garing_bakery_apk/core/routes/app.dart';
import 'package:garing_bakery_apk/features/transaction/presenter/provider/cart_provider.dart';
import 'package:provider/provider.dart';

class ButtonCheckout extends StatelessWidget {
  const ButtonCheckout({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final cardProvider = context.watch<CartProvider>();
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 40,
      ),
      width: MediaQuery.of(context).size.width - 20,
      height: 80,
      child: InkWell(
        onTap: () {
          if (cardProvider.cartList.isNotEmpty) {
            Navigator.pushNamed(context, Routes.TRANSACTIONS_NEXT);
          } else {
            MyTheme.alertWarning(context, "Pilih Menu terlebih dahulu");
          }
        },
        child: Container(
          decoration: const BoxDecoration(
            color: MyTheme.primary,
            borderRadius: BorderRadius.all(
              Radius.circular(100),
            ),
          ),
          child: Center(
            child: Text(
              cardProvider.cartList.isNotEmpty
                  ? "Lanjut Transaksi"
                  : "Silahkan pilih roti",
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontSize: 18,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
