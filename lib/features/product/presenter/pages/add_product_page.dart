import 'dart:io';

import 'package:flutter/material.dart';
import 'package:garing_bakery_apk/core/config/theme.dart';
import 'package:garing_bakery_apk/core/widgets/button_widget.dart';
import 'package:garing_bakery_apk/core/widgets/input_widget.dart';
import 'package:garing_bakery_apk/features/product/presenter/provider/form_provider.dart';
import 'package:garing_bakery_apk/features/product/presenter/provider/product_provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

class AddProductPage extends StatefulWidget {
  const AddProductPage({super.key});

  @override
  State<AddProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  void didChangeDependencies() {
    final myFormProvider =
        Provider.of<FormProductProvider>(context, listen: false);
    myFormProvider.clearController();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: MyTheme.primary,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Tambah Barang',
          style: TextStyle(color: MyTheme.primary, fontWeight: FontWeight.w700),
        ),
      ),
      body: Consumer2<ProductProvider, FormProductProvider>(
        builder: (context, product, formProduct, child) {
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
                            _imagePreview(formProduct, context),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        logoImage(formProduct),
                        sectionName(formProduct),
                        sectionMore(formProduct),
                        sectionPrice(formProduct),
                        // sectionCategory(formProduct),
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
                            "Tambah Barang",
                            style: GoogleFonts.poppins(
                              fontSize: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          )
                        : const Center(
                            child: CircularProgressIndicator(),
                          ),
                    tap: () async {
                      if (_formKey.currentState!.validate()) {
                        product.setLoading = true;
                        final image = formProduct.image;
                        if (image != null) {
                          product.isProccess = true;
                          await product.addProduct(
                              formProduct.body, image.path);
                          product.isProccess = false;

                          if (product.responseAdd.success) {
                            // ignore: use_build_context_synchronously
                            MyTheme.alertSucces(
                                context, product.responseAdd.message);
                          } else {
                            // ignore: use_build_context_synchronously
                            MyTheme.alertWarning(
                                context, product.responseAdd.message);
                          }
                        } else {
                          MyTheme.alertWarning(
                              context, "Gambar belum dimasukan");
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
              child: const Icon(
                Icons.add,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Row sectionCategory(FormProductProvider formProduct) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Flexible(
          child: InputWidget(
            controller: formProduct.category,
            validate: formProduct.validateSelect,
            label: "kategori",
            type: "select",
            add: GestureDetector(
              child: const Icon(
                Icons.add,
              ),
            ),
          ),
        ),
      ],
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

  InkWell _imagePreview(FormProductProvider formProduct, BuildContext context) {
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
        child: formProduct.image == null
            ? const Icon(
                Icons.upload_file_outlined,
                size: 70,
                color: MyTheme.primary,
              )
            : Image.file(
                //to show image, you type like this.
                File(formProduct.image!.path),
                fit: BoxFit.cover,
                width: MediaQuery.of(context).size.width,
                height: 300,
              ),
      ),
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
