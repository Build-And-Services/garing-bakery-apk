import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class AuthService {
  static Future<Response> login(String email, String password) async {
    final result = await http
        .post(Uri.parse("http://192.168.1.56:3000/api/v1/auth"), body: {
      'email': email,
      'password': password,
    });
    return result;
  }
}
