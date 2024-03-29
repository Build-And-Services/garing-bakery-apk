import 'dart:convert';

import 'package:garing_bakery_apk/core/models/products_model.dart';

class RespTransactionModel {
  final int id;
  final int nominal;
  final String userId;
  final int totalPembelian;
  final int productLength;
  final String createdAt;

  RespTransactionModel({
    required this.id,
    required this.nominal,
    required this.userId,
    required this.totalPembelian,
    required this.productLength,
    required this.createdAt,
  });

  factory RespTransactionModel.fromRawJson(String str) =>
      RespTransactionModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory RespTransactionModel.fromJson(Map<String, dynamic> json) =>
      RespTransactionModel(
        id: json["id"],
        nominal: json["nominal"],
        userId: json["user_id"],
        totalPembelian: json["total_pembelian"],
        productLength: json["product_length"],
        createdAt: json["created_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nominal": nominal,
        "user_id": userId,
        "total_pembelian": totalPembelian,
        "product_lenth": productLength,
        "created_at": createdAt,
        // "order_items": List<dynamic>.from(orderItems.map((x) => x)),
      };
}

class OrderItems {
  final int id;
  final int productId;
  final int orderId;
  final int quantity;
  final DateTime createdAt;
  final DateTime updatedAt;
  final ProductModel products;

  OrderItems({
    required this.id,
    required this.productId,
    required this.orderId,
    required this.quantity,
    required this.createdAt,
    required this.updatedAt,
    required this.products,
  });

  factory OrderItems.fromRawJson(String str) =>
      OrderItems.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory OrderItems.fromJson(Map<String, dynamic> json) => OrderItems(
        id: json["id"],
        productId: json["product_id"],
        orderId: json["order_id"],
        quantity: json["quantity"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        products: ProductModel.fromJson(json["products"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "product_id": productId,
        "order_id": orderId,
        "quantity": quantity,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "products": products.toJson(),
      };
}
