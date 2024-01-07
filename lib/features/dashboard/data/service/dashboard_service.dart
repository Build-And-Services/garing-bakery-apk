import 'dart:convert';

import 'package:garing_bakery_apk/core/config/remote.dart';
import 'package:garing_bakery_apk/features/dashboard/data/model/products_model.dart';
import 'package:http/http.dart' as http;

class DashboardService {
  static Future<List<ProductModel>> allProducts() async {
    List<ProductModel> products = [];
    try {
      final result = await http.get(Uri.parse(RemoteApi().PRODUCTS));
      if (result.statusCode == 200) {
        List data = jsonDecode(result.body)["data"];
        products = data.map((e) => ProductModel.fromJson(e)).toList();
        return products;
      }
      return products;
    } catch (e) {
      return products;
    }
  }
}
