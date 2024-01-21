import 'package:flutter/material.dart';
import 'package:garing_bakery_apk/core/config/theme.dart';
import 'package:garing_bakery_apk/core/routes/app.dart';
import 'package:garing_bakery_apk/core/widgets/drawer_widget.dart';
import 'package:garing_bakery_apk/core/widgets/search_widget.dart';
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
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  child: _builderGridview(productProvider, context),
                ),
              ),
            ],
          ),
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
          tap: () => {
            QuickAlert.show(
              onCancelBtnTap: () {
                Navigator.pop(context);
              },
              onConfirmBtnTap: () {
                productProvider.delete(product.id).then((value) {
                  Navigator.pop(context);
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
            )
          },
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
