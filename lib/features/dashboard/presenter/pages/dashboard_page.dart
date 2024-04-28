import 'package:flutter/material.dart';
import 'package:garing_bakery_apk/core/config/theme.dart';
import 'package:garing_bakery_apk/core/routes/app.dart';
import 'package:garing_bakery_apk/features/profile/presenter/pages/profile_page.dart';
import 'package:garing_bakery_apk/features/transaction/presenter/pages/history/transactions.dart';
import 'package:garing_bakery_apk/features/category/presenter/pages/category_sub_page.dart';
import 'package:garing_bakery_apk/features/dashboard/presenter/pages/sub_page/home.dart';
import 'package:garing_bakery_apk/features/product/presenter/pages/product_sub_page.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int _selectedTab = 0;

  final List _pages = [
    const HomeSubPage(),
    const ProductSubPage(),
    const CartSubPage(),
    const CategorySubPage(),
    const ProfileSubPage(),
  ];

  _changeTab(int index) {
    setState(() {
      _selectedTab = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedTab],
      floatingActionButton: _selectedTab == 0 || _selectedTab == 2
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
        currentIndex: _selectedTab,
        onTap: (index) => _changeTab(index),
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
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profiles"),
        ],
      ),
    );
  }
}
