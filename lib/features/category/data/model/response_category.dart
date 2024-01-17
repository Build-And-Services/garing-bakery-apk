import 'dart:convert';

import 'package:garing_bakery_apk/core/models/catgory_model.dart';

class CategoryGetResponse {
  final bool success;
  final String message;
  final List<CategoryModel> data;

  CategoryGetResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory CategoryGetResponse.fromRawJson(String str) =>
      CategoryGetResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CategoryGetResponse.fromJson(Map<String, dynamic> json) =>
      CategoryGetResponse(
        success: json["success"],
        message: json["message"],
        data: List<CategoryModel>.from(json["data"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": List<CategoryModel>.from(data.map((x) => x)),
      };
}
