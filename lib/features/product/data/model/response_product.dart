import 'dart:convert';
import 'package:garing_bakery_apk/core/models/products_model.dart';

class ProductAddResponse {
  final bool success;
  final String message;
  final ProductModel? data;

  ProductAddResponse({
    required this.success,
    required this.message,
    this.data,
  });

  factory ProductAddResponse.fromRawJson(String str) =>
      ProductAddResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ProductAddResponse.fromJson(Map<String, dynamic> json) =>
      ProductAddResponse(
        success: json["success"],
        message: json["message"],
        data: ProductModel.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data ?? data?.toJson(),
      };
}
