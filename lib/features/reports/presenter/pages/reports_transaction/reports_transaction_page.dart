import 'package:flutter/material.dart';
import 'package:garing_bakery_apk/core/config/theme.dart';
import 'package:garing_bakery_apk/core/models/arguments/ArgumentReportTransaction.dart';
import 'package:garing_bakery_apk/core/routes/app.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share_plus/share_plus.dart';

class ReportsTransactionPage extends StatelessWidget {
  const ReportsTransactionPage({super.key});

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
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
          'Laporan Transaksi',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          padding: const EdgeInsets.all(
            20,
          ),
          // height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              ListTileReportTransaction(
                title: "Laporan Transaksi Per Hari Ini",
                action: () {
                  Navigator.of(context).pushNamed(
                    Routes.REPORTS_PER_TRANSACTIONS,
                    arguments: ArgumentReportTransaction(
                      now.day.toString(),
                      now.month.toString(),
                      now.year.toString(),
                    ),
                  );
                },
              ),
              ListTileReportTransaction(
                title: "Laporan Transaksi Per Bulan Ini",
                action: () {
                  Navigator.of(context).pushNamed(
                    Routes.REPORTS_PER_TRANSACTIONS,
                    arguments: ArgumentReportTransaction(
                      '',
                      now.month.toString(),
                      now.year.toString(),
                    ),
                  );
                },
              ),
              ListTileReportTransaction(
                title: "Laporan Transaksi Per Tahun Ini",
                action: () {
                  Navigator.of(context).pushNamed(
                    Routes.REPORTS_PER_TRANSACTIONS,
                    arguments: ArgumentReportTransaction(
                      '',
                      '',
                      now.year.toString(),
                    ),
                  );
                },
              ),
              ListTileReportTransaction(
                title: "Laporan Semua Transaksi",
                action: () {
                  Navigator.of(context).pushNamed(
                    Routes.REPORTS_PER_TRANSACTIONS,
                    arguments: ArgumentReportTransaction(
                      '',
                      '',
                      '',
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ListTileReportTransaction extends StatelessWidget {
  const ListTileReportTransaction({
    super.key,
    required this.title,
    required this.action,
  });

  final String title;
  final Function() action;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: action,
      child: Container(
        margin: const EdgeInsets.only(
          bottom: 10,
        ),
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          border: Border.all(
            color: MyTheme.brown,
            width: 1,
            style: BorderStyle.solid,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.all(20),
        child: Text(
          title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: MyTheme.brown,
          ),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
