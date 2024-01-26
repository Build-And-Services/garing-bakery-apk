import 'package:flutter/material.dart';
import 'package:garing_bakery_apk/core/config/theme.dart';
import 'package:garing_bakery_apk/core/routes/app.dart';
import 'package:garing_bakery_apk/features/category/presenter/provider/category_provider.dart';
import 'package:garing_bakery_apk/features/category/presenter/widgets/category_box_item.dart';
import 'package:garing_bakery_apk/core/widgets/drawer_widget.dart';
import 'package:garing_bakery_apk/core/widgets/search_widget.dart';
import 'package:garing_bakery_apk/features/category/presenter/widgets/category_box_item_shimmer.dart';
import 'package:provider/provider.dart';

class CategorySubPage extends StatelessWidget {
  const CategorySubPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerPage(),
      appBar: MyTheme.appBar("Kategori", [
        GestureDetector(
          onTap: () => Navigator.of(context).pushNamed(Routes.ADD_CATEGORY),
          child: const Icon(Icons.add),
        ),
        const SizedBox(
          width: 20,
        ),
      ]),
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
            child: Consumer<CategoryProvider>(
              builder: (context, category, child) {
                if (category.isLoading) {
                  category.getCategories();
                  return const CategoryShimmerPage();
                }
                return GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1,
                  ),
                  itemCount: category.categories.length,
                  itemBuilder: (context, index) {
                    return CategoryBoxItem(
                      id: category.categories[index].id,
                      image: category.categories[index].image,
                      name: category.categories[index].name,
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class CategoryShimmerPage extends StatelessWidget {
  const CategoryShimmerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1,
      ),
      itemCount: 6,
      itemBuilder: (context, index) {
        return const CategoryBoxItemShimmer();
      },
    );
  }
}
