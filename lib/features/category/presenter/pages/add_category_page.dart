import 'dart:io';

import 'package:flutter/material.dart';
import 'package:garing_bakery_apk/core/config/theme.dart';
import 'package:garing_bakery_apk/core/widgets/button_widget.dart';
import 'package:garing_bakery_apk/core/widgets/input_widget.dart';
import 'package:garing_bakery_apk/features/category/presenter/provider/category_provider.dart';
import 'package:garing_bakery_apk/features/product/presenter/provider/form_provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class AddCategoryPage extends StatefulWidget {
  const AddCategoryPage({super.key});

  @override
  State<AddCategoryPage> createState() => _AddCategoryPageState();
}

class _AddCategoryPageState extends State<AddCategoryPage> {
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
          'Tambah Kategori',
          style: TextStyle(color: MyTheme.primary, fontWeight: FontWeight.w700),
        ),
      ),
      body: Consumer2<FormProductProvider, CategoryProvider>(
        builder: (context, formProduct, category, child) {
          if (category.isLoading) {
            category.getCategories();
          }
          return Form(
            key: _formKey,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: Column(
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
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 60,
                    child: ButtonWidget(
                      title: !category.proccess
                          ? Text(
                              "Tambah Barang",
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
                      tap: () async {
                        if (_formKey.currentState!.validate()) {
                          final image = formProduct.image;

                          if (image != null) {
                            category.isProccess = true;

                            await category.addCategory(
                                formProduct.body, image.path);
                            category.isProccess = false;

                            if (category.responseAdd.success) {
                              // ignore: use_build_context_synchronously
                              MyTheme.alertSucces(
                                  context, category.responseAdd.message);
                            } else {
                              // ignore: use_build_context_synchronously
                              MyTheme.alertWarning(
                                  context, category.responseAdd.message);
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
