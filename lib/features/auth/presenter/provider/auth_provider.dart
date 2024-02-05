import 'package:flutter/material.dart';
import 'package:garing_bakery_apk/features/auth/data/model/auth_model.dart';
import 'package:garing_bakery_apk/features/auth/data/service/auth_service.dart';
import 'package:garing_bakery_apk/features/auth/data/service/token_service.dart';

class AuthProvider with ChangeNotifier {
  // initialization
  bool _isLogin = false;
  bool _isloading = false;
  String? _message;
  String? _error;
  // initialization input
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  // get method
  bool get isLogin => _isLogin;
  bool get isloading => _isloading;
  String? get message => _message;
  String? get error => _error;
  // get method input
  TextEditingController get email => _email;
  TextEditingController get password => _password;

  // all method
  startLoading() {
    _isloading = true;
    notifyListeners();
  }

  stopLoading() {
    _isloading = false;
    notifyListeners();
  }

  Future<void> login() async {
    try {
      AuthModel result = await AuthService.login(_email.text, _password.text);
      if (result.message == 'success login') {
        await TokenService.saveData(
            "${result.tokenType} ${result.accessToken}", result.data!);
        _isLogin = true;
        _message = result.message;
        notifyListeners();
      } else {
        _message = result.message;
        notifyListeners();
      }
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }

  String? validationEmail(value) {
    if (value!.isEmpty) {
      return 'Tolong isi email terlebih dahulu';
    }
    RegExp regex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

    if (!regex.hasMatch(value)) {
      return 'Masukan email jangan yang lain';
    }
    return null;
  }

  String? validationPassword(value) {
    if (value!.isEmpty) {
      return 'Tolong isi password terlebih dahulu';
    }
    if (value.length < 6) {
      return 'Password yang anda masukan kurang dari 6 huruf';
    }
    return null;
  }

  clear() {
    _message = null;
    _error = null;
    notifyListeners();
  }
}
