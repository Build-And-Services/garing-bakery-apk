import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:garing_bakery_apk/core/helpers/format_rupiah.dart';
import 'package:garing_bakery_apk/core/models/arguments/ArgumentReportTransaction.dart';
import 'package:garing_bakery_apk/core/routes/app.dart';
import 'package:garing_bakery_apk/features/reports/data/model/response.dart';
import 'package:garing_bakery_apk/features/reports/data/service/reports_service.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class ReportPerMonthOrYearWidget extends StatelessWidget {
  const ReportPerMonthOrYearWidget({
    super.key,
    required this.title,
    required this.date,
  });

  final String title;
  final ArgumentReportTransaction date;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ReportTahunTransactionsResponse>(
      future: title == ' Per Bulan'
          ? ReportsService.getTransactionBulan(date.month, date.tahun)
          : ReportsService.getTransactionTahun(date.tahun),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        if (snapshot.hasError) {
          return SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: const Center(
              child: Text("Something went wrong!, check your connection"),
            ),
          );
        }
        if (!snapshot.hasData) {
          return SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: const Center(
              child: Text("Data tidak ada"),
            ),
          );
        }
        return Container(
          padding: const EdgeInsets.all(
            20,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ChartDinamisWidget(),
              const SizedBox(
                height: 20,
              ),
              Column(
                children: snapshot.data!.data.map((e) {
                  return InkWell(
                    onTap: () {
                      if (title == ' Per Bulan') {
                        DateFormat format = DateFormat('dd MMM yyyy');
                        DateTime dateTime = format.parse(e.time);
                        Navigator.of(context).pushNamed(
                          Routes.REPORTS_PER_TRANSACTIONS,
                          arguments: ArgumentReportTransaction(
                            dateTime.day.toString(),
                            dateTime.month.toString(),
                            dateTime.year.toString(),
                          ),
                        );
                      } else {
                        DateTime now = DateTime.now();
                        DateFormat format = DateFormat('MMMM yyyy');
                        DateTime dateTime =
                            format.parse("${e.time} ${now.year}");
                        Navigator.of(context).pushNamed(
                          Routes.REPORTS_PER_TRANSACTIONS,
                          arguments: ArgumentReportTransaction(
                            '',
                            dateTime.month.toString(),
                            dateTime.year.toString(),
                          ),
                        );
                      }
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  e.time.toString(),
                                  style: GoogleFonts.poppins(
                                    fontSize: 22.sp,
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
                          ),
                          const Icon(
                            Icons.arrow_forward,
                          )
                        ],
                      ),
                    ),
                  );
                }).toList(),
              )
            ],
          ),
        );
      },
    );
  }
}
