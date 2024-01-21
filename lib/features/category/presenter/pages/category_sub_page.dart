import 'package:flutter/material.dart';
import 'package:garing_bakery_apk/core/config/theme.dart';
import 'package:garing_bakery_apk/features/category/presenter/provider/category_provider.dart';
import 'package:garing_bakery_apk/features/category/presenter/widgets/category_box_item.dart';
import 'package:garing_bakery_apk/core/widgets/drawer_widget.dart';
import 'package:garing_bakery_apk/core/widgets/search_widget.dart';
import 'package:provider/provider.dart';

class CategorySubPage extends StatelessWidget {
  const CategorySubPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerPage(),
      appBar: MyTheme.appBar("Kategori", []),
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
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1,
              ),
              itemCount: 2,
              itemBuilder: (context, index) {
                return const CategoryBoxItem();
              },
            ),
          ),
        ],
      ),
    );
  }
}

// Consumer<CategoryProvider>(builder = (context, category, child) {
//               return GridView(
//                 physics: const NeverScrollableScrollPhysics(),
//                 shrinkWrap: true,
//                 gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                   crossAxisCount: 2,
//                   childAspectRatio: 1,
//                 ),
//                 children: const [
//                   CategoryBoxItem(),
//                   CategoryBoxItem(),
//                   CategoryBoxItem(),
//                   CategoryBoxItem(),
//                   CategoryBoxItem(),
//                   CategoryBoxItem(),
//                   CategoryBoxItem(),
//                 ],
//               );
//             })
