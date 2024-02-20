import 'package:garing_bakery_apk/core/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TokenService {
  static saveData(String token, UserModel user) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("token", token);

    prefs.setString("id", user.id.toString());
    prefs.setString("name", user.name);
    prefs.setString("email", user.email);
    prefs.setString("image", user.image);
    prefs.setString("role", user.role);
  }

  static Future<UserModel> getCacheUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final id = prefs.getString("id");
    final name = prefs.getString("name");
    final email = prefs.getString("email");
    final image = prefs.getString("image");
    final role = prefs.getString("role");

    return UserModel(
      id: int.parse(id!),
      name: name!,
      email: email!,
      image: image!,
      role: role!,
    );
  }

  static Future<String> getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = "Bearer ${prefs.getString('token')}";
    return token;
  }
}
