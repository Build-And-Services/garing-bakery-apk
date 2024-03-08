import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:garing_bakery_apk/core/config/theme.dart';
import 'package:garing_bakery_apk/core/models/products_model.dart';
import 'package:garing_bakery_apk/core/routes/app.dart';
import 'package:garing_bakery_apk/core/widgets/drawer_widget.dart';
import 'package:garing_bakery_apk/core/widgets/search_widget.dart';
import 'package:garing_bakery_apk/core/widgets/shimmer/wrapper_shimmer_widget.dart';
import 'package:garing_bakery_apk/features/product/presenter/widgets/shimmer_loading.dart';
import 'package:garing_bakery_apk/features/product/presenter/provider/product_provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/main.dart';

class ProductSubPage extends StatelessWidget {
  const ProductSubPage({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Consumer<ProductProvider>(
      builder: (context, productProvider, child) {
        if (productProvider.eventLoadingStatus) {
          productProvider.getProduct();
          return const SimmerPage();
        }
        return Scaffold(
          drawer: const DrawerPage(),
          appBar: MyTheme.appBar(
            "Produk / Barang",
            [
              GestureDetector(
                onTap: () async {
                  productProvider.setLoading = true;
                },
                child: const Icon(Icons.refresh_rounded),
              ),
              const SizedBox(
                width: 20,
              ),
              GestureDetector(
                onTap: () =>
                    Navigator.of(context).pushNamed(Routes.ADD_PRODUCT),
                child: const Icon(Icons.add),
              ),
              const SizedBox(
                width: 20,
              ),
            ],
          ),
          body: RefreshIndicator(
            onRefresh: () async {
              productProvider.setLoading = true;
            },
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  const SearchWidget(),
                  const SizedBox(
                    height: 30,
                  ),
                  Column(
                    children: productProvider.products
                        .map((e) => InkWell(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, Routes.DETAIL_PRODUCT,
                                    arguments: e.id);
                              },
                              child: Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Card(
                                  semanticContainer: true,
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  shadowColor: Colors.black,
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    // mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      ImageProduct(e: e, width: width),
                                      Expanded(
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                            vertical: 20,
                                            horizontal: 15,
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        e.name,
                                                        style:
                                                            GoogleFonts.poppins(
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          color: Colors.black,
                                                          fontSize: 16,
                                                        ),
                                                        maxLines: 1,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                      const Text(
                                                        "983247983247",
                                                        style: TextStyle(
                                                          fontSize: 10,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(
                                                    width: 30,
                                                  ),
                                                  const Expanded(
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .end,
                                                      children: [
                                                        Text(
                                                          "20",
                                                          style: TextStyle(
                                                            fontSize: 10,
                                                          ),
                                                        ),
                                                        Text(
                                                          "Rp. 90.000 - Rp 95.000 0000000000000000000000",
                                                          style: TextStyle(
                                                            fontSize: 10,
                                                          ),
                                                          maxLines: 1,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ),
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 15,
                                              ),
                                              InkWell(
                                                onTap: () {},
                                                child: SizedBox(
                                                  width: 80,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        "Delete",
                                                        style:
                                                            GoogleFonts.poppins(
                                                          color: Colors.red,
                                                          fontSize: 10,
                                                        ),
                                                      ),
                                                      const Icon(
                                                        Icons.delete,
                                                        color: Colors.red,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ))
                        .toList(),
                  )
                  // Expanded(
                  //   child: Padding(
                  //     padding: const EdgeInsets.symmetric(vertical: 2.0),
                  //     child: Container(
                  //       padding: const EdgeInsets.symmetric(
                  //         horizontal: 20,
                  //       ),
                  //       child: _builderGridview(productProvider, context),
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class ImageProduct extends StatelessWidget {
  const ImageProduct({
    super.key,
    required this.e,
    required this.width,
  });

  final ProductModel e;
  final double width;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return CachedNetworkImage(
      imageUrl: e.image,
      placeholder: (context, url) => WrapperShimmer(
        child: Container(
          width: width > 420 ? width / 3 : width / 3,
          height: width > 420 ? height / 2.5 : height / 7,
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
          width: width > 420 ? width / 3 : width / 3,
          height: height / 6,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(
              Radius.circular(10),
            ),
            image: DecorationImage(
              image: imageProvider,
              fit: BoxFit.cover,
            ),
          ),
        );
      },
    );
  }
}

class SimmerPage extends StatelessWidget {
  const SimmerPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerPage(),
      appBar: MyTheme.appBar(
        "Produk / Barang",
        [
          GestureDetector(
            child: const Icon(Icons.refresh_rounded),
          ),
          const SizedBox(
            width: 20,
          ),
          GestureDetector(
            onTap: () => Navigator.of(context).pushNamed(Routes.ADD_PRODUCT),
            child: const Icon(Icons.add),
          ),
          const SizedBox(
            width: 20,
          ),
        ],
      ),
      body: ListView(
        children: const [
          SizedBox(
            height: 20,
          ),
          SearchWidget(),
          SizedBox(
            height: 30,
          ),
          ShimmerLoading(),
        ],
      ),
    );
  }
}
