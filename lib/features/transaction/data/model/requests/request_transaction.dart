class OrderRequest {
  int userId;
  int nominal;
  List<OrderItem> orderItems;

  OrderRequest({
    required this.userId,
    required this.nominal,
    required this.orderItems,
  });

  factory OrderRequest.fromJson(Map<String, dynamic> json) => OrderRequest(
        userId: json["user_id"],
        nominal: json["nominal"],
        orderItems: List<OrderItem>.from(
            json["order_items"].map((x) => OrderItem.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId.toString(),
        "nominal": nominal.toString(),
        "order_items": List<dynamic>.from(orderItems.map((x) => x.toJson())),
      };
}

class OrderItem {
  int productId;
  int quantity;

  OrderItem({
    required this.productId,
    required this.quantity,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) => OrderItem(
        productId: json["product_id"],
        quantity: json["quantity"],
      );

  Map<String, dynamic> toJson() => {
        "product_id": productId.toString(),
        "quantity": quantity.toString(),
      };
}
