import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:garing_bakery_apk/core/config/theme.dart';
import 'package:garing_bakery_apk/core/helpers/format_rupiah.dart';
import 'package:garing_bakery_apk/core/models/products_model.dart';
import 'package:garing_bakery_apk/core/routes/app.dart';
import 'package:garing_bakery_apk/core/widgets/shimmer/wrapper_shimmer_widget.dart';
import 'package:garing_bakery_apk/features/product/data/model/response_product.dart';
import 'package:garing_bakery_apk/features/product/data/service/product_service.dart';
import 'package:garing_bakery_apk/features/product/presenter/widgets/button_detail_widget.dart';
import 'package:google_fonts/google_fonts.dart';

class DetailProductPage extends StatelessWidget {
  final String id;

  const DetailProductPage({
    super.key,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyTheme.secondaryAppBar('Detail Barang', context),
      body: SingleChildScrollView(
        child: FutureBuilder<ProductResponse>(
            future: ProductService.getProductById(id),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }
              if (snapshot.hasError) {
                return const Center(
                  child: Text("Something went wrong!, check your connection"),
                );
              }
              if (!snapshot.hasData) {
                return const Center(
                  child: Text("Data tidak ada"),
                );
              }
              final ProductModel? product = snapshot.data?.data;
              if (product == null) {
                return const Center(
                  child: Text("Data tidak ada"),
                );
              }

              return MainDetailProductWidget(
                product: product,
                id: id,
              );
            }),
      ),
    );
  }
}

class MainDetailProductWidget extends StatefulWidget {
  const MainDetailProductWidget({
    super.key,
    required this.product,
    required this.id,
  });

  final ProductModel product;
  final String id;

  @override
  State<MainDetailProductWidget> createState() =>
      _MainDetailProductWidgetState();
}

class _MainDetailProductWidgetState extends State<MainDetailProductWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        imageMethod(),
        Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              descriptionMethod(),
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
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8.0))),
                          contentPadding: const EdgeInsets.only(top: 10.0),
                          content: SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: const FormEditStockWidget(),
                          ),
                        );
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
  CachedNetworkImage imageMethod() {
    return CachedNetworkImage(
      imageUrl: widget.product.image,
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
  Column descriptionMethod() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.product.name,
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
          "Harga Jual ${formatRupiah(widget.product.sellingPrice)}",
          style: GoogleFonts.poppins(
            fontSize: 14.sp,
            color: Colors.grey,
            fontWeight: FontWeight.w600,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        Text(
          "Harga Dasar ${formatRupiah(widget.product.purchasePrice)}",
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
                    widget.product.productCode,
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
                    widget.product.quantity.toString(),
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
                    widget.product.category ?? "Null category",
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

class FormEditStockWidget extends StatefulWidget {
  const FormEditStockWidget({
    super.key,
  });

  @override
  State<FormEditStockWidget> createState() => _FormEditStockWidgetState();
}

class _FormEditStockWidgetState extends State<FormEditStockWidget> {
  TypeStock typeStock = TypeStock.increase;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                "Manajemen Stok",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.sp,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 5.0,
          ),
          const Divider(
            color: Colors.grey,
            height: 4.0,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30.0, right: 30.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Row(
                      children: [
                        Radio<TypeStock>(
                          value: TypeStock.increase,
                          groupValue: typeStock,
                          onChanged: (value) {
                            setState(() {
                              typeStock = TypeStock.increase;
                            });
                          },
                        ),
                        const Text('Tambah')
                      ],
                    ),
                    Row(
                      children: [
                        Radio<TypeStock>(
                          value: TypeStock.decrease,
                          groupValue: typeStock,
                          onChanged: (value) {
                            setState(() {
                              typeStock = TypeStock.decrease;
                            });
                          },
                        ),
                        const Text('Kurang')
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Jumlah'),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 5.0,
                          horizontal: 10.0,
                        ),
                        labelText: "Jumlah",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
          const Divider(
            color: Colors.grey,
            height: 4.0,
          ),
          Padding(
            padding: EdgeInsets.only(
              left: 30.0.sp,
              right: 30.0.sp,
              bottom: 10.sp,
              top: 10.sp,
            ),
            child: IntrinsicHeight(
              child: Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        'BATAL',
                        style: GoogleFonts.poppins(
                          color: MyTheme.brown,
                          fontWeight: FontWeight.bold,
                          fontSize: 16.sp,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  VerticalDivider(
                    thickness: 2.sp,
                    color: Colors.grey,
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Processing Data'),
                            ),
                          );
                          Navigator.pop(context);
                          Future.delayed(const Duration(seconds: 10), () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'Berhasil diedit stock',
                                ),
                                backgroundColor: Colors.green,
                              ),
                            );
                          });
                        }
                      },
                      child: Text(
                        'SIMPAN',
                        style: GoogleFonts.poppins(
                          color: MyTheme.brown,
                          fontWeight: FontWeight.bold,
                          fontSize: 16.sp,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
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
