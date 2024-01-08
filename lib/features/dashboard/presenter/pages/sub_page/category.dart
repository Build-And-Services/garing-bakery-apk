import 'package:flutter/material.dart';
import 'package:garing_bakery_apk/core/config/theme.dart';
import 'package:garing_bakery_apk/features/dashboard/presenter/pages/sub_page/product.dart';
import 'package:garing_bakery_apk/features/dashboard/presenter/widgets/drawer_widget.dart';
import 'package:google_fonts/google_fonts.dart';

class CategorySubPage extends StatelessWidget {
  const CategorySubPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerPage(),
      appBar: AppBar(
        title: const Text(
          'Category',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: MyTheme.primary,
      ),
      body: ListView(
        children: [
          const SizedBox(
            height: 20,
          ),
          const SearchWidget(),
          Container(
            margin: const EdgeInsets.only(top: 10),
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
            ),
            child: GridView(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1,
              ),
              children: const [
                CategoryBoxItem(),
                CategoryBoxItem(),
                CategoryBoxItem(),
                CategoryBoxItem(),
                CategoryBoxItem(),
                CategoryBoxItem(),
                CategoryBoxItem(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

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
                color: MyTheme.primary,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
