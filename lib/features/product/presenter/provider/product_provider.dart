import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:garing_bakery_apk/core/models/products_model.dart';
import 'package:garing_bakery_apk/features/product/data/service/product_service.dart';

class ProductProvider with ChangeNotifier {
  List<ProductModel> _products = [];
  bool _isLoading = false;

  List<ProductModel> get products => _products;
  bool get isLoading => _isLoading;

  set setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  set setProduct(List<ProductModel> newproduct) {
    _products = newproduct;
    notifyListeners();
  }

  Future getProduct() async {
    try {
      List<ProductModel> productsResp = await ProductService.allProducts();
      setProduct = productsResp;
      notifyListeners();
      print(productsResp.toString());
      return productsResp;
    } catch (e) {
      log(e.toString());
      return [];
    }
  }
}
