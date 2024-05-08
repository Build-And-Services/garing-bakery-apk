import 'package:garing_bakery_apk/core/models/user_model.dart';

class ProfileUpdateResponse {
  bool success;
  String message;
  UserModel? data;
  String? accessToken;
  String? tokenType;

  ProfileUpdateResponse({
    required this.success,
    required this.message,
    this.data,
    this.accessToken,
    this.tokenType,
  });

  factory ProfileUpdateResponse.fromJson(Map<String, dynamic> json) =>
      ProfileUpdateResponse(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null ? null : UserModel.fromJson(json["data"]),
        accessToken: json["access_token"],
        tokenType: json["token_type"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data?.toJson(),
        "access_token": accessToken,
        "token_type": tokenType,
      };
}
