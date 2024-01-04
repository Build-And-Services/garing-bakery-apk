import 'package:flutter/material.dart';
import 'package:garing_bakery_apk/core/config/theme.dart';
import 'package:garing_bakery_apk/core/routes/app.dart';
import 'package:garing_bakery_apk/features/auth/presenter/provider/auth_provider.dart';
import 'package:garing_bakery_apk/features/dashboard/presenter/pages/sub_page/cart.dart';
import 'package:garing_bakery_apk/features/dashboard/presenter/pages/sub_page/category.dart';
import 'package:garing_bakery_apk/features/dashboard/presenter/pages/sub_page/home.dart';
import 'package:garing_bakery_apk/features/dashboard/presenter/pages/sub_page/product.dart';
import 'package:garing_bakery_apk/features/dashboard/presenter/pages/sub_page/profile.dart';
import 'package:provider/provider.dart';

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
      drawer: Drawer(
        child: Column(
          children: [
            DrawerHeader(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: const BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.all(
                        Radius.circular(100),
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Perdana Putro"),
                        Text("Owner"),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
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
      body: _pages[_selectedTab],
      floatingActionButton: FloatingActionButton(
        backgroundColor: MyTheme.primary,
        onPressed: () {
          Navigator.of(context).pushNamed(Routes.TRANSACTIONS);
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
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
