import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:garing_bakery_apk/core/helpers/format_rupiah.dart';
import 'package:garing_bakery_apk/core/models/arguments/ArgumentReportTransaction.dart';
import 'package:garing_bakery_apk/core/routes/app.dart';
import 'package:garing_bakery_apk/core/widgets/loading_widget.dart';
import 'package:garing_bakery_apk/core/widgets/no_data_widget.dart';
import 'package:garing_bakery_apk/core/widgets/problem_get_widget.dart';
import 'package:garing_bakery_apk/features/reports/data/model/response.dart';
import 'package:garing_bakery_apk/features/reports/data/service/reports_service.dart';
import 'package:garing_bakery_apk/features/reports/presenter/widgets/chart_dinamis_widget.dart';
import 'package:google_fonts/google_fonts.dart';

class ReportAllWidget extends StatelessWidget {
  const ReportAllWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ReportTransactionsResponse>(
        future: ReportsService.getAllTransactions(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingWidget();
          }
          if (snapshot.hasError) {
            return const ProblemWidget();
          }
          if (!snapshot.hasData) {
            return const NoDataWidget();
          }

          double maxX = 2000;
          double maxY = 0;
          List<FlSpot> spots = [];
          if (snapshot.data?.data != null) {
            spots = snapshot.data!.data.map((item) {
              return FlSpot(
                item.transactionYear.toDouble(),
                double.parse(item.revenue),
              );
            }).toList();
            for (var y in snapshot.data!.data) {
              if (maxY < double.parse(y.revenue)) {
                maxY = double.parse(y.revenue);
              }
            }
            for (var y in snapshot.data!.data) {
              if (maxX < y.transactionYear.toDouble()) {
                maxX = y.transactionYear.toDouble();
              }
            }
          }
          return Container(
            padding: const EdgeInsets.all(
              20,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ChartDinamisWidget(
                  minX: 2020,
                  minY: 100000,
                  maxX: maxX + 16,
                  maxY: maxY + 100000,
                  spots: spots,
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      interval: 4,
                      getTitlesWidget: (value, meta) {
                        return Text(
                          value.toString().split('.')[0],
                          style: GoogleFonts.poppins(
                            fontSize: 10,
                          ),
                        );
                      },
                    ),
                  ),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      reservedSize: 60,
                      showTitles: true,
                      interval: 400000,
                      getTitlesWidget: (value, meta) {
                        return Text(
                          formatRupiah(
                            value.toInt(),
                          ).split('Rp')[1].split(',00')[0],
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                          ),
                        );
                      },
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Column(
                  children: snapshot.data!.data
                      .map(
                        (e) => InkWell(
                          onTap: () {
                            Navigator.of(context).pushNamed(
                              Routes.REPORTS_PER_TRANSACTIONS,
                              arguments: ArgumentReportTransaction(
                                '',
                                '',
                                e.transactionYear.toString(),
                              ),
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: 10,
                            ),
                            decoration: const BoxDecoration(
                                border: Border(
                              bottom: BorderSide(
                                color: Colors.grey,
                                width: 1,
                                style: BorderStyle.solid,
                              ),
                            )),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        e.transactionYear.toString(),
                                        style: GoogleFonts.poppins(
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Text(
                                        "${e.transactionCount} transactions",
                                        style: GoogleFonts.poppins(
                                          fontSize: 14,
                                          // fontWeight: FontWeight.bold,
                                          color: Colors.grey,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      )
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Pendapatan",
                                        style: GoogleFonts.poppins(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.grey,
                                          fontStyle: FontStyle.italic,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Text(
                                        formatRupiah(
                                          int.parse(e.revenue),
                                        ),
                                        style: GoogleFonts.poppins(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Text(
                                        "Keuntungan",
                                        style: GoogleFonts.poppins(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.grey,
                                          fontStyle: FontStyle.italic,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Text(
                                        formatRupiah(int.parse(e.profit)),
                                        style: GoogleFonts.poppins(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      )
                                    ],
                                  ),
                                ),
                                const Icon(
                                  Icons.arrow_forward,
                                )
                              ],
                            ),
                          ),
                        ),
                      )
                      .toList(),
                )
              ],
            ),
          );
        });
  }
}
