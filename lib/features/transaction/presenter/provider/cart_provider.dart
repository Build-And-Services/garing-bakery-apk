import 'package:flutter/material.dart';
import 'package:garing_bakery_apk/core/models/products_model.dart';
import 'package:garing_bakery_apk/features/transaction/data/model/cart_model.dart';

class CartProvider with ChangeNotifier {
  List<String> _nominal = [];
  List<CartModel> _cartList = [];

  List<CartModel> get cartList => _cartList;

  int get nominal {
    if (_nominal.isEmpty) {
      return 0;
    }
    String temp = "";
    for (var element in _nominal) {
      temp += element;
    }
    return int.parse(temp);
  }

  set setCartList(List<CartModel> products) {
    _cartList = products;
    notifyListeners();
  }

  set setNominal(String key) {
    try {
      if (key == "C") {
        _nominal = [];
      } else if (key == "x") {
        _nominal.removeLast();
      } else if (key == ".") {
      } else {
        if (key == "000") {
          _nominal.add("0");
          _nominal.add("0");
          _nominal.add("0");
        } else {
          _nominal.add(key);
        }
      }
      notifyListeners();
    } catch (e) {
      print(e.toString());
      print(key);
    }
  }

  toggleCartProduct(ProductModel product, String type) {
    if (type == "increase") {
      if (!isThereCart(product)) {
        _cartList.add(CartModel(1, product));
        notifyListeners();
        return;
      }
      _cartList = _cartList.map((e) {
        if (e.product.id == product.id) {
          return CartModel(e.count + 1, product);
        }
        return e;
      }).toList();
    } else {}
    notifyListeners();
    return;
  }

  minusCartProduct(ProductModel product) {
    _cartList = _cartList.map((e) {
      if (e.product.id == product.id) {
        return CartModel(e.count - 1, product);
      }
      return e;
    }).toList();
    _cartList = _cartList.where((element) => element.count > 0).toList();
    notifyListeners();
    return;
  }

  CartModel getCart(ProductModel product) {
    return _cartList.firstWhere((element) => element.product.id == product.id);
  }

  bool isThereCart(ProductModel product) {
    return _cartList.any((element) => element.product.id == product.id);
  }

  bool checkNominal() {
    if (nominal < getTotal) {
      return false;
    }
    return true;
  }

  int get getTotal {
    int total = 0;
    for (var element in _cartList) {
      total += element.count * element.product.sellingPrice;
    }
    return total;
  }
}
