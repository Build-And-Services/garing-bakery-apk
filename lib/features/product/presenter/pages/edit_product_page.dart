import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:garing_bakery_apk/core/config/theme.dart';
import 'package:garing_bakery_apk/core/models/products_model.dart';
import 'package:garing_bakery_apk/core/widgets/button_widget.dart';
import 'package:garing_bakery_apk/core/widgets/input_widget.dart';
import 'package:garing_bakery_apk/features/category/presenter/provider/category_provider.dart';
import 'package:garing_bakery_apk/features/product/presenter/provider/form_provider.dart';
import 'package:garing_bakery_apk/features/product/presenter/provider/product_provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:select_form_field/select_form_field.dart';

class EditProductPage extends StatefulWidget {
  final String id;

  const EditProductPage({
    super.key,
    required this.id,
  });

  @override
  State<EditProductPage> createState() => _EditProductPageState();
}

class _EditProductPageState extends State<EditProductPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final product = context.read<ProductProvider>();
    final formProduct = context.read<FormProductProvider>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: MyTheme.primary,
          ),
          onPressed: () {
            formProduct.clearController();
            Navigator.of(context).pop();
          },
        ),
        title: const Text(
          'Edit Barang',
          style: TextStyle(
            color: MyTheme.primary,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: FutureBuilder<ProductModel>(
        future: product.getProductBy(widget.id),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return const Center(
              child: Text("Terjadi Kesalahan silakan reload aplikasi"),
            );
          }
          final productModel = snapshot.data;
          if (productModel == null) {
            return const Center(
              child: Text("Terjadi Kesalahan silakan reload aplikasi"),
            );
          }
          formProduct.name.text = productModel.name;
          formProduct.stock.text = productModel.quantity.toString();
          formProduct.code.text = productModel.productCode;
          formProduct.purchase.text = productModel.purchasePrice.toString();
          formProduct.selling.text = productModel.sellingPrice.toString();
          if (productModel.category != null) {
            formProduct.category.text = productModel.category!;
          }

          return Form(
            key: _formKey,
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 20,
                    ),
                    child: ListView(
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ImagesPreview(productModel: productModel),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        logoImage(formProduct),
                        sectionName(formProduct),
                        sectionMore(formProduct),
                        sectionPrice(formProduct),
                        sectionCategory(formProduct, context),
                      ],
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 80,
                  color: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    vertical: 15,
                    horizontal: 20,
                  ),
                  child: ButtonWidget(
                    title: !product.isLoading
                        ? Text(
                            "Update Barang",
                            style: GoogleFonts.poppins(
                              fontSize: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          )
                        : const Center(
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          ),
                    tap: () {
                      if (_formKey.currentState!.validate()) {
                        // product.setLoading = true;
                        final image = formProduct.image;

                        if (image != null) {
                          // product.isProccess = true;
                          formProduct.editData(widget.id).then((value) {
                            if (value.success) {
                              print(value.data);
                              MyTheme.alertSucces(context, value.message);
                            } else {
                              MyTheme.alertError(context, value.message);
                            }
                          });
                        } else {
                          MyTheme.alertWarning(
                            context,
                            "Gambar belum dimasukan",
                          );
                        }
                      }
                    },
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }

  InputWidget sectionName(FormProductProvider formProduct) {
    return InputWidget(
      label: "nama",
      controller: formProduct.name,
      validate: formProduct.validateName,
    );
  }

  Row sectionMore(FormProductProvider formProduct) {
    Future scanBarcode() async {
      String barcodeScanRes;
      try {
        barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
            '#ff6666', 'Cancel', true, ScanMode.BARCODE);
      } on PlatformException {
        barcodeScanRes = 'Failed to get platform version.';
      }
      formProduct.code.text = barcodeScanRes;
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(
          child: InputWidget(
            label: "stok",
            type: "number",
            controller: formProduct.stock,
            validate: formProduct.validateNumber,
          ),
        ),
        const SizedBox(
          width: 20,
        ),
        Flexible(
          child: InputWidget(
            label: "kode",
            controller: formProduct.code,
            validate: formProduct.validateNumber,
            add: GestureDetector(
              onTap: scanBarcode,
              child: const Icon(
                Icons.qr_code_scanner,
              ),
            ),
          ),
        ),
      ],
    );
  }

  FutureBuilder sectionCategory(
    FormProductProvider formProduct,
    BuildContext context,
  ) {
    final category = context.read<CategoryProvider>();

    return FutureBuilder(
      future: category.getCategories(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Container(
            margin: const EdgeInsets.symmetric(
              vertical: 20,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Kategori",
                  style: GoogleFonts.poppins(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Flexible(
                      child: SelectFormField(
                        controller: formProduct.category,
                        validator: formProduct.validateSelect,
                        type: SelectFormFieldType.dialog,
                        labelText: 'kategori',
                        changeIcon: true,
                        dialogTitle: 'pilih kategori',
                        dialogCancelBtn: 'CANCEL',
                        enableSearch: true,
                        dialogSearchHint: 'Search item',
                        items: category.items,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(
                                50,
                              ),
                            ),
                            borderSide: BorderSide(
                              color: MyTheme.primary,
                              width: 1,
                              style: BorderStyle.solid,
                            ),
                          ),
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 15,
                          ),
                          suffixIcon: Icon(
                            Icons.arrow_drop_down,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        }

        return const SizedBox();
      },
    );
  }

  Row sectionPrice(FormProductProvider formProduct) {
    return Row(
      children: [
        Flexible(
          child: InputWidget(
              controller: formProduct.purchase,
              validate: formProduct.validateNumber,
              prefixText: "Rp",
              label: "harga dasar",
              type: "number"),
        ),
        const SizedBox(
          width: 20,
        ),
        Flexible(
          child: InputWidget(
            controller: formProduct.selling,
            validate: formProduct.validateNumber,
            prefixText: "Rp",
            label: "harga jual",
            type: "number",
          ),
        ),
      ],
    );
  }

  Row logoImage(FormProductProvider formProduct) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () => formProduct.getImage(ImageSource.camera),
          child: const Icon(
            Icons.photo_camera_outlined,
            size: 30,
            color: MyTheme.primary,
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        GestureDetector(
          onTap: () => formProduct.getImage(ImageSource.gallery),
          child: const Icon(
            Icons.image_outlined,
            size: 30,
            color: MyTheme.primary,
          ),
        )
      ],
    );
  }
}

class ImagesPreview extends StatelessWidget {
  const ImagesPreview({
    super.key,
    required this.productModel,
  });
  final ProductModel productModel;

  @override
  Widget build(BuildContext context) {
    final formProduct = context.watch<FormProductProvider>();
    if (formProduct.image == null) {
      formProduct.setImage(productModel.image);
    }
    return InkWell(
      onTap: () => formProduct.getImage(ImageSource.gallery),
      child: Container(
        height: 100,
        width: 100,
        decoration: const BoxDecoration(
          color: Color.fromARGB(161, 121, 85, 72),
          borderRadius: BorderRadius.all(
            Radius.circular(
              10,
            ),
          ),
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.all(
            Radius.circular(
              10,
            ),
          ),
          child: formProduct.image != null
              ? Image.file(
                  //to show image, you type like this.
                  File(formProduct.image!.path),
                  fit: BoxFit.cover,
                  width: MediaQuery.of(context).size.width,
                  height: 300,
                )
              // ignore: unnecessary_null_comparison
              : productModel.image != null
                  ? Image.network(
                      productModel.image,
                      fit: BoxFit.cover,
                      width: MediaQuery.of(context).size.width,
                      height: 300,
                    )
                  : const Icon(
                      Icons.upload_file_outlined,
                      size: 70,
                      color: MyTheme.primary,
                    ),
        ),
      ),
    );
  }
}
