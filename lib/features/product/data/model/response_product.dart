import 'dart:convert';
import 'package:garing_bakery_apk/core/models/products_model.dart';
import 'package:garing_bakery_apk/core/models/stock_model.dart';

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

class ProductDelResponse {
  final bool success;
  final String message;
  final ProductModel? data;

  ProductDelResponse({
    required this.success,
    required this.message,
    this.data,
  });

  factory ProductDelResponse.fromRawJson(String str) =>
      ProductDelResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ProductDelResponse.fromJson(Map<String, dynamic> json) =>
      ProductDelResponse(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null ? null : ProductModel.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data?.toJson(),
      };
}

class ProductResponse {
  bool success;
  String message;
  ProductModel? data;

  ProductResponse({
    required this.success,
    required this.message,
    this.data,
  });

  factory ProductResponse.fromJson(Map<String, dynamic> json) =>
      ProductResponse(
        success: json["success"],
        message: json["message"],
        data: ProductModel.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        // ignore: prefer_null_aware_operators
        "data": data != null ? data?.toJson() : null,
      };
}

class ProductStockModel {
  final int id;
  final String name;
  final String image;
  final String productCode;
  final String? category;
  final int purchasePrice;
  final int sellingPrice;

  ProductStockModel({
    required this.id,
    required this.name,
    required this.image,
    required this.productCode,
    required this.category,
    required this.purchasePrice,
    required this.sellingPrice,
  });

  factory ProductStockModel.fromRawJson(String str) =>
      ProductStockModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ProductStockModel.fromJson(Map<String, dynamic> json) =>
      ProductStockModel(
        id: json["id"],
        name: json["name"],
        image: json["image"],
        productCode: json["product_code"],
        category: json["category"],
        purchasePrice: json["purchase_price"],
        sellingPrice: json["selling_price"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image": image,
        "product_code": productCode,
        "category": category,
        "purchase_price": purchasePrice,
        "selling_price": sellingPrice
      };
}

class StockProductResponse {
  ProductStockModel product;
  List<StockModel> stock;
  int totalQuantity;
  int totalResidual;

  StockProductResponse({
    required this.product,
    required this.stock,
    required this.totalQuantity,
    required this.totalResidual,
  });

  factory StockProductResponse.fromJson(Map<String, dynamic> json) =>
      StockProductResponse(
        product: ProductStockModel.fromJson(json["product"]),
        totalQuantity: json["totalQuantity"],
        totalResidual: json["totalResidual"],
        stock: List<StockModel>.from(
          json['stocks'].map(
            (stock) => StockModel.fromJson(stock),
          ),
        ),
      );
}
