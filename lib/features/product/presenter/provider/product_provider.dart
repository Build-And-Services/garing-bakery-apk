import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:garing_bakery_apk/core/models/products_model.dart';
import 'package:garing_bakery_apk/features/product/data/model/response_product.dart';
import 'package:garing_bakery_apk/features/product/data/service/product_service.dart';
import 'package:garing_bakery_apk/features/product/presenter/provider/form_provider.dart';

class ProductProvider with ChangeNotifier {
  List<ProductModel> _products = [];
  List<ProductModel> _productsTemp = [];
  ProductModel? _product;

  bool _eventLoadingStatus = true;
  bool _isLoading = false;
  bool _isLoadingDetail = true;
  ProductAddResponse _responseAdd =
      ProductAddResponse(success: false, message: "");
  ProductDelResponse _responseDel =
      ProductDelResponse(success: false, message: '');

  List<ProductModel> get products => _products;
  List<ProductModel> get productsTemp => _productsTemp;
  ProductModel? get product => _product;
  bool get eventLoadingStatus => _eventLoadingStatus;
  ProductAddResponse get responseAdd => _responseAdd;
  ProductDelResponse get responseDel => _responseDel;
  bool get isLoading => _isLoading;
  bool get isLoadingDetail => _isLoadingDetail;

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

  void filter(String keyword) {
    if (keyword == "") {
      debugPrint("search: Asu");
      _products = _productsTemp;
    } else {
      _products = _productsTemp
          .where(
            (product) => product.name.toLowerCase().contains(
                  keyword.toLowerCase(),
                ),
          )
          .toList();
    }
    notifyListeners();
  }

  Future<List<ProductModel>> getProduct() async {
    try {
      List<ProductModel> productsResp = await ProductService.allProducts();
      setProduct = productsResp;
      _productsTemp = productsResp;
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

  Future<ProductModel> getProductBy(String id,
      {FormProductProvider? formProductProvider,
      List<Map<String, dynamic>>? items}) async {
    try {
      print("edit");
      late ProductModel product;

      // get data jika belum ada
      final productResponse = await ProductService.getProductById(id);
      if (productResponse.data == null) {
        throw "Something wrong";
      }

      product = productResponse.data!;

      if (items != null) {
        if (items.isNotEmpty) {
          if (items
                  .where((element) => element['label'] == product.category)
                  .isNotEmpty &&
              formProductProvider != null) {
            if (product.category == null) {
              formProductProvider.setCategory = 'no';
            } else {
              formProductProvider.setCategory = items
                  .where((element) => element['label'] == product.category)
                  .toList()[0]["value"]
                  .toString();
            }
            formProductProvider.name.text = product.name;
            formProductProvider.stock.text = product.quantity.toString();
            formProductProvider.code.text = product.productCode;
            formProductProvider.purchase.text =
                product.purchasePrice.toString();
            formProductProvider.selling.text = product.sellingPrice.toString();
          }
        }
      }
      _isLoadingDetail = false;
      _product = product;
      notifyListeners();

      // return data
      return product;
    } catch (e) {
      rethrow;
    }
  }

  editProduct(ProductModel data) {
    _products = _products.map((e) {
      if (e.id == data.id) {
        return data;
      }
      return e;
    }).toList();
    notifyListeners();
  }
}
