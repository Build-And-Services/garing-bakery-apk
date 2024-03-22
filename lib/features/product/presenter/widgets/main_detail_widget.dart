import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:garing_bakery_apk/core/config/theme.dart';
import 'package:garing_bakery_apk/core/helpers/format_rupiah.dart';
import 'package:garing_bakery_apk/core/models/products_model.dart';
import 'package:garing_bakery_apk/core/routes/app.dart';
import 'package:garing_bakery_apk/core/widgets/shimmer/wrapper_shimmer_widget.dart';
import 'package:garing_bakery_apk/features/product/presenter/provider/form_edit_stok_provider.dart';
import 'package:garing_bakery_apk/features/product/presenter/provider/product_provider.dart';
import 'package:garing_bakery_apk/features/product/presenter/widgets/button_detail_widget.dart';
import 'package:garing_bakery_apk/features/product/presenter/widgets/form_stock_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class MainDetailProductWidget extends StatefulWidget {
  const MainDetailProductWidget({
    super.key,
    required this.products,
    required this.id,
  });

  final ProductModel products;
  final String id;

  @override
  State<MainDetailProductWidget> createState() =>
      _MainDetailProductWidgetState();
}

class _MainDetailProductWidgetState extends State<MainDetailProductWidget> {
  @override
  Widget build(BuildContext context) {
    // provider
    final formStokProvider = context.watch<FormStokProvider>();
    final productProvider = context.watch<ProductProvider>();

    // product for show from provider
    List<ProductModel> products = productProvider.products;
    ProductModel product = productProvider.products[products.indexWhere(
      (element) => element.id.toString() == widget.id,
    )];

    return Column(
      children: [
        imageMethod(product),
        Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              descriptionMethod(product),
              ButtonDetailWidget(
                title: 'Detail Sisa Stock',
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    Routes.DETAIL_STOCK_PRODUCT,
                    arguments: widget.id,
                  );
                },
                icon: Icons.arrow_forward_ios,
              ),
              const SizedBox(
                height: 20,
              ),
              ButtonDetailWidget(
                title: 'Edit Kue',
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    Routes.EDIT_PRODUCT,
                    arguments: widget.id,
                  );
                },
                icon: Icons.edit,
              ),
              const SizedBox(
                height: 20,
              ),
              ButtonDetailWidget(
                title: 'Edit Stock',
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(8.0),
                            ),
                          ),
                          contentPadding: const EdgeInsets.only(top: 10.0),
                          content: SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: FormEditStockWidget(id: widget.id),
                          ),
                        );
                      }).then((value) {
                    if (formStokProvider.isLoading) {
                      formStokProvider.updateStok(context).then((value) {
                        formStokProvider.loading = false;
                        Navigator.pop(context);
                        if (value) {
                          MyTheme.alertSucces(context, 'Success');
                          productProvider.setProduct =
                              productProvider.products.map((e) {
                            if (e.id.toString() == widget.id) {
                              return ProductModel(
                                id: e.id,
                                name: e.name,
                                image: e.image,
                                productCode: e.productCode,
                                category: e.category,
                                quantity:
                                    formStokProvider.body!.type == 'increase'
                                        ? e.quantity +
                                            formStokProvider.body!.quantity
                                        : e.quantity -
                                            formStokProvider.body!.quantity,
                                purchasePrice: e.purchasePrice,
                                sellingPrice: e.sellingPrice,
                              );
                            }
                            return e;
                          }).toList();
                        } else {
                          MyTheme.alertError(context, 'Gagal update stock');
                        }
                      });
                    }
                  });
                },
                icon: Icons.edit,
              ),
            ],
          ),
        ),
      ],
    );
  }

  // image show
  CachedNetworkImage imageMethod(ProductModel product) {
    return CachedNetworkImage(
      imageUrl: product.image,
      placeholder: (context, url) => WrapperShimmer(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 200.sp,
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
        ),
      ),
      imageBuilder: (context, imageProvider) {
        return Container(
          width: MediaQuery.of(context).size.width,
          height: 200.sp,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: imageProvider,
              fit: BoxFit.cover,
            ),
          ),
        );
      },
    );
  }

  // description detail
  Column descriptionMethod(ProductModel product) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          product.name,
          style: GoogleFonts.poppins(
            fontSize: 18.sp.sp,
            fontWeight: FontWeight.w800,
            color: Colors.black,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          "Harga Jual ${formatRupiah(product.sellingPrice)}",
          style: GoogleFonts.poppins(
            fontSize: 14.sp,
            color: Colors.grey,
            fontWeight: FontWeight.w600,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        Text(
          "Harga Dasar ${formatRupiah(product.purchasePrice)}",
          style: GoogleFonts.poppins(
            fontSize: 14.sp,
            color: Colors.grey,
            fontWeight: FontWeight.w600,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(
          height: 20,
        ),
        Flex(
          direction: Axis.horizontal,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Kode",
                    style: GoogleFonts.poppins(
                      fontSize: 15.sp,
                      color: Colors.grey,
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    product.productCode,
                    style: GoogleFonts.poppins(
                      fontSize: 15.sp,
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Stock",
                    style: GoogleFonts.poppins(
                      fontSize: 15.sp,
                      color: Colors.grey,
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    product.quantity.toString(),
                    style: GoogleFonts.poppins(
                      fontSize: 15.sp,
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Category",
                    style: GoogleFonts.poppins(
                      fontSize: 15.sp,
                      color: Colors.grey,
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    product.category ?? "Null category",
                    style: GoogleFonts.poppins(
                      fontSize: 15.sp,
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 50,
        ),
      ],
    );
  }
}
