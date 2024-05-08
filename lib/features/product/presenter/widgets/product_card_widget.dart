import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:garing_bakery_apk/core/config/theme.dart';
import 'package:garing_bakery_apk/core/helpers/format_rupiah.dart';
import 'package:garing_bakery_apk/core/models/products_model.dart';
import 'package:garing_bakery_apk/core/routes/app.dart';
import 'package:garing_bakery_apk/features/auth/presenter/provider/auth_provider.dart';
import 'package:garing_bakery_apk/features/product/presenter/provider/product_provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class ProductCardWidget extends StatelessWidget {
  const ProductCardWidget({
    super.key,
    required this.product,
  });

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final productProvider = context.watch<ProductProvider>();
    final authProvider = context.read<AuthProvider>();
    String? role;
    if (authProvider.userCache != null) {
      role = authProvider.userCache!.role;
    }

    return InkWell(
      onTap: () {
        Navigator.pushNamed(
          context,
          Routes.DETAIL_PRODUCT,
          arguments: product.id,
        );
      },
      child: Container(
        width: double.infinity,
        height: 100.sp,
        margin: const EdgeInsets.symmetric(
          vertical: 5,
          horizontal: 20,
        ),
        padding: EdgeInsets.all(
          8.sp,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(
              16.sp,
            ),
          ),
          border: Border.all(
            color: Colors.grey,
            width: 0.5.sp,
            style: BorderStyle.solid,
          ),
        ),
        child: Row(
          children: [
            CachedNetworkImage(
              imageUrl: product.image,
              placeholder: (context, url) {
                return Shimmer.fromColors(
                  baseColor: const Color(0xffc39777),
                  highlightColor: const Color.fromARGB(255, 252, 211, 197),
                  child: Container(
                    width: 100.sp,
                    height: 100.sp,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(
                          12.sp,
                        ),
                      ),
                      color: Colors.brown,
                    ),
                  ),
                );
              },
              imageBuilder: (context, imageProvider) {
                return Container(
                  width: 100.sp,
                  height: 100.sp,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(
                        12.sp,
                      ),
                    ),
                    color: Colors.brown,
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              },
            ),
            SizedBox(
              width: 20.sp,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: GoogleFonts.poppins(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w700,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(
                    height: 2.sp,
                  ),
                  Text(
                    "Stok: ${product.quantity}",
                    style: GoogleFonts.poppins(
                      fontSize: 14.sp,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(
                    height: 2.sp,
                  ),
                  Text(
                    formatRupiah(product.sellingPrice),
                    style: GoogleFonts.poppins(
                      fontSize: 14.sp,
                      color: Colors.brown,
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 25.sp,
            ),
            Column(
              children: [
                role == "cashier"
                    ? Container()
                    : InkWell(
                        onTap: () {
                          MyTheme.alertWarning(
                            context,
                            "Apakah anda yakin menghapus",
                            showCancelBtn: true,
                            onConfirmBtnTap: () {
                              Navigator.pop(context);
                              productProvider.delete(product.id);
                            },
                          );
                        },
                        child: Icon(
                          Icons.delete,
                          color: const Color(0xffc39777),
                          size: 26.sp,
                        ),
                      ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
