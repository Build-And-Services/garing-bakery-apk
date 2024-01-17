import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:garing_bakery_apk/core/models/products_model.dart';
import 'package:garing_bakery_apk/features/product/data/model/response_product.dart';
import 'package:garing_bakery_apk/features/product/data/service/product_service.dart';

class ProductProvider with ChangeNotifier {
  List<ProductModel> _products = [];

  bool _eventLoadingStatus = true;
  bool _isLoading = false;
  ProductAddResponse _responseAdd =
      ProductAddResponse(success: false, message: "");

  List<ProductModel> get products => _products.reversed.toList();

  bool get eventLoadingStatus => _eventLoadingStatus;
  ProductAddResponse get responseAdd => _responseAdd;
  bool get isLoading => _isLoading;

  set isProccess(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

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
      List<ProductModel> productsResp = await ProductService.allProducts();
      setProduct = productsResp;
      _eventLoadingStatus = false;
      notifyListeners();
    } catch (e) {
      log(e.toString());
      // return [];
    }
  }

  Future<bool> delete(int id) async {
    try {
      _products.removeWhere((item) => item.id == id);
      notifyListeners();
      return true;
    } catch (e) {
      return false;
    }
  }

  Future addProduct(Map<String, String> body, String image) async {
    try {
      body["category_id"] = "1";
      final service = await ProductService.addImage(body, image);
      if (service.success) {
        _products.add(service.data as ProductModel);
      }
      _responseAdd = service;
      notifyListeners();
    } catch (e) {
      _responseAdd =
          ProductAddResponse(success: false, message: "Terjadi kesalahan");
      notifyListeners();
    }
  }
}
