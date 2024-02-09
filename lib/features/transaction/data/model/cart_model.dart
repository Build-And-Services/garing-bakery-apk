import 'package:garing_bakery_apk/core/models/products_model.dart';

class CartModel {
  int count;
  final ProductModel product;
  CartModel(this.count, this.product);

  set setCount(int newCount) {
    count = newCount;
  }
}
