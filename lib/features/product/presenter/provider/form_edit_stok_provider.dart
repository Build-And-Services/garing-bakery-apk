import 'package:flutter/material.dart';
import 'package:garing_bakery_apk/core/config/theme.dart';
import 'package:garing_bakery_apk/features/product/data/model/request_product.dart';
import 'package:garing_bakery_apk/features/product/data/service/product_service.dart';

class FormStokProvider with ChangeNotifier {
  bool _isDone = false;
  bool _isLoading = false;
  EditStockRequest? _body;

  bool get isDone => _isDone;
  bool get isLoading => _isLoading;

  set stokNow(bool isDone) {
    _isDone = isDone;
    notifyListeners();
  }

  set loading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  set setBody(EditStockRequest data) {
    _body = data;
    notifyListeners();
  }

  Future<bool> updateStok(BuildContext context) async {
    MyTheme.showLoadingDialog(context);
    if (_body != null) {
      final result = await ProductService.updateStock(_body!);
      return result;
    }
    return false;
  }
}
