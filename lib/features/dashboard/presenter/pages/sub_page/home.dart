import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:garing_bakery_apk/core/config/theme.dart';
import 'package:garing_bakery_apk/features/dashboard/presenter/provider/dashboard_provider.dart';
import 'package:garing_bakery_apk/core/widgets/drawer_widget.dart';
import 'package:garing_bakery_apk/features/dashboard/presenter/widgets/category_box_widget.dart';
import 'package:garing_bakery_apk/features/dashboard/presenter/widgets/product_item_widget.dart';
import 'package:garing_bakery_apk/features/profile/presenter/provider/form_profile_provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class HomeSubPage extends StatelessWidget {
  const HomeSubPage({super.key});

  @override
  Widget build(BuildContext context) {
    final dashboardProvider = context.watch<DashboardProvider>();
    final profile = context.read<FormProfileProvider>();
    if (dashboardProvider.loading || profile.userProfile == null) {
      profile.getDataProfile();
      dashboardProvider.getDataDashboard();
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
    return Scaffold(
      drawer: const DrawerPage(),
      appBar: AppBar(
        title: const Text(
          'Dashboard',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: MyTheme.primary,
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          dashboardProvider.setLoading = true;
        },
        child: ListView(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _headerHome(profile.userProfile!.name),
            _textTitle("Semua Kategori", () => dashboardProvider.changeTab = 3),
            const SizedBox(
              height: 20,
            ),
            dashboardProvider.dashboardData.data!.categories.isEmpty
                ? Container(
                    padding: const EdgeInsets.all(
                      20,
                    ),
                    child: const Text('category not found'),
                  )
                : _carouselCategory(dashboardProvider),
            _textTitle("Semua Barang", () => dashboardProvider.changeTab = 1),
            const SizedBox(
              height: 20,
            ),
            _builderGridProduct(dashboardProvider, context),
          ],
        ),
      ),
    );
  }

  Container _builderGridProduct(
      DashboardProvider dashboardProvider, BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
      ),
      child: OrientationBuilder(
        builder: (context, orientation) {
          return GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: w > 480 ? 4 : 2,
              childAspectRatio: w <= 480
                  ? 0.78
                  : w > 480 && w < 788
                      ? 0.7
                      : w > 789
                          ? 0.8
                          : 0.9,
              mainAxisSpacing: 20.0,
              crossAxisSpacing: 10.0,
            ),
            itemCount: dashboardProvider.dashboardData.data?.products.length,
            itemBuilder: (context, index) {
              final product =
                  dashboardProvider.dashboardData.data?.products[index];
              if (product == null) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return ProductCardItem(
                product: product,
              );
            },
          );
        },
      ),
    );
  }

  CarouselSlider _carouselCategory(DashboardProvider dashboardProvider) {
    return CarouselSlider.builder(
      itemCount: dashboardProvider.dashboardData.data?.categories.length,
      itemBuilder: (context, index, realIndex) {
        final category =
            dashboardProvider.dashboardData.data?.categories[index];

        return CategoryBox(
          category: category!,
        );
      },
      options: CarouselOptions(
        height: 100,
        viewportFraction: 0.3,
        aspectRatio: 5.0,
        initialPage: 0,
      ),
    );
  }

  Padding _textTitle(String text, Function() fn) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0, left: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            text,
            style:
                GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w500),
          ),
          TextButton(
            onPressed: fn,
            child: Text(
              "Lihat Semua",
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: MyTheme.primary,
              ),
            ),
          )
        ],
      ),
    );
  }

  Container _headerHome(String role) {
    return Container(
      padding: const EdgeInsets.all(
        20,
      ),
      height: 200,
      width: double.infinity,
      decoration: const BoxDecoration(
        color: MyTheme.primary,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Selamat datang di aplikasi",
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 20,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            "Hallo $role",
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontWeight: FontWeight.w400,
              fontSize: 20,
            ),
          ),
        ],
      ),
    );
  }
}
