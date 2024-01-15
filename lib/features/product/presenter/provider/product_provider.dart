import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:garing_bakery_apk/core/models/products_model.dart';
import 'package:garing_bakery_apk/features/product/data/service/product_service.dart';

class ProductProvider with ChangeNotifier {
  List<ProductModel> _products = [];
  final bool _isLoading = false;
  bool _eventLoadingStatus = true;

  List<ProductModel> get products => _products;
  bool get isLoading => _isLoading;
  bool get eventLoadingStatus => _eventLoadingStatus;

  set setLoading(bool loading) {
    _eventLoadingStatus = loading;
    notifyListeners();
  }

  set setProduct(List<ProductModel> newproduct) {
    _products = newproduct;
    notifyListeners();
  }

  Future getProduct() async {
    try {
      _eventLoadingStatus = true;
      List<ProductModel> productsResp = await ProductService.allProducts();
      setProduct = productsResp;
      _eventLoadingStatus = false;
      notifyListeners();
    } catch (e) {
      log(e.toString());
      // return [];
    }
  }
}
