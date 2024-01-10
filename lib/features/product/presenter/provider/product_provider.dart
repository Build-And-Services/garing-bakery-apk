import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:garing_bakery_apk/core/models/products_model.dart';
import 'package:garing_bakery_apk/features/product/data/service/product_service.dart';

class ProductProvider with ChangeNotifier {
  List<ProductModel> _products = [];

  List<ProductModel> get products => _products;
  set setProduct(List<ProductModel> newproduct) {
    _products = newproduct;
    notifyListeners();
  }

  Future getProduct() async {
    try {
      List<ProductModel> productsResp = await ProductService.allProducts();
      setProduct = productsResp;
      return;
    } catch (e) {
      log(e.toString());
      return;
    }
  }
}
