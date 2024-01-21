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

class CategoryAddResponse {
  final bool success;
  final String message;
  final CategoryModel? data;

  CategoryAddResponse({
    required this.success,
    required this.message,
    this.data,
  });

  factory CategoryAddResponse.fromRawJson(String str) =>
      CategoryAddResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CategoryAddResponse.fromJson(Map<String, dynamic> json) =>
      CategoryAddResponse(
        success: json["success"],
        message: json["message"],
        data: CategoryModel.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": {},
      };
}
