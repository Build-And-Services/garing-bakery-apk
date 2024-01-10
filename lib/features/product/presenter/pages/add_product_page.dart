import 'package:flutter/material.dart';
import 'package:garing_bakery_apk/core/config/theme.dart';
import 'package:garing_bakery_apk/core/widgets/input_widget.dart';
import 'package:garing_bakery_apk/features/product/presenter/provider/product_provider.dart';
import 'package:provider/provider.dart';

class AddProductPage extends StatelessWidget {
  const AddProductPage({super.key});

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
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(
            horizontal: 20,
          ),
          child: Consumer<ProductProvider>(
            builder: (context, value, child) {
              return Form(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: 120,
                      height: 120,
                      decoration: const BoxDecoration(
                          color: Color.fromARGB(161, 121, 85, 72),
                          borderRadius: BorderRadius.all(
                            Radius.circular(
                              10,
                            ),
                          )),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
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
                          child: const Icon(
                            Icons.image_outlined,
                            size: 30,
                            color: MyTheme.primary,
                          ),
                        )
                      ],
                    ),
                    InputWidget(
                      label: "nama",
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                          child: InputWidget(
                            label: "stok",
                            type: "number",
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Flexible(
                          child: InputWidget(
                            label: "kode",
                            add: GestureDetector(
                              child: const Icon(
                                Icons.add,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Flexible(
                          child: InputWidget(
                              prefixText: "Rp",
                              label: "harga dasar",
                              type: "number"),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Flexible(
                          child: InputWidget(
                            prefixText: "Rp",
                            label: "harga jual",
                            type: "number",
                          ),
                        ),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Flexible(
                          child: InputWidget(
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
                    )
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
