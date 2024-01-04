import 'package:flutter/foundation.dart';
import 'package:garing_bakery_apk/features/auth/data/service/auth_service.dart';

class AuthProvider with ChangeNotifier {
  bool _isLogin = true;

  bool get isLogin => _isLogin;

  Future<void> login(String email, String password) async {
    // key body harus string
    final result = await AuthService.login(email, password);
    debugPrint(result.body);
    if (result.statusCode == 200) {
      _isLogin = true;
    } else {
      _isLogin = false;
    }
    notifyListeners();
  }
}
