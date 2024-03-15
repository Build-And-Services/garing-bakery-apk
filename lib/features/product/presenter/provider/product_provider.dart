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
  ProductDelResponse _responseDel =
      ProductDelResponse(success: false, message: '');

  List<ProductModel> get products => _products;
  bool get eventLoadingStatus => _eventLoadingStatus;
  ProductAddResponse get responseAdd => _responseAdd;
  ProductDelResponse get responseDel => _responseDel;
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

  Future<List<ProductModel>> getProduct() async {
    try {
      List<ProductModel> productsResp = await ProductService.allProducts();
      setProduct = productsResp;
      _eventLoadingStatus = false;
      notifyListeners();
      return productsResp;
    } catch (e) {
      log(e.toString());
      return [];
    }
  }

  Future delete(int id) async {
    try {
      final response = await ProductService.delete(id);
      _responseDel = response;
      if (response.success) {
        _products.removeWhere((item) => item.id == id);
      }
      notifyListeners();
    } catch (e) {
      log(e.toString());
    }
  }

  Future addProduct(Map<String, String> body, String image) async {
    try {
      final service = await ProductService.addImage(body, image);
      if (service.success) {
        _products.insert(0, service.data as ProductModel);
      }
      _responseAdd = service;
      notifyListeners();
    } catch (e) {
      _responseAdd =
          ProductAddResponse(success: false, message: "Terjadi kesalahan");
      notifyListeners();
    }
  }

  Future editData(Map<String, String> body, String image, String id) async {
    try {
      final service = await ProductService.addImage(
        body,
        image,
        id: id,
      );
      if (service.success) {
        _products.insert(0, service.data as ProductModel);
      }
      _responseAdd = service;
      notifyListeners();
    } catch (e) {
      _responseAdd =
          ProductAddResponse(success: false, message: "Terjadi kesalahan");
      notifyListeners();
    }
  }

  Future<ProductModel> getProductBy(String id) async {
    try {
      // check apakah id ada di dalam state _products
      if (_products.any((product) => product.id.toString() == id)) {
        // jika ada mengembalikan product yang dari state tanpa perlu mereload
        int index =
            _products.indexWhere((element) => element.id.toString() == id);
        return _products[index];
      }

      // get data jika belum ada
      final product = await ProductService.getProductById(id);
      if (product.data == null) {
        throw "Something wrong";
      }

      // return data
      return product.data!;
    } catch (e) {
      rethrow;
    }
  }
}
