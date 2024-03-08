import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:garing_bakery_apk/core/config/theme.dart';
import 'package:garing_bakery_apk/core/routes/app.dart';
import 'package:garing_bakery_apk/core/widgets/drawer_widget.dart';
import 'package:garing_bakery_apk/core/widgets/search_widget.dart';
import 'package:garing_bakery_apk/core/widgets/shimmer/wrapper_shimmer_widget.dart';
import 'package:garing_bakery_apk/features/product/presenter/widgets/product_widget.dart';
import 'package:garing_bakery_apk/features/product/presenter/widgets/shimmer_loading.dart';
import 'package:garing_bakery_apk/features/product/presenter/provider/product_provider.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

class ProductSubPage extends StatelessWidget {
  const ProductSubPage({super.key});

  @override
  Widget build(BuildContext context) {
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
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2.0),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                      ),
                      child: _builderGridview(productProvider, context),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _builderGridview(
      ProductProvider productProvider, BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: productProvider.products.length,
      itemBuilder: (context, index) {
        final product = productProvider.products[index];
        // final product = product.products[index];
        final width = MediaQuery.of(context).size.width;
        final height = MediaQuery.of(context).size.height;
        return Card(
          // elevation: 0,
          shadowColor: Colors.black,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CachedNetworkImage(
                imageUrl: product.image,
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
                    width: width > 420 ? width / 3 : width / 5,
                    height: width > 420 ? height / 2.5 : height / 9,
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
              ),
              Container(
                padding: const EdgeInsets.all(20),
                child: const Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Marlong enak",
                          style: TextStyle(
                            fontSize: 10,
                          ),
                        ),
                        Text(
                          "983247983247",
                          style: TextStyle(
                            fontSize: 10,
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "20",
                            style: TextStyle(
                              fontSize: 10,
                            ),
                          ),
                          Text(
                            "Rp. 90.000 - Rp 95.000",
                            style: TextStyle(
                              fontSize: 10,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
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
