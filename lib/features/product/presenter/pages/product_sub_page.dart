import 'package:flutter/material.dart';
import 'package:garing_bakery_apk/core/config/theme.dart';
import 'package:garing_bakery_apk/core/routes/app.dart';
import 'package:garing_bakery_apk/core/widgets/drawer_widget.dart';
import 'package:garing_bakery_apk/core/widgets/search_widget.dart';
import 'package:garing_bakery_apk/features/product/presenter/widgets/product_widget.dart';
import 'package:garing_bakery_apk/features/product/presenter/widgets/shimmer_loading.dart';
import 'package:garing_bakery_apk/features/product/presenter/provider/product_provider.dart';
import 'package:provider/provider.dart';

class ProductSubPage extends StatelessWidget {
  const ProductSubPage({super.key});

  @override
  Widget build(BuildContext context) {
    final productProvider = context.read<ProductProvider>();
    return Scaffold(
      drawer: const DrawerPage(),
      appBar: MyTheme.appBar(
        "Produk / Barang",
        [
          GestureDetector(
            onTap: () async {},
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
            child: _buildFutureProduct(productProvider, context),
          )
        ],
      ),
    );
  }

  FutureBuilder<dynamic> _buildFutureProduct(
      ProductProvider productProvider, BuildContext context) {
    return FutureBuilder(
      future: productProvider.getProduct(),
      builder: (_, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const ShimmerLoading();
        }

        return Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
          ),
          child: _builderGridview(productProvider, context),
        );
      },
    );
  }

  GridView _builderGridview(
      ProductProvider productProvider, BuildContext context) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: MediaQuery.of(context).size.width /
            (MediaQuery.of(context).size.height / 1.4),
        mainAxisSpacing: 20.0,
        crossAxisSpacing: 10.0,
      ),
      itemCount: productProvider.products.length,
      itemBuilder: (context, index) {
        final product = productProvider.products[index];
        // final product = product.products[index];
        return ProductCardItem(
          product: product,
        );
      },
    );
  }
}
