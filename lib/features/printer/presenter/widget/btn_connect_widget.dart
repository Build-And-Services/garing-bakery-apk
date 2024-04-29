import 'package:flutter/material.dart';
import 'package:garing_bakery_apk/core/config/theme.dart';
import 'package:garing_bakery_apk/features/transaction/presenter/provider/print_provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ButtonConnectPrint extends StatelessWidget {
  const ButtonConnectPrint({super.key});

  Future<void> connect(
      PrintProvider printProvider, BuildContext context) async {
    if (printProvider.device == null) {
      MyTheme.showSnackBarFun(
        context,
        "Pilih Device terlebih dahulu",
        const Color.fromARGB(255, 142, 115, 16),
      );
    } else {
      printProvider.connect().catchError((error) {
        MyTheme.showSnackBarFun(
          context,
          "Terjadi Kesalahan",
          Colors.red,
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    PrintProvider printProvider = context.watch<PrintProvider>();
    return InkWell(
      onTap: () => connect(printProvider, context),
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 12,
          horizontal: 20,
        ),
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          color: Colors.indigo,
          borderRadius: BorderRadius.all(
            Radius.circular(
              50,
            ),
          ),
        ),
        child: Text(
          printProvider.connected ? "Connected" : "Try to Connect!",
          style: GoogleFonts.poppins(
            fontSize: 18,
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
