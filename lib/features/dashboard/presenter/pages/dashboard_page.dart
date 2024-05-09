import 'package:flutter/material.dart';
import 'package:garing_bakery_apk/core/config/theme.dart';
import 'package:garing_bakery_apk/core/routes/app.dart';
import 'package:garing_bakery_apk/features/auth/presenter/provider/auth_provider.dart';
import 'package:garing_bakery_apk/features/dashboard/presenter/provider/dashboard_provider.dart';
import 'package:garing_bakery_apk/features/profile/presenter/pages/profile_page.dart';
import 'package:garing_bakery_apk/features/transaction/presenter/pages/history/transactions.dart';
import 'package:garing_bakery_apk/features/category/presenter/pages/category_sub_page.dart';
import 'package:garing_bakery_apk/features/dashboard/presenter/pages/sub_page/home.dart';
import 'package:garing_bakery_apk/features/product/presenter/pages/product_sub_page.dart';
import 'package:provider/provider.dart';

class DashboardPage extends StatelessWidget {
  DashboardPage({super.key});

  final List _pages = [
    const HomeSubPage(),
    const ProductSubPage(),
    const CartSubPage(),
    const CategorySubPage(),
    const ProfileSubPage(),
  ];

  @override
  Widget build(BuildContext context) {
    DashboardProvider dashboardProvider = context.watch<DashboardProvider>();
    final authProvider = context.read<AuthProvider>();
    String? role;
    if (authProvider.userCache != null) {
      role = authProvider.userCache!.role;
    }
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        showDialog<bool>(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Are you sure?'),
              content: const Text(
                'Are you sure you want to leave this page?',
              ),
              actions: <Widget>[
                TextButton(
                  style: TextButton.styleFrom(
                    textStyle: Theme.of(context).textTheme.labelLarge,
                  ),
                  child: const Text('Nevermind'),
                  onPressed: () {
                    Navigator.pop(context, false);
                  },
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    textStyle: Theme.of(context).textTheme.labelLarge,
                  ),
                  child: const Text('Leave'),
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                ),
              ],
            );
          },
        );
        return;
      },
      child: Scaffold(
        body: _pages[dashboardProvider.selectedTab],
        floatingActionButton: role == "admin"
            ? null
            : dashboardProvider.selectedTab == 0 ||
                    dashboardProvider.selectedTab == 2
                ? FloatingActionButton(
                    backgroundColor: MyTheme.primary,
                    onPressed: () {
                      Navigator.of(context).pushNamed(Routes.TRANSACTIONS);
                    },
                    child: const Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                  )
                : null,
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: dashboardProvider.selectedTab,
          onTap: (index) => dashboardProvider.changeTab = index,
          selectedItemColor: MyTheme.primary,
          unselectedItemColor: Colors.grey,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: "Home"),
            BottomNavigationBarItem(
                icon: Icon(Icons.shopping_bag), label: "Produk"),
            BottomNavigationBarItem(
                icon: Icon(Icons.shopping_cart), label: "Transaksi"),
            BottomNavigationBarItem(
                icon: Icon(Icons.category), label: "Kategori"),
            BottomNavigationBarItem(
                icon: Icon(Icons.person), label: "Profiles"),
          ],
        ),
      ),
    );
  }
}
