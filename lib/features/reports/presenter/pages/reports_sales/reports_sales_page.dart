import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:garing_bakery_apk/core/config/theme.dart';
import 'package:garing_bakery_apk/core/helpers/format_rupiah.dart';
import 'package:garing_bakery_apk/features/reports/data/model/response.dart';
import 'package:garing_bakery_apk/features/reports/data/service/reports_service.dart';
import 'package:garing_bakery_apk/features/reports/presenter/provider/reports_sales_provider.dart';
import 'package:garing_bakery_apk/features/reports/presenter/widgets/box_info_report_widget.dart';
import 'package:garing_bakery_apk/features/reports/presenter/widgets/chart_dinamis_widget.dart';
import 'package:garing_bakery_apk/features/reports/presenter/widgets/dropdown_widget.dart';
import 'package:garing_bakery_apk/features/reports/presenter/widgets/no_data_widget.dart';
import 'package:garing_bakery_apk/features/reports/presenter/widgets/problem_get_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

class ReportsSalesPage extends StatefulWidget {
  const ReportsSalesPage({super.key});

  @override
  State<ReportsSalesPage> createState() => _ReportsSalesPageState();
}

class _ReportsSalesPageState extends State<ReportsSalesPage> {
  @override
  Widget build(BuildContext context) {
    ReportsSalesProvider reportsSalesProvider =
        context.watch<ReportsSalesProvider>();
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
        title: const Center(
          child: Text(
            'Laporan Penjualan',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: FutureBuilder<ReportSalesResponse>(
            future: ReportsService.getReportSales(
                reportsSalesProvider.dateTime.toString()),
            builder: (context, snapshot) {
              if (ConnectionState.waiting == snapshot.connectionState) {
                return SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: const Center(
                    child: CircularProgressIndicator(
                      color: MyTheme.brown,
                    ),
                  ),
                );
              }
              if (snapshot.hasError) {
                return const ProblemWidget();
              }

              if (!snapshot.hasData) {
                return const NoDataWidget();
              }
              final ReportSalesResponse data =
                  snapshot.data as ReportSalesResponse;
              int countTransaction = 0;
              int maxY = 0;

              for (var element in data.details) {
                countTransaction += element.totalTransactions;
              }
              for (var element in data.details) {
                if (maxY < element.revenue) {
                  maxY = element.revenue;
                }
              }
              return Container(
                color: const Color.fromARGB(255, 255, 247, 238),
                width: MediaQuery.of(context).size.width,
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
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      DateFormat("EEEE, d MMMM yyyy", "id_ID")
                          .format(reportsSalesProvider.dateTime),
                      style: GoogleFonts.poppins(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        fontStyle: FontStyle.italic,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    BoxInforReport(
                      value: countTransaction.toString(),
                      label: "Jumlah Transaksi",
                    ),
                    BoxInforReport(
                      value: formatRupiah(data.profit),
                      label: "Keuntungan",
                    ),
                    BoxInforReport(
                      value: formatRupiah(data.revenue),
                      label: "Pendapatan",
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Laporan Penjualan per Jam",
                      style: GoogleFonts.poppins(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      DateFormat("EEEE, d MMMM yyyy", "id_ID")
                          .format(reportsSalesProvider.dateTime),
                      style: GoogleFonts.poppins(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        fontStyle: FontStyle.italic,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    ChartDinamisWidget(
                      maxX: 24,
                      maxY: maxY.toDouble() + 5000,
                      spots: data.details.map((item) {
                        final jam = double.parse(item.indicator.split(':')[0]);
                        final menit =
                            double.parse(item.indicator.split(':')[1]) / 60;
                        return FlSpot(
                          jam + menit,
                          item.revenue.toDouble(),
                        );
                      }).toList(),
                      leftTitles: const AxisTitles(
                        sideTitles: SideTitles(
                          reservedSize: 44,
                          showTitles: true,
                        ),
                      ),
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          interval: 4,
                          getTitlesWidget: (value, meta) {
                            return Text(
                              value.toInt().toString(),
                              style: GoogleFonts.poppins(
                                fontSize: 10,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20.sp,
                    )
                  ],
                ),
              );
            }),
      ),
    );
  }
}

// ignore: must_be_immutable
