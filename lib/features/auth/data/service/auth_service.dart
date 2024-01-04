import 'package:flutter/material.dart';
import 'package:garing_bakery_apk/core/config/remote.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class AuthService {
  static Future<Response> login(String email, String password) async {
    debugPrint(RemoteApi().LOGIN);
    final result = await http.post(Uri.parse(RemoteApi().LOGIN), body: {
      'email': email,
      'password': password,
    });
    return result;
  }
}
