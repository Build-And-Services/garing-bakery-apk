import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:garing_bakery_apk/core/config/theme.dart';
import 'package:garing_bakery_apk/core/helpers/format_rupiah.dart';
import 'package:garing_bakery_apk/core/models/products_model.dart';
import 'package:garing_bakery_apk/features/product/presenter/provider/product_provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class TransactionPage extends StatelessWidget {
  const TransactionPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: MyTheme.primary,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Kasir',
          style: TextStyle(color: MyTheme.primary, fontWeight: FontWeight.w700),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: Consumer<ProductProvider>(
                builder: (context, productProvider, child) {
                  if (productProvider.eventLoadingStatus) {
                    productProvider.getProduct();
                  }
                  return ListView.builder(
                    itemCount: productProvider.products.length,
                    itemBuilder: (context, index) {
                      ProductModel product = productProvider.products[index];
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        product.name,
                                        style: GoogleFonts.poppins(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        formatRupiah(product.sellingPrice),
                                        style: GoogleFonts.poppins(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                CachedNetworkImage(
                                  imageUrl: product.image,
                                  progressIndicatorBuilder:
                                      (context, url, progress) {
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
                                          color: MyTheme.primary),
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
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            const AddItemWidget()
                          ],
                        ),
                      );
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

class AddItemWidget extends StatefulWidget {
  const AddItemWidget({
    super.key,
  });

  @override
  State<AddItemWidget> createState() => _AddItemWidgetState();
}

class _AddItemWidgetState extends State<AddItemWidget> {
  int count = 0;

  addProduct() {
    setState(() {
      count++;
    });
  }

  minusProduct() {
    setState(() {
      count--;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 20,
      child: AnimatedSwitcher(
        duration: const Duration(
          milliseconds: 1100,
        ),
        child: (count >= 1)
            ? Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                    onTap: minusProduct,
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
                    count.toString(),
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
                    onTap: addProduct,
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
                onTap: addProduct,
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
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 40,
      ),
      width: MediaQuery.of(context).size.width - 20,
      height: MediaQuery.of(context).size.height / 12,
      child: InkWell(
        onTap: () {
          debugPrint("hallo");
        },
        child: Container(
          decoration: const BoxDecoration(
            color: MyTheme.primary,
            borderRadius: BorderRadius.all(
              Radius.circular(100),
            ),
          ),
          child: const Center(
            child: Text(
              "Silahkan pilih roti",
              style: TextStyle(
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
