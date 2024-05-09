import 'package:garing_bakery_apk/core/models/categories_model.dart';
import 'package:garing_bakery_apk/core/models/products_model.dart';

class DashboardModel {
  bool success;
  String message;
  Data? data;

  DashboardModel({
    required this.success,
    required this.message,
    this.data,
  });

  factory DashboardModel.fromJson(Map<String, dynamic> json) => DashboardModel(
        success: json["success"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        // ignore: prefer_null_aware_operators
        "data": data == null ? null : data?.toJson()
      };
}

class Data {
  List<CategoryModel> categories;
  List<ProductModel> products;

  Data({
    required this.categories,
    required this.products,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        categories: List<CategoryModel>.from(
            json["categories"].map((x) => CategoryModel.fromJson(x))),
        products: List<ProductModel>.from(
            json["products"].map((x) => ProductModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "categories": List<dynamic>.from(categories.map((x) => x.toJson())),
        "products": List<dynamic>.from(products.map((x) => x.toJson())),
      };
}
