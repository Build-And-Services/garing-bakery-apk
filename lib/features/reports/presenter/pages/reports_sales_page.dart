import 'package:flutter/material.dart';
import 'package:garing_bakery_apk/core/config/theme.dart';
import 'package:garing_bakery_apk/core/helpers/format_rupiah.dart';
import 'package:garing_bakery_apk/features/reports/presenter/widgets/box_info_report_widget.dart';
import 'package:garing_bakery_apk/features/reports/presenter/widgets/chart_widget.dart';
import 'package:garing_bakery_apk/features/reports/presenter/widgets/dropdown_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share_plus/share_plus.dart';

class ReportsSalesPage extends StatefulWidget {
  const ReportsSalesPage({super.key});

  @override
  State<ReportsSalesPage> createState() => _ReportsSalesPageState();
}

class _ReportsSalesPageState extends State<ReportsSalesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyTheme.primary,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          PopupMenuButton(
            itemBuilder: (_) => [
              const PopupMenuItem(
                value: 'Import',
                child: Text('Import Excel'),
              ),
              const PopupMenuItem(
                value: 'Share',
                child: Text('Share Excel'),
              ),
            ],
            onSelected: (value) async {
              if (value == 'Share') {
                await Share.share('check out my website https://example.com');
              }
            },
          ),
        ],
        title: const Text(
          'Laporan Penjualan',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: const Color.fromARGB(255, 255, 247, 238),
          width: MediaQuery.of(context).size.width,
          // height: MediaQuery.of(context).size.height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 20,
              ),
              const DropdownWidget(),
              const SizedBox(
                height: 20,
              ),
              Text(
                "Laporan Keseluruhan",
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              BoxInforReport(
                value: "100",
                label: "Jumlah Transaksi",
              ),
              BoxInforReport(
                value: formatRupiah(100000000),
                label: "Keuntungan",
              ),
              BoxInforReport(
                value: formatRupiah(100000000),
                label: "Pendapatan",
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                "Laporan Penjualan per Jam",
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              ChartWidget()
            ],
          ),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
