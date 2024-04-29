import 'package:flutter/material.dart';
import 'package:garing_bakery_apk/core/config/theme.dart';
import 'package:garing_bakery_apk/core/models/products_model.dart';
import 'package:garing_bakery_apk/features/transaction/presenter/provider/cart_provider.dart';
import 'package:garing_bakery_apk/features/transaction/presenter/widgets/kasir/button_checkout_widget.dart';
import 'package:garing_bakery_apk/features/transaction/presenter/widgets/kasir/product_cart_widget.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

class TransactionPage extends StatelessWidget {
  const TransactionPage({super.key});
  @override
  Widget build(BuildContext context) {
    final cartProvider = context.read<CartProvider>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: MyTheme.primary,
          ),
          onPressed: () {
            final cartProvider = context.read<CartProvider>();
            if (cartProvider.cartList.isNotEmpty) {
              QuickAlert.show(
                onCancelBtnTap: () {
                  Navigator.pop(context);
                },
                onConfirmBtnTap: () {
                  cartProvider.setCartList = [];
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
                context: context,
                type: QuickAlertType.confirm,
                text: 'Apakah ingin membatalkan transaksi ?',
                titleAlignment: TextAlign.right,
                textAlignment: TextAlign.right,
                confirmBtnText: 'Yes',
                cancelBtnText: 'No',
                confirmBtnColor: MyTheme.primary,
                backgroundColor: MyTheme.white,
                headerBackgroundColor: Colors.grey,
                confirmBtnTextStyle: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                titleColor: Colors.black,
                textColor: Colors.black,
              );
            } else {
              Navigator.of(context).pop();
            }
          },
        ),
        title: const Text(
          'Kasir',
          style: TextStyle(color: MyTheme.primary, fontWeight: FontWeight.w700),
        ),
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            Expanded(
              child: FutureBuilder<List<ProductModel>>(
                future: cartProvider.getProduct(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  if (!snapshot.hasData) {
                    return const Center(
                      child: Text("Tidak punya produk"),
                    );
                  }

                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return ProductCartWidget(index: index);
                    },
                  );
                },
              ),
            ),
            const ButtonCheckout(),
          ],
        ),
      ),
    );
  }
}
