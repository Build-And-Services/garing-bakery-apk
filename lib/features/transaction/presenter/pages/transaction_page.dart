import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:garing_bakery_apk/core/config/theme.dart';
import 'package:garing_bakery_apk/core/helpers/format_rupiah.dart';
import 'package:garing_bakery_apk/core/models/products_model.dart';
import 'package:garing_bakery_apk/core/routes/app.dart';
import 'package:garing_bakery_apk/features/transaction/presenter/provider/cart_provider.dart';
import 'package:google_fonts/google_fonts.dart';
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
                // barrierColor: Colors.white,
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
                      // ProductModel product = snapshot.data![index];
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

class ProductCartWidget extends StatelessWidget {
  const ProductCartWidget({
    super.key,
    required this.index,
  });

  final int index;

  @override
  Widget build(BuildContext context) {
    final cartProvider = context.read<CartProvider>();
    return Container(
      margin: const EdgeInsets.only(
        left: 20,
        right: 20,
      ),
      padding: const EdgeInsets.all(10),
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
        border: Border.symmetric(
          horizontal: BorderSide(
            color: Color.fromARGB(255, 169, 169, 169),
            width: 0.3,
            style: BorderStyle.solid,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CachedNetworkImage(
                imageUrl: cartProvider.products[index].image,
                progressIndicatorBuilder: (context, url, progress) {
                  return Container(
                    width: 80,
                    height: 80,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    child: CircularProgressIndicator(
                      value: progress.progress,
                      color: MyTheme.primary,
                    ),
                  );
                },
                imageBuilder: (context, imageProvider) {
                  return Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(10),
                      ),
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.fill,
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(
                width: 20,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      cartProvider.products[index].name,
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      "stock: ${cartProvider.products[index].quantity}",
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      formatRupiah(cartProvider.products[index].sellingPrice),
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              AddItemWidget(product: cartProvider.products[index])
            ],
          ),
        ],
      ),
    );
  }
}

// ignore: must_be_immutable
class AddItemWidget extends StatelessWidget {
  ProductModel product;
  AddItemWidget({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    final cartProvider = context.watch<CartProvider>();
    return SizedBox(
      height: MediaQuery.of(context).size.height / 20,
      child: AnimatedSwitcher(
        duration: const Duration(
          milliseconds: 1100,
        ),
        child: (cartProvider.isThereCart(product))
            ? Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                    onTap: () => cartProvider.minusCartProduct(product),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: MyTheme.primary,
                          width: 2,
                          style: BorderStyle.solid,
                        ),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(
                            100,
                          ),
                        ),
                      ),
                      child: const Icon(
                        Icons.remove,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Text(
                    cartProvider.getCart(product).count.toString(),
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: MyTheme.primary,
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  InkWell(
                    onTap: () {
                      cartProvider.toggleCartProduct(product, context);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: MyTheme.primary,
                          width: 2,
                          style: BorderStyle.solid,
                        ),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(
                            100,
                          ),
                        ),
                      ),
                      child: const Icon(
                        Icons.add_rounded,
                      ),
                    ),
                  ),
                ],
              )
            : InkWell(
                onTap: () {
                  cartProvider.toggleCartProduct(product, context);
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(
                        20,
                      ),
                    ),
                    border: Border.all(
                      color: MyTheme.primary,
                      width: 2,
                      style: BorderStyle.solid,
                    ),
                  ),
                  child: Text(
                    "Tambah",
                    style: GoogleFonts.poppins(
                      color: MyTheme.primary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}

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
