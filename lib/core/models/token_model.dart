import 'dart:convert';

class TokenModel {
  final String accessToken;
  final String tokenType;

  TokenModel({
    required this.accessToken,
    required this.tokenType,
  });

  String getToken() => '$tokenType $accessToken';

  factory TokenModel.fromRawJson(String str) =>
      TokenModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TokenModel.fromJson(Map<String, dynamic> json) => TokenModel(
        accessToken: json["access_token"],
        tokenType: json["token_type"],
      );

  Map<String, dynamic> toJson() => {
        "access_token": accessToken,
        "token_type": tokenType,
      };
}
