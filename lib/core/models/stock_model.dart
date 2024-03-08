class StockModel {
  int id;
  int quantity;
  String type;
  int productId;
  DateTime createdAt;
  DateTime updatedAt;

  StockModel({
    required this.id,
    required this.quantity,
    required this.type,
    required this.productId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory StockModel.fromJson(Map<String, dynamic> json) => StockModel(
        id: json["id"],
        quantity: json["quantity"],
        type: json["type"],
        productId: json["product_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "quantity": quantity,
        "type": type,
        "product_id": productId,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
