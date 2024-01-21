import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:garing_bakery_apk/core/models/categories_model.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class CategoryBox extends StatelessWidget {
  CategoryModel category;
  CategoryBox({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        right: 20,
      ),
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        image: DecorationImage(
          image: CachedNetworkImageProvider(category.image),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: const Color.fromARGB(135, 0, 0, 0),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  category.name,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  "2 produk",
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 10,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
