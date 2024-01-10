import 'package:garing_bakery_apk/core/config/remote.dart';
import 'package:garing_bakery_apk/features/auth/data/model/auth_model.dart';
import 'package:http/http.dart' as http;

class AuthService {
  static Future<AuthModel> login(String email, String password) async {
    try {
      final result = await http.post(Uri.parse(RemoteApi().LOGIN), body: {
        'email': email,
        'password': password,
      });
      return AuthModel.fromRawJson(result.body);
    } catch (e) {
      rethrow;
    }
  }
}
