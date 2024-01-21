import 'package:flutter/material.dart';
import 'package:garing_bakery_apk/core/config/theme.dart';
import 'package:garing_bakery_apk/core/helpers/format_rupiah.dart';
import 'package:google_fonts/google_fonts.dart';

class ReportsSalesPage extends StatelessWidget {
  const ReportsSalesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: MyTheme.primary,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Laporan Penjualan',
          style: TextStyle(color: MyTheme.primary, fontWeight: FontWeight.w700),
        ),
      ),
      body: Container(
        color: const Color.fromARGB(255, 251, 232, 226),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 20,
            ),
            Text(
              "Laporan Keseluruhan",
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              "21 Januari 2024",
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: Colors.grey,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            BoxInforReport(
              value: "100",
              label: "Jumlah Transaksi",
            ),
            BoxInforReport(
              value: formatRupiah(100000000),
              label: "Jumlah Penghasilan",
            ),
          ],
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class BoxInforReport extends StatelessWidget {
  String value;
  String label;
  BoxInforReport({
    super.key,
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 10,
      ),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        border: Border.all(
          color: MyTheme.primary,
          width: 1,
          style: BorderStyle.solid,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          labelnfoReport(),
          Container(
            padding: const EdgeInsets.all(
              10,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  value,
                  style: GoogleFonts.poppins(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  label,
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Container labelnfoReport() {
    return Container(
      width: 40,
      height: 80,
      decoration: const BoxDecoration(
        color: MyTheme.primary,
      ),
      child: Center(
        child: Text(
          "=",
          style: GoogleFonts.poppins(
            fontSize: 18,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
