import 'package:flutter/material.dart';
import 'package:garing_bakery_apk/core/config/theme.dart';
import 'package:google_fonts/google_fonts.dart';

class CategoryBoxItem extends StatelessWidget {
  const CategoryBoxItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Card(
        surfaceTintColor: Colors.amber,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            image: const DecorationImage(
              image: AssetImage(
                "assets/product.jpg",
              ),
              fit: BoxFit.cover,
            ),
          ),
          child: Center(
            child: Text(
              "Roti Basah",
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.w800,
                color: const Color.fromARGB(255, 195, 148, 131),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
