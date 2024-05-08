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
      MyTheme.alertWarning(
        context,
        "Harap pilih printer terlebih dahulu",
      );
    } else if (printProvider.connected) {
      MyTheme.alertWarning(
        context,
        "Sudah terkoneksi",
      );
    } else {
      printProvider.connect().then((value) {
        if (value) {
          printProvider.setTips = "Sudah terkoneksi";
          MyTheme.alertSucces(
            context,
            "Berhasil Terkoneksi",
          );
        } else {
          MyTheme.alertError(
            context,
            "Terjadi Kesalahan",
          );
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    PrintProvider printProvider = context.watch<PrintProvider>();
    return FutureBuilder(
        future: printProvider.bluetoothPrint.isConnected,
        builder: (context, snapshot) {
          if (snapshot.data != null && snapshot.data!) {
            return InkWell(
              onTap: () => printProvider.disconnect().then((value) {
                if (value) {
                  MyTheme.alertSucces(context, "Berhasil diputus");
                } else {
                  MyTheme.alertError(context, "Terjadi Kesalahan");
                }
              }),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 12,
                  horizontal: 20,
                ),
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.all(
                    Radius.circular(
                      50,
                    ),
                  ),
                ),
                child: Text(
                  "Disconnect Device",
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
                printProvider.tips,
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          );
        });
  }
}
