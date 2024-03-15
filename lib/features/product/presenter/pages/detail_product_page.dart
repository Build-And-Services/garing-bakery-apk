import 'package:flutter/material.dart';
import 'package:garing_bakery_apk/core/config/theme.dart';
import 'package:garing_bakery_apk/core/models/products_model.dart';
import 'package:garing_bakery_apk/core/widgets/loading_widget.dart';
import 'package:garing_bakery_apk/core/widgets/no_data_widget.dart';
import 'package:garing_bakery_apk/core/widgets/problem_get_widget.dart';
import 'package:garing_bakery_apk/features/product/presenter/provider/product_provider.dart';
import 'package:garing_bakery_apk/features/product/presenter/widgets/main_detail_widget.dart';
import 'package:provider/provider.dart';

class DetailProductPage extends StatelessWidget {
  final String id;

  const DetailProductPage({
    super.key,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    // provider
    ProductProvider productProvider = context.read<ProductProvider>();
    return Scaffold(
      appBar: MyTheme.secondaryAppBar('Detail Barang', context),
      body: SingleChildScrollView(
        child: FutureBuilder<ProductModel>(
            future: productProvider.getProductBy(id),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const LoadingWidget();
              }
              if (snapshot.hasError) {
                return const ProblemWidget();
              }
              if (!snapshot.hasData) {
                return const NoDataWidget();
              }
              if (snapshot.data == null) {
                return const NoDataWidget();
              }

              return MainDetailProductWidget(
                products: snapshot.data!,
                id: id,
              );
            }),
      ),
    );
  }
}
