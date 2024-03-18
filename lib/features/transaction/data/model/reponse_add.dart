class TransactionAddResponse {
  int id;
  String cashier;
  int nominal;
  int totalPrice;
  DateTime createdAt = DateTime.now();
  int change;
  List<DetailTransactionsResponse> details;

  TransactionAddResponse({
    required this.id,
    required this.cashier,
    required this.nominal,
    required this.totalPrice,
    required this.createdAt,
    required this.change,
    required this.details,
  });

  factory TransactionAddResponse.fromJson(Map<String, dynamic> json) =>
      TransactionAddResponse(
        id: json["id"],
        cashier: json["cashier"],
        nominal: json["nominal"],
        totalPrice: json["total_price"],
        createdAt: DateTime.parse(json["created_at"]),
        change: json["change"],
        details: List<DetailTransactionsResponse>.from(
          json["details"].map(
            (x) => DetailTransactionsResponse.fromJson(x),
          ),
        ),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "cashier": cashier,
        "nominal": nominal,
        "total_price": totalPrice,
        "created_at": createdAt.toIso8601String(),
        "change": change,
        "details": List<dynamic>.from(
          details.map(
            (x) => x.toJson(),
          ),
        ),
      };
}

class DetailTransactionsResponse {
  int quantity;
  String productsName;
  String productImage;
  int sellingPrice;
  String? categoryName;

  DetailTransactionsResponse({
    required this.quantity,
    required this.productsName,
    required this.productImage,
    required this.sellingPrice,
    required this.categoryName,
  });

  factory DetailTransactionsResponse.fromJson(Map<String, dynamic> json) =>
      DetailTransactionsResponse(
        quantity: json["quantity"],
        productsName: json["products_name"],
        productImage: json["product_image"],
        sellingPrice: json["selling_price"],
        categoryName: json["category_name"],
      );

  Map<String, dynamic> toJson() => {
        "quantity": quantity,
        "products_name": productsName,
        "product_image": productImage,
        "selling_price": sellingPrice,
        "category_name": categoryName,
      };
}
