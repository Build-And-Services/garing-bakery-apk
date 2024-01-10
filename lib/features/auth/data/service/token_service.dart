import 'package:shared_preferences/shared_preferences.dart';

class TokenService {
  static saveData(String token, String user) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("token", token);
    prefs.setString("user", user);
  }
}
