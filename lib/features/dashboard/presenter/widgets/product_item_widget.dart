import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductCardItem extends StatelessWidget {
  const ProductCardItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color.fromARGB(255, 232, 232, 232),
      shadowColor: Colors.black12,
      borderOnForeground: true,
      semanticContainer: true,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            height: 150,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
              image: DecorationImage(
                image: AssetImage('assets/product.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          Text(
                            "Product 1",
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const Text("Roti Basah"),
                        ],
                      ),
                      Text(
                        "200",
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: const Color.fromARGB(255, 32, 138, 35),
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("harga: "),
                      Text("Rp. 10.000"),
                    ],
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
