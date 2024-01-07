import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:garing_bakery_apk/features/dashboard/data/model/products_model.dart';
import 'package:garing_bakery_apk/features/dashboard/data/service/dashboard_service.dart';

class ProductProvider with ChangeNotifier {
  List<ProductModel> _products = [];

  List<ProductModel> get products => _products;
  set setProduct(List<ProductModel> newproduct) {
    _products = newproduct;
    notifyListeners();
  }

  Future getProduct() async {
    try {
      List<ProductModel> productsResp = await DashboardService.allProducts();
      setProduct = productsResp;
      return;
    } catch (e) {
      log(e.toString());
      return;
    }
  }
}
