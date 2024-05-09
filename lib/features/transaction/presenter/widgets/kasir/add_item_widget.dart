import 'package:flutter/material.dart';
import 'package:garing_bakery_apk/core/config/theme.dart';
import 'package:garing_bakery_apk/core/models/products_model.dart';
import 'package:garing_bakery_apk/features/transaction/presenter/provider/cart_provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class AddItemWidget extends StatelessWidget {
  final ProductModel product;
  const AddItemWidget({
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
