import 'package:flutter/material.dart';
import 'package:garing_bakery_apk/features/category/presenter/provider/category_provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:select_form_field/select_form_field.dart';

import 'package:garing_bakery_apk/core/config/theme.dart';

// ignore: must_be_immutable
class InputWidget extends StatelessWidget {
  String label;
  String? placeholder;
  String? prefixText;
  TextEditingController? controller;
  String? type;
  List<Map<String, dynamic>>? items;
  Widget? add;
  String? Function(String?)? validate;
  InputWidget({
    Key? key,
    required this.label,
    this.placeholder,
    this.prefixText,
    this.type = "text",
    this.items,
    this.add,
    this.controller,
    this.validate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        top: 20,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: GoogleFonts.poppins(
              fontSize: 15,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            children: [
              type != "select"
                  ? Flexible(
                      child: TextFormField(
                        controller: controller,
                        validator: validate,
                        keyboardType: type == "text"
                            ? TextInputType.text
                            : TextInputType.number,
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(
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
                          prefix: Container(
                            margin: const EdgeInsets.only(right: 5),
                            child: Text(prefixText ?? ""),
                          ),
                          hintText: placeholder,
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 15,
                          ),
                        ),
                      ),
                    )
                  : Flexible(
                      child: Consumer<CategoryProvider>(
                        builder: (context, category, child) {
                          if (category.isLoading) {
                            category.getCategories();
                          }
                          return SelectFormField(
                            controller: controller,
                            validator: validate,
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
                          );
                        },
                      ),
                    ),
              if (add != null) ...[
                const SizedBox(
                  width: 10,
                ),
                add!,
              ]
            ],
          )
        ],
      ),
    );
  }
}
