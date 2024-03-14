import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:garing_bakery_apk/core/helpers/format_rupiah.dart';
import 'package:garing_bakery_apk/core/models/arguments/ArgumentReportTransaction.dart';
import 'package:garing_bakery_apk/features/reports/data/model/response.dart';
import 'package:garing_bakery_apk/features/reports/data/service/reports_service.dart';
import 'package:garing_bakery_apk/features/reports/presenter/widgets/chart_dinamis_widget.dart';
import 'package:garing_bakery_apk/features/reports/presenter/widgets/loading_widget.dart';
import 'package:garing_bakery_apk/features/reports/presenter/widgets/no_data_widget.dart';
import 'package:garing_bakery_apk/features/reports/presenter/widgets/problem_get_widget.dart';
import 'package:google_fonts/google_fonts.dart';

class ReportPerDayWidget extends StatelessWidget {
  const ReportPerDayWidget({
    super.key,
    required this.date,
  });

  final ArgumentReportTransaction date;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ReportDayTransactionResponse>(
      future:
          ReportsService.getTransactionDay(date.date, date.month, date.tahun),
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

        double maxY = 0;
        List<FlSpot> spots = [];
        if (snapshot.data?.data != null) {
          spots = snapshot.data!.data.map((item) {
            final jam = item.hour.split(':');
            return FlSpot(double.parse(jam[0]), double.parse(item.revenue));
          }).toList();
          for (var y in snapshot.data!.data) {
            if (maxY < double.parse(y.revenue)) {
              maxY = double.parse(y.revenue);
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
              ChartDinamisWidget(maxX: 0, maxY: maxY, spots: spots),
              const SizedBox(
                height: 20,
              ),
              Column(
                children: snapshot.data!.data
                    .map(
                      (e) => InkWell(
                        onTap: () {},
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      e.hour,
                                      style: GoogleFonts.poppins(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Text(
                                      e.time,
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
      },
    );
  }

  // AspectRatio chartMethod(double maxY, List<FlSpot> spots) {
  //   return AspectRatio(
  //     aspectRatio: 1.70,
  //     child: Padding(
  //       padding: const EdgeInsets.only(
  //         right: 18,
  //         left: 12,
  //         top: 24,
  //         bottom: 12,
  //       ),
  //       child: LineChart(
  //         LineChartData(
  //           titlesData: const FlTitlesData(
  //             show: true,
  //             rightTitles: AxisTitles(
  //               sideTitles: SideTitles(showTitles: false),
  //             ),
  //             topTitles: AxisTitles(
  //               sideTitles: SideTitles(showTitles: false),
  //             ),
  //           ),
  //           borderData: FlBorderData(
  //             show: false,
  //           ),
  //           minX: 0,
  //           maxX: 24,
  //           minY: 0,
  //           maxY: maxY + 10000,
  //           lineBarsData: [
  //             LineChartBarData(
  //               spots: spots,
  //               isCurved: true,
  //               gradient: LinearGradient(
  //                 colors: gradientColors,
  //               ),
  //               barWidth: 2,
  //               isStrokeCapRound: true,
  //               dotData: const FlDotData(
  //                 show: true,
  //               ),
  //               belowBarData: BarAreaData(
  //                 show: true,
  //                 gradient: LinearGradient(
  //                   colors: gradientColors
  //                       .map((color) => color.withOpacity(0.3))
  //                       .toList(),
  //                 ),
  //               ),
  //             ),
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }
}
