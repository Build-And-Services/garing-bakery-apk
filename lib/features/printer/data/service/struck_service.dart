import 'package:shared_preferences/shared_preferences.dart';

class SettingStruckService {
  static saveData(
      String company, String alamat, String notelp, String footer) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("company", company);
    prefs.setString("alamat", alamat);
    prefs.setString("notelp", notelp);
    prefs.setString("footer", footer);
  }

  static Future<Map<String, dynamic>> getData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final company = prefs.getString("company");
    final alamat = prefs.getString("alamat");
    final notelp = prefs.getString("notelp");
    final footer = prefs.getString("footer");

    return {
      "company": company,
      "alamat": alamat,
      "notelp": notelp,
      "footer": footer
    };
  }
}
