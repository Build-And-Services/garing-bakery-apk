import 'package:flutter/material.dart';
import 'package:garing_bakery_apk/core/config/theme.dart';
import 'package:garing_bakery_apk/core/helpers/format_rupiah.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class ReportsSalesPage extends StatefulWidget {
  const ReportsSalesPage({super.key});

  @override
  State<ReportsSalesPage> createState() => _ReportsSalesPageState();
}

class _ReportsSalesPageState extends State<ReportsSalesPage> {
  String dropdownvalue = 'Today';
  DateTime currentDate = DateTime.now();
  String today =
      DateFormat("EEEE, d MMMM yyyy", "id_ID").format(DateTime.now());
  var filter = [
    'Today',
    'Yesterday',
    'Custom',
  ];

  @override
  void initState() {
    today = DateFormat("EEEE, d MMMM yyyy", "id_ID").format(currentDate);
    super.initState();
  }

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
        color: const Color.fromARGB(255, 255, 247, 238),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 20,
            ),
            Container(
              margin: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 10,
              ),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: MyTheme.primary)),
              width: MediaQuery.of(context).size.width,
              child: DropdownButtonHideUnderline(
                child: ButtonTheme(
                    alignedDropdown: true,
                    child: DropdownButton(
                      borderRadius: BorderRadius.circular(8),
                      value: dropdownvalue,
                      items: filter.map((String items) {
                        return DropdownMenuItem(
                          value: items,
                          child: Row(
                            children: [
                              const Icon(Icons.calendar_today),
                              const SizedBox(
                                width: 8,
                              ),
                              Text(items),
                            ],
                          ),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          dropdownvalue = newValue!;
                          if (dropdownvalue == 'Yesterday') {
                            currentDate = DateTime.now()
                                .subtract(const Duration(days: 1));
                          } else if (dropdownvalue == 'Today') {
                            currentDate = DateTime.now();
                          } else {
                            _selectDate(context);
                          }
                        });
                      },
                    )),
              ),
            ),
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
            Text(
              DateFormat("EEEE, d MMMM yyyy", "id_ID").format(currentDate),
              style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey,
                  fontStyle: FontStyle.italic),
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
          ],
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    await showDatePicker(
            context: context,
            initialDate: currentDate,
            firstDate: DateTime(2015),
            lastDate: DateTime(2050))
        .then((value) => {
              if (value != null)
                {
                  setState(() {
                    currentDate = value;
                  })
                }
            });
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
