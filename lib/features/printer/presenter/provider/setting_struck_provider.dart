import 'package:flutter/material.dart';
import 'package:garing_bakery_apk/features/printer/data/service/struck_service.dart';

class SettingStruckProvider extends ChangeNotifier {
  final TextEditingController _namaPerusahaan = TextEditingController();
  final TextEditingController _alamat = TextEditingController();
  final TextEditingController _noTelp = TextEditingController();
  final TextEditingController _footer = TextEditingController();

  TextEditingController get namaperusahaan => _namaPerusahaan;
  TextEditingController get alamat => _alamat;
  TextEditingController get notelp => _noTelp;
  TextEditingController get footer => _footer;

  Future<void> saveData() async {
    try {
      await SettingStruckService.saveData(
          _namaPerusahaan.text, _alamat.text, _noTelp.text, _footer.text);
      await SettingStruckService.getData();
      notifyListeners();
      print('Success');
      // print()
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
