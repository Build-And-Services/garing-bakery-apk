import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:garing_bakery_apk/core/config/theme.dart';
import 'package:garing_bakery_apk/core/models/arguments/ArgumentReportTransaction.dart';
import 'package:garing_bakery_apk/core/utils/save_file.dart';
import 'package:garing_bakery_apk/core/widgets/no_data_widget.dart';
import 'package:garing_bakery_apk/core/widgets/problem_get_widget.dart';
import 'package:garing_bakery_apk/features/reports/data/model/response.dart';
import 'package:garing_bakery_apk/features/reports/data/service/reports_service.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart' as xcel;
import 'package:google_fonts/google_fonts.dart';

class ReportSalesToExcel extends StatelessWidget {
  const ReportSalesToExcel({
    super.key,
    required this.date,
  });

  final ArgumentReportTransaction date;

  @override
  Widget build(BuildContext context) {
    AppBar appBar = AppBar(
      backgroundColor: MyTheme.primary,
      title: const Text(
        'Export Excel',
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
      ),
    );
    return SafeArea(
      child: Scaffold(
        appBar: appBar,
        body: FutureBuilder<ReportTransactionSalesResponse>(
            future: ReportsService.getReportSalestoExcel(
                date.date, date.month, date.tahun),
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
                debugPrint(snapshot.error.toString());
                return const ProblemWidget();
              }

              if (!snapshot.hasData) {
                return const NoDataWidget();
              }

              final ReportTransactionSalesResponse data =
                  snapshot.data as ReportTransactionSalesResponse;
              final totalBarang = data.data.fold(0,
                  (previousValue, element) => previousValue + element.quantity);
              return Container(
                color: const Color.fromARGB(255, 255, 247, 238),
                height: MediaQuery.of(context).size.height,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      color: const Color.fromARGB(255, 255, 247, 238),
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
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
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(8))),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(
                                    10,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "$totalBarang Barang Keluar",
                                        style: GoogleFonts.poppins(
                                            fontSize: 18.sp,
                                            fontWeight: FontWeight.bold,
                                            color: MyTheme.primary),
                                      ),
                                      Text(
                                        date.date == '' &&
                                                date.month == '' &&
                                                date.tahun == ''
                                            ? "Tercatat Dalam Aplikasi"
                                            : date.date == '' &&
                                                    date.month == ''
                                                ? "Pada Tahun ${date.tahun}"
                                                : date.date == ''
                                                    ? "Pada Bulan ${date.month}/${date.tahun}"
                                                    : 'Pada ${date.date}/${date.bulan}/${date.tahun}',
                                        style: GoogleFonts.poppins(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    DownloadExcel(data: data.data),
                  ],
                ),
              );
            }),
      ),
    );
  }
}

class DownloadExcel extends StatefulWidget {
  const DownloadExcel({
    super.key,
    required this.data,
  });

  final List<DetailSales> data;

  @override
  State<DownloadExcel> createState() => _DownloadExcelState();
}

class _DownloadExcelState extends State<DownloadExcel> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        setState(() {
          isLoading = true;
        });
        _generateExcel(widget.data, context);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 15,
          horizontal: 12,
        ),
        width: MediaQuery.of(context).size.width,
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        decoration: const BoxDecoration(
            color: MyTheme.brown,
            borderRadius: BorderRadius.all(Radius.circular(16))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.print,
              color: Colors.white,
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              isLoading ? 'Sedang Mendownload' : 'Download',
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future _generateExcel(List<DetailSales> data, context) async {
    final xcel.Workbook workbook = xcel.Workbook();
    final xcel.Worksheet sheet = workbook.worksheets[0];
    sheet.showGridlines = false;

    sheet.enableSheetCalculations();

    sheet.getRangeByName('A1:C1').columnWidth = 14.82;
    sheet.getRangeByName('D1').columnWidth = 13.00;

    sheet.getRangeByName('A1').setText("Nama Produk");
    sheet.getRangeByName('A1').cellStyle.bold = true;
    sheet.getRangeByName('B1').setText("Harga Jual");
    sheet.getRangeByName('b1').cellStyle.bold = true;
    sheet.getRangeByName('C1').setText("Tanggal");
    sheet.getRangeByName('c1').cellStyle.bold = true;
    sheet.getRangeByName('D1').setText("Jumlah");
    sheet.getRangeByName('d1').cellStyle.bold = true;

    for (var i = 0; i < data.length; i++) {
      final item = data[i];
      sheet.getRangeByIndex(i + 2, 1).setText(item.productName.toString());
      sheet
          .getRangeByIndex(i + 2, 2)
          .setText((item.sellingPrice * item.quantity).toString());
      sheet.getRangeByIndex(i + 2, 3).setText(item.tanggal.toString());
      sheet.getRangeByIndex(i + 2, 4).setText(item.quantity.toString());
    }

    final totalBarang = data.fold(
        0, (previousValue, element) => previousValue + element.quantity);

    //Save and launch the excel.
    final List<int> bytes = workbook.saveAsStream();
    //Dispose the document.
    workbook.dispose();

    final path =
        '$totalBarang-${DateFormat('yyyy-MM-dd-HH-ss').format(DateTime.now())}.xlsx';

    await saveAndLaunchFile(bytes, path);

    setState(() {
      isLoading = false;
    });

    MyTheme.alertSucces(
      context,
      'Download Berhasil File Tersimpan di Folder Download/$path',
      confirm: true,
      duration: null,
    );
  }
}
