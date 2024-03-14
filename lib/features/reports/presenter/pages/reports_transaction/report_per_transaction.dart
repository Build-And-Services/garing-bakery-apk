import 'package:flutter/material.dart';
import 'package:garing_bakery_apk/core/config/theme.dart';
import 'package:garing_bakery_apk/core/models/arguments/ArgumentReportTransaction.dart';
import 'package:garing_bakery_apk/features/reports/presenter/pages/reports_transaction/per/report_all.dart';
import 'package:garing_bakery_apk/features/reports/presenter/pages/reports_transaction/per/report_per_day.dart';
import 'package:garing_bakery_apk/features/reports/presenter/pages/reports_transaction/per/report_per_month_year.dart';
import 'package:share_plus/share_plus.dart';

class ReportPerTransaction extends StatelessWidget {
  const ReportPerTransaction({
    super.key,
    required this.date,
  });
  final ArgumentReportTransaction date;

  @override
  Widget build(BuildContext context) {
    var title = '';
    if (date.date == '' && date.month == '' && date.year != '') {
      title = " Per Tahun";
    } else if (date.date == '' && date.month != '' && date.year != '') {
      title = " Per Bulan";
    } else if (date.date != '' && date.month != '' && date.year != '') {
      title = " Per Hari";
    } else {
      title = " Semua Transaksi";
    }

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
        title: Text(
          'Laporan $title',
          style:
              const TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
        ),
      ),
      body: SingleChildScrollView(
        child: title == " Semua Transaksi"
            ? const ReportAllWidget()
            : title == " Per Hari"
                ? ReportPerDayWidget(date: date)
                : ReportPerMonthOrYearWidget(
                    title: title,
                    date: date,
                  ),
      ),
    );
  }
}
