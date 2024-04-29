import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:garing_bakery_apk/core/config/theme.dart";
import "package:garing_bakery_apk/features/printer/data/service/struck_service.dart";
import "package:garing_bakery_apk/features/transaction/data/model/reponse_add.dart";
import "package:google_fonts/google_fonts.dart";

class ButtonPrint extends StatefulWidget {
  const ButtonPrint({
    super.key,
    required this.detail,
  });

  final TransactionAddResponse detail;

  @override
  State<ButtonPrint> createState() => _ButtonPrintState();
}

class _ButtonPrintState extends State<ButtonPrint> {
  late Map<String, dynamic> struck;

  Future getDataStruck() async {
    final dataStruck = await SettingStruckService.getData();
    setState(() {
      struck = dataStruck;
    });
  }

  @override
  void initState() {
    getDataStruck();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {},
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 15,
          horizontal: 12,
        ),
        width: MediaQuery.of(context).size.width,
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        decoration: const BoxDecoration(
          color: MyTheme.brown,
          borderRadius: BorderRadius.all(
            Radius.circular(16),
          ),
        ),
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
              "Cetak Struk",
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
}
