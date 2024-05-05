import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:garing_bakery_apk/core/config/theme.dart';
import 'package:garing_bakery_apk/core/helpers/format_rupiah.dart';
import 'package:garing_bakery_apk/core/models/products_model.dart';
import 'package:garing_bakery_apk/core/routes/app.dart';
import 'package:garing_bakery_apk/core/widgets/drawer_widget.dart';
import 'package:garing_bakery_apk/core/widgets/search_widget.dart';
import 'package:garing_bakery_apk/features/auth/presenter/provider/auth_provider.dart';
import 'package:garing_bakery_apk/features/product/presenter/widgets/product_card_widget.dart';
import 'package:garing_bakery_apk/features/product/presenter/provider/product_provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class ProductSubPage extends StatelessWidget {
  const ProductSubPage({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = context.read<AuthProvider>();
    String? role;
    if (authProvider.userCache != null) {
      role = authProvider.userCache!.role;
    }
    return Consumer<ProductProvider>(
      builder: (context, productProvider, child) {
        if (productProvider.eventLoadingStatus) {
          productProvider.getProduct();
        }
        List<Widget> action = [
          GestureDetector(
            onTap: () async {
              productProvider.setLoading = true;
            },
            child: const Icon(Icons.refresh_rounded),
          ),
          const SizedBox(
            width: 20,
          ),
          role == "cashier"
              ? Container()
              : GestureDetector(
                  onTap: () =>
                      Navigator.of(context).pushNamed(Routes.ADD_PRODUCT),
                  child: const Icon(Icons.add),
                ),
          const SizedBox(
            width: 20,
          ),
        ];
        return Scaffold(
          drawer: const DrawerPage(),
          appBar: MyTheme.appBar(
            "Produk / Barang",
            action,
          ),
          body: RefreshIndicator(
            onRefresh: () async {
              productProvider.setLoading = true;
            },
            child: Container(
              color: const Color.fromARGB(255, 255, 250, 244),
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  SearchWidget(
                    fn: (String keyword) {
                      productProvider.filter(keyword);
                    },
                    dispose: () {
                      productProvider.getProduct();
                    },
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Expanded(
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        if (constraints.maxWidth > 500) {
                          return GridView.count(
                            crossAxisCount: 2,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            childAspectRatio: 2.8,
                            children: productProvider.products.map((e) {
                              return ProductCardTabletWidget(product: e);
                              // return Container();
                            }).toList(),
                          );
                          // return ProductCardTabletWidget(
                          //     product: productProvider.products[0]);
                        } else {
                          return productProvider.eventLoadingStatus
                              ? const ProductSimmer()
                              : ListView(
                                  children: productProvider.products.map((e) {
                                    return ProductCardWidget(
                                      product: e,
                                    );
                                  }).toList(),
                                );
                        }
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class ProductCardTabletWidget extends StatelessWidget {
  const ProductCardTabletWidget({
    super.key,
    required this.product,
    this.pageProduct = true,
  });

  final ProductModel product;
  final bool pageProduct;

  @override
  Widget build(BuildContext context) {
    final productProvider = context.watch<ProductProvider>();
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
        margin: const EdgeInsets.symmetric(
          vertical: 5,
          horizontal: 20,
        ),
        padding: EdgeInsets.all(
          4.sp,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(
              12.sp,
            ),
          ),
          border: Border.all(
            color: Colors.grey,
            width: 0.2.sp,
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
                    width: 50.sp,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(
                          6.sp,
                        ),
                      ),
                      color: Colors.brown,
                    ),
                  ),
                );
              },
              imageBuilder: (context, imageProvider) {
                return Container(
                  width: 50.sp,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(
                        6.sp,
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
              width: 8.sp,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: GoogleFonts.poppins(
                      fontSize: 10.sp,
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
                      fontSize: 8.sp,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(
                    height: 8.sp,
                  ),
                  Text(
                    formatRupiah(product.sellingPrice),
                    style: GoogleFonts.poppins(
                      fontSize: 8.sp,
                      color: Colors.brown,
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            pageProduct
                ? Column(
                    children: [
                      InkWell(
                        onTap: () {
                          // debugPrint(product.id.toString());
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
                          size: 13.sp,
                        ),
                      ),
                    ],
                  )
                : const Column(),
          ],
        ),
      ),
    );
  }
}

class ProductSimmer extends StatelessWidget {
  const ProductSimmer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        ProductCardShimmer(),
        ProductCardShimmer(),
        ProductCardShimmer(),
        ProductCardShimmer(),
      ],
    );
  }
}

class ProductCardShimmer extends StatelessWidget {
  const ProductCardShimmer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
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
          )),
      child: Row(
        children: [
          Shimmer.fromColors(
            baseColor: const Color.fromARGB(255, 205, 205, 205),
            highlightColor: const Color.fromARGB(255, 255, 243, 239),
            child: Container(
              width: 100.sp,
              height: 100.sp,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(
                    12.sp,
                  ),
                ),
                color: MyTheme.primary,
              ),
            ),
          ),
          SizedBox(
            width: 20.sp,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Shimmer.fromColors(
                  baseColor: const Color.fromARGB(255, 205, 205, 205),
                  highlightColor: const Color.fromARGB(255, 255, 243, 239),
                  child: Container(
                    height: 18.sp,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: MyTheme.primary,
                      borderRadius: BorderRadius.all(
                        Radius.circular(8),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.sp,
                ),
                Shimmer.fromColors(
                  baseColor: const Color.fromARGB(255, 205, 205, 205),
                  highlightColor: const Color.fromARGB(255, 255, 243, 239),
                  child: Container(
                    height: 14.sp,
                    width: 80.sp,
                    decoration: const BoxDecoration(
                      color: MyTheme.primary,
                      borderRadius: BorderRadius.all(
                        Radius.circular(8),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.sp,
                ),
                Shimmer.fromColors(
                  baseColor: const Color.fromARGB(255, 205, 205, 205),
                  highlightColor: const Color.fromARGB(255, 255, 243, 239),
                  child: Container(
                    height: 14.sp,
                    width: 130.sp,
                    decoration: const BoxDecoration(
                      color: MyTheme.primary,
                      borderRadius: BorderRadius.all(
                        Radius.circular(8),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 25.sp,
          ),
        ],
      ),
    );
  }
}
