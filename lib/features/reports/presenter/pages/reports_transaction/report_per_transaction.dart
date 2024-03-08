import 'package:flutter/material.dart';
import 'package:garing_bakery_apk/core/config/theme.dart';
import 'package:garing_bakery_apk/core/helpers/format_rupiah.dart';
import 'package:garing_bakery_apk/core/models/arguments/ArgumentReportTransaction.dart';
import 'package:garing_bakery_apk/features/reports/data/model/response.dart';
import 'package:garing_bakery_apk/features/reports/data/service/reports_service.dart';
import 'package:garing_bakery_apk/features/reports/presenter/widgets/chart_widget.dart';
import 'package:google_fonts/google_fonts.dart';
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
    if (date.date != '' && date.month == '' && date.year == '') {
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
            ? FutureBuilder<ReportTransactionsResponse>(
                future: ReportsService.getAllTransactions(),
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
                        child: Text(
                            "Something went wrong!, check your connection"),
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
                        ChartWidget(),
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
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
                                                formatRupiah(
                                                    int.parse(e.profit)),
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
                })
            : title == " Per Hari"
                ? FutureBuilder<ReportDayTransactionResponse>(
                    future: ReportsService.getTransactionDay(
                        date.date, date.month, date.tahun),
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
                            child: Text(
                                "Something went wrong!, check your connection"),
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
                            ChartWidget(),
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
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    e.hour,
                                                    style: GoogleFonts.poppins(
                                                      fontSize: 22,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black,
                                                    ),
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                  Text(
                                                    e.time,
                                                    style: GoogleFonts.poppins(
                                                      fontSize: 14,
                                                      // fontWeight: FontWeight.bold,
                                                      color: Colors.grey,
                                                    ),
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
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
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: Colors.grey,
                                                      fontStyle:
                                                          FontStyle.italic,
                                                    ),
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                  Text(
                                                    formatRupiah(
                                                      int.parse(e.revenue),
                                                    ),
                                                    style: GoogleFonts.poppins(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black,
                                                    ),
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                  Text(
                                                    "Keuntungan",
                                                    style: GoogleFonts.poppins(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: Colors.grey,
                                                      fontStyle:
                                                          FontStyle.italic,
                                                    ),
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                  Text(
                                                    formatRupiah(
                                                        int.parse(e.profit)),
                                                    style: GoogleFonts.poppins(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black,
                                                    ),
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
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
                    })
                : FutureBuilder<ReportTahunTransactionsResponse>(
                    future: title == ' Per Bulan'
                        ? ReportsService.getTransactionBulan(
                            date.date, date.tahun)
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
                            child: Text(
                                "Something went wrong!, check your connection"),
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
                            ChartWidget(),
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
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    e.time.toString(),
                                                    style: GoogleFonts.poppins(
                                                      fontSize: 22,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black,
                                                    ),
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                  Text(
                                                    "${e.transactionCount} transactions",
                                                    style: GoogleFonts.poppins(
                                                      fontSize: 14,
                                                      // fontWeight: FontWeight.bold,
                                                      color: Colors.grey,
                                                    ),
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
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
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: Colors.grey,
                                                      fontStyle:
                                                          FontStyle.italic,
                                                    ),
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                  Text(
                                                    formatRupiah(
                                                      int.parse(e.revenue),
                                                    ),
                                                    style: GoogleFonts.poppins(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black,
                                                    ),
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                  Text(
                                                    "Keuntungan",
                                                    style: GoogleFonts.poppins(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: Colors.grey,
                                                      fontStyle:
                                                          FontStyle.italic,
                                                    ),
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                  Text(
                                                    formatRupiah(
                                                        int.parse(e.profit)),
                                                    style: GoogleFonts.poppins(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black,
                                                    ),
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
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
                    }),
      ),
    );
  }
}
