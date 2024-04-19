import 'package:flutter/material.dart';
import 'package:garing_bakery_apk/core/config/theme.dart';
import 'package:garing_bakery_apk/core/models/products_model.dart';
import 'package:garing_bakery_apk/core/models/user_model.dart';
import 'package:garing_bakery_apk/features/auth/data/service/token_service.dart';
import 'package:garing_bakery_apk/features/product/data/service/product_service.dart';
import 'package:garing_bakery_apk/features/transaction/data/model/cart_model.dart';
import 'package:garing_bakery_apk/features/transaction/data/model/reponse_add.dart';
import 'package:garing_bakery_apk/features/transaction/data/model/requests/request_transaction.dart';
import 'package:garing_bakery_apk/features/transaction/data/service/transaction_service.dart';

class CartProvider with ChangeNotifier {
  bool _isLoading = false;
  List<String> _nominal = [];
  List<CartModel> _cartList = [];
  List<ProductModel> _products = [];

  List<CartModel> get cartList => _cartList;
  List<ProductModel> get products => _products;
  bool get isLoading => _isLoading;

  Future<List<ProductModel>> getProduct() async {
    try {
      List<ProductModel> productsResp = await ProductService.allProducts();
      _products = productsResp;
      notifyListeners();
      return productsResp;
    } catch (e) {
      return [];
    }
  }

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

  set loading(bool loading) {
    _isLoading = loading;
    notifyListeners();
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
    } catch (e) {}
  }

  toggleCartProduct(ProductModel product, BuildContext context) {
    if (product.quantity != 0) {
      if (!isThereCart(product)) {
        _cartList.add(CartModel(1, product));
        _products = _products.map((p) {
          if (product.id == p.id) {
            return ProductModel(
              id: p.id,
              name: p.name,
              image: p.image,
              productCode: p.productCode,
              category: p.category,
              quantity: p.quantity - 1,
              purchasePrice: p.purchasePrice,
              sellingPrice: p.sellingPrice,
            );
          }
          return p;
        }).toList();
        notifyListeners();
        return;
      }
      _cartList = _cartList.map((e) {
        if (e.product.id == product.id) {
          return CartModel(e.count + 1, product);
        }
        return e;
      }).toList();

      _products = _products.map((p) {
        if (product.id == p.id) {
          return ProductModel(
            id: p.id,
            name: p.name,
            image: p.image,
            productCode: p.productCode,
            category: p.category,
            quantity: p.quantity - 1,
            purchasePrice: p.purchasePrice,
            sellingPrice: p.sellingPrice,
          );
        }
        return p;
      }).toList();
      notifyListeners();
      return;
    } else {
      MyTheme.alertError(context, "Stock sudah habis");
    }
  }

  minusCartProduct(ProductModel product) {
    _cartList = _cartList.map((e) {
      if (e.product.id == product.id) {
        return CartModel(e.count - 1, product);
      }
      return e;
    }).toList();
    _cartList = _cartList.where((element) => element.count > 0).toList();
    _products = _products.map((p) {
      if (product.id == p.id) {
        return ProductModel(
          id: p.id,
          name: p.name,
          image: p.image,
          productCode: p.productCode,
          category: p.category,
          quantity: p.quantity + 1,
          purchasePrice: p.purchasePrice,
          sellingPrice: p.sellingPrice,
        );
      }
      return p;
    }).toList();
    notifyListeners();
    return;
  }

  clear() {
    _cartList = [];
    _nominal = [];
    _products = [];
    notifyListeners();
  }

  Future<TransactionAddResponse?> addTransaction() async {
    List<OrderItem> orderitems = [];
    for (var cart in _cartList) {
      orderitems.add(
        OrderItem(
          productId: cart.product.id,
          quantity: cart.count,
        ),
      );
    }
    UserModel user = await TokenService.getCacheUser();
    OrderRequest body = OrderRequest(
      userId: user.id,
      nominal: nominal,
      orderItems: orderitems,
    );
    try {
      final result = await TransactionService.addTransaction(body);
      clear();
      return result;
    } catch (e) {
      print(e);
    }
    return null;
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
