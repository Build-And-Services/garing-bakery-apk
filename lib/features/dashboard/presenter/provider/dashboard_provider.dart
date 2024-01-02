import 'package:flutter/foundation.dart';
import 'package:garing_bakery_apk/features/auth/data/service/auth_service.dart';

class DashboardProvider with ChangeNotifier, DiagnosticableTreeMixin {
  bool _isLogin = false;

  bool get isLogin => _isLogin;

  Future<void> login(String email, String password) async {
    // key body harus string
    final result = await AuthService.login(email, password);
    if (result.statusCode == 200) {
      _isLogin = true;
    } else {
      _isLogin = false;
    }
    notifyListeners();
  }
}
