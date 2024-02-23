import 'package:flutter/material.dart';
import 'package:garing_bakery_apk/core/config/theme.dart';
import 'package:garing_bakery_apk/core/routes/app.dart';
import 'package:garing_bakery_apk/core/widgets/drawer_widget.dart';
import 'package:google_fonts/google_fonts.dart';

class ReportsPage extends StatelessWidget {
  const ReportsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerPage(),
      appBar: AppBar(
        title: const Text(
          'Laporan',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: MyTheme.primary,
      ),
      body: Container(
        margin: const EdgeInsets.only(
          top: 20,
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
        ),
        child: ListView(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTileReport(
              icon: Icons.card_travel,
              title: "Laporan Penjualan",
              tap: () => Navigator.of(context).pushNamed(
                Routes.REPORTS_SALES,
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Divider(),
            ),
            ListTileReport(
              icon: Icons.production_quantity_limits,
              title: "Laporan Penjualan Per Barang",
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Divider(),
            ),
            ListTileReport(
              icon: Icons.inventory_outlined,
              title: "Laporan Persediaan",
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Divider(),
            ),
          ],
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class ListTileReport extends StatelessWidget {
  String title;
  IconData icon;
  Function()? tap;

  ListTileReport({
    super.key,
    required this.title,
    required this.icon,
    this.tap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: tap,
      leading: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Icon(
          icon,
          color: MyTheme.primary,
        ),
      ),
      title: Text(
        title,
        style: GoogleFonts.poppins(
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
