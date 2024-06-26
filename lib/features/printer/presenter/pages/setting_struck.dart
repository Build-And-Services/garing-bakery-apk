import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:garing_bakery_apk/core/config/theme.dart';
import 'package:garing_bakery_apk/core/widgets/button_widget.dart';
import 'package:garing_bakery_apk/core/widgets/drawer_widget.dart';
import 'package:garing_bakery_apk/core/widgets/input_widget.dart';
import 'package:garing_bakery_apk/core/widgets/loading_widget.dart';
import 'package:garing_bakery_apk/features/printer/presenter/provider/setting_struck_provider.dart';
import 'package:garing_bakery_apk/features/printer/presenter/widget/btn_connect_widget.dart';
import 'package:garing_bakery_apk/features/printer/presenter/widget/dropdown_device.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class StruckSetting extends StatefulWidget {
  const StruckSetting({super.key});

  @override
  State<StruckSetting> createState() => _StruckSettingState();
}

class _StruckSettingState extends State<StruckSetting> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {
        if (didPop) {
          return;
        }
        final bool shouldCloseTheApp = await MyTheme.showDialogClose(context);
        if (shouldCloseTheApp) {
          SystemNavigator.pop();
        }
      },
      child: Scaffold(
        drawer: const DrawerPage(),
        appBar: AppBar(
          title: Text(
            'Printer & Struk',
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          centerTitle: true,
          backgroundColor: MyTheme.primary,
        ),
        body: Consumer<SettingStruckProvider>(
          builder: (context, struckProvider, _) {
            if (struckProvider.isLoading) {
              struckProvider.getData();
              return const LoadingWidget();
            }
            return SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      InputWidget(
                        label: "Nama Perusahaan",
                        controller: struckProvider.namaperusahaan,
                      ),
                      InputWidget(
                        label: "Alamat",
                        controller: struckProvider.alamat,
                      ),
                      InputWidget(
                        label: "No Telp",
                        controller: struckProvider.notelp,
                      ),
                      InputWidget(
                        label: "Footer",
                        controller: struckProvider.footer,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: 50,
                        child: ButtonWidget(
                          title: Text(
                            "Simpan",
                            style: GoogleFonts.poppins(
                              fontSize: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          tap: () {
                            if (_formKey.currentState!.validate()) {
                              struckProvider.saveData().then(
                                (value) {
                                  if (value) {
                                    MyTheme.alertSucces(
                                      context,
                                      "Berhasil disimpan",
                                    );
                                  }
                                },
                              );
                            }
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Divider(
                        color: Color.fromARGB(255, 147, 147, 147),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const DropdownDevice(),
                      const SizedBox(
                        height: 20,
                      ),
                      const ButtonConnectPrint(),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
