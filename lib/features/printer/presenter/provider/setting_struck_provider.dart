import 'package:flutter/material.dart';
import 'package:garing_bakery_apk/features/printer/data/service/struck_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingStruckProvider extends ChangeNotifier {
  bool _isLoading = true;
  final TextEditingController _namaPerusahaan = TextEditingController();
  final TextEditingController _alamat = TextEditingController();
  final TextEditingController _noTelp = TextEditingController();
  final TextEditingController _footer = TextEditingController();

  TextEditingController get namaperusahaan => _namaPerusahaan;
  TextEditingController get alamat => _alamat;
  TextEditingController get notelp => _noTelp;
  TextEditingController get footer => _footer;

  bool get isLoading => _isLoading;

  Future<void> getData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final company = prefs.getString("company");
    final alamat = prefs.getString("alamat");
    final notelp = prefs.getString("notelp");
    final footer = prefs.getString("footer");
    _namaPerusahaan.text = company ?? "";
    _alamat.text = alamat ?? "";
    _noTelp.text = notelp ?? "";
    _footer.text = footer ?? "";
    _isLoading = false;
    notifyListeners();
  }

  Future<bool> saveData() async {
    try {
      await SettingStruckService.saveData(
          _namaPerusahaan.text, _alamat.text, _noTelp.text, _footer.text);
      await SettingStruckService.getData();
      notifyListeners();
      return true;
      // print()
    } catch (e) {
      return false;
    }
  }
}
