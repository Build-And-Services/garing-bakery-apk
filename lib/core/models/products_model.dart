import 'dart:convert';

class ProductModel {
  final int id;
  final String name;
  final String image;
  final String productCode;
  final String category;
  final int quantity;
  final int purchasePrice;
  final int sellingPrice;

  ProductModel({
    required this.id,
    required this.name,
    required this.image,
    required this.productCode,
    required this.category,
    required this.quantity,
    required this.purchasePrice,
    required this.sellingPrice,
  });

  factory ProductModel.fromRawJson(String str) =>
      ProductModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        id: json["id"],
        name: json["name"],
        image: json["image"],
        productCode: json["product_code"],
        category: json["category"],
        quantity: json["quantity"],
        purchasePrice: json["purchase_price"],
        sellingPrice: json["selling_price"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image": image,
        "product_code": productCode,
        "category": category,
        "quantity": quantity,
        "purchase_price": purchasePrice,
        "selling_price": sellingPrice
      };
}
