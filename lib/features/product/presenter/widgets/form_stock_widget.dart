import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:garing_bakery_apk/core/config/theme.dart';
import 'package:garing_bakery_apk/features/product/data/model/request_product.dart';
import 'package:garing_bakery_apk/features/product/presenter/provider/form_edit_stok_provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class FormEditStockWidget extends StatefulWidget {
  const FormEditStockWidget({
    super.key,
    required this.id,
  });

  final String id;

  @override
  State<FormEditStockWidget> createState() => _FormEditStockWidgetState();
}

class _FormEditStockWidgetState extends State<FormEditStockWidget> {
  TypeStock typeStock = TypeStock.increase;
  TextEditingController quantity = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    FormStokProvider formStokProvider =
        Provider.of<FormStokProvider>(context, listen: false);
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
                      keyboardType: TextInputType.number,
                      controller: quantity,
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
                          final body = EditStockRequest(
                            quantity: int.parse(quantity.text),
                            type: typeStock == TypeStock.increase
                                ? 'increase'
                                : 'decrease',
                            productId: int.parse(widget.id),
                          );
                          formStokProvider.setBody = body;
                          Navigator.pop(context);
                          formStokProvider.loading = true;
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
