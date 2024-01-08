import 'dart:convert';

import 'package:garing_bakery_apk/core/models/user_model.dart';

class AuthModel {
  final String message;
  final String? accessToken;
  final String? tokenType;
  final UserModel? data;

  AuthModel({
    required this.message,
    required this.accessToken,
    required this.tokenType,
    required this.data,
  });

  factory AuthModel.fromRawJson(String str) =>
      AuthModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AuthModel.fromJson(Map<String, dynamic> json) => AuthModel(
        message: json["message"],
        accessToken: json["access_token"],
        tokenType: json["token_type"],
        data: json["data"] != null ? UserModel.fromJson(json["data"]) : null,
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "access_token": accessToken,
        "token_type": tokenType,
        "data": data!.toJson(),
      };
}
