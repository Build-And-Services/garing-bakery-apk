import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:garing_bakery_apk/core/config/theme.dart';
import 'package:garing_bakery_apk/core/models/products_model.dart';
import 'package:garing_bakery_apk/core/widgets/shimmer/wrapper_shimmer_widget.dart';
import 'package:garing_bakery_apk/features/product/presenter/provider/product_provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

// ignore: must_be_immutable
class ProductCardItem extends StatelessWidget {
  ProductModel product;
  ProductCardItem({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final providerProduct = context.watch<ProductProvider>();
    return Card(
      color: const Color.fromARGB(255, 232, 232, 232),
      shadowColor: Colors.black12,
      borderOnForeground: true,
      semanticContainer: true,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              CachedNetworkImage(
                imageUrl: product.image,
                placeholder: (context, url) => WrapperShimmer(
                  child: Container(
                    width: double.infinity,
                    height: 150,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                  ),
                ),
                imageBuilder: (context, imageProvider) {
                  return Container(
                    width: double.infinity,
                    height: 150,
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
              Positioned(
                right: 5,
                top: 5,
                child: InkWell(
                  onTap: () {
                    QuickAlert.show(
                      onCancelBtnTap: () {
                        Navigator.pop(context);
                      },
                      onConfirmBtnTap: () {
                        providerProduct.delete(product.id).then((value) {
                          Navigator.pop(context);
                          MyTheme.alertSucces(
                              context, "Berhasil menghapus data");
                        }).catchError((onError) {
                          Navigator.pop(context);
                          MyTheme.alertError(context, "Gagal menghapus data");
                        });
                      },
                      context: context,
                      confirmBtnColor: Colors.red,
                      type: QuickAlertType.confirm,
                      text: 'apakah anda akan menghapus barang ini',
                      confirmBtnText: 'Hapus',
                      cancelBtnText: 'Tidak jadi',
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 2),
                    decoration: BoxDecoration(
                      color: MyTheme.primary,
                      borderRadius: const BorderRadius.all(
                        Radius.circular(
                          5,
                        ),
                      ),
                      border: Border.all(
                        color: const Color.fromARGB(255, 204, 16, 2),
                        width: 1,
                        style: BorderStyle.solid,
                      ),
                    ),
                    child: const Icon(
                      Icons.delete,
                      color: Color.fromARGB(255, 204, 16, 2),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              product.name,
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w600,
                              ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                            Text(product.category),
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 30,
                      ),
                      Text(
                        "${product.quantity}",
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: const Color.fromARGB(255, 32, 138, 35),
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("harga: "),
                      Text("Rp. ${product.sellingPrice}"),
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
