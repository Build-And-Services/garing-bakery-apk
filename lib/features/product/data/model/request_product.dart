class EditStockRequest {
  int quantity;
  String type;
  int productId;

  EditStockRequest({
    required this.quantity,
    required this.type,
    required this.productId,
  });

  factory EditStockRequest.fromJson(Map<String, dynamic> json) =>
      EditStockRequest(
        quantity: json["quantity"],
        type: json["type"],
        productId: json["product_id"],
      );

  Map<String, dynamic> toJson() => {
        "quantity": quantity,
        "type": type,
        "product_id": productId,
      };
}
