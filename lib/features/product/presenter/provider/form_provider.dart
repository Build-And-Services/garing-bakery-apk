import 'package:flutter/material.dart';
import 'package:garing_bakery_apk/features/product/data/model/response_product.dart';
import 'package:garing_bakery_apk/features/product/data/service/product_service.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class FormProductProvider with ChangeNotifier {
  final ImagePicker picker = ImagePicker();
  final TextEditingController _name = TextEditingController();
  final TextEditingController _stock = TextEditingController();
  final TextEditingController _code = TextEditingController();
  final TextEditingController _purchase = TextEditingController();
  final TextEditingController _selling = TextEditingController();
  String _category = 'no';
  XFile? _image;

  TextEditingController get name => _name;
  TextEditingController get stock => _stock;
  TextEditingController get code => _code;
  TextEditingController get purchase => _purchase;
  TextEditingController get selling => _selling;
  String get category => _category;
  XFile? get image => _image;

  void clearController() {
    _name.clear();
    _stock.clear();
    _code.clear();
    _purchase.clear();
    _selling.clear();
    _category = 'no';
    print("dispose");
    _image = null;
  }

  set setCategory(String category) {
    _category = category;
    notifyListeners();
  }

  Future setImage(String url) async {
    final file = await DefaultCacheManager().getSingleFile(url);

    XFile result = XFile(file.path);
    _image = result;
    notifyListeners();
  }

  //we can upload image from camera or from gallery based on parameter
  Future getImage(ImageSource media) async {
    var img = await picker.pickImage(source: media);
    _image = img;
    notifyListeners();
  }

  imageNull() {
    _image = null;
    notifyListeners();
  }

  Map<String, String> get body => {
        "name": _name.text,
        "quantity": _stock.text,
        "product_code": _code.text,
        "purchase_price": _purchase.text,
        "selling_price": _selling.text,
        "category_id": _category,
      };

  String? required(value) {
    if (value == null || value.isEmpty) {
      return 'Please enter some text';
    }
    return null;
  }

  String? validateName(value) {
    String? mandatory = required(value);
    if (mandatory != null) {
      return mandatory;
    }

    if (value.toString().length < 2) {
      return "Please enter name more than two";
    }

    return null;
  }

  String? validateNumber(value) {
    String? mandatory = required(value);
    if (mandatory != null) {
      return mandatory;
    }
    return null;
  }

  String? validateSelect(value) {
    String? mandatory = required(value);
    if (mandatory != null) {
      return mandatory;
    }
    return null;
  }

  Future<ProductAddResponse> editData(String id) async {
    try {
      final service = await ProductService.updateProduct(
        body,
        image!.path,
        id: id,
      );
      return service;
    } catch (e) {
      return ProductAddResponse(
        success: false,
        message: "Product failed to update",
      );
    }
  }
}
