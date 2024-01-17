import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class FormProductProvider with ChangeNotifier {
  final ImagePicker picker = ImagePicker();
  final TextEditingController _name = TextEditingController();
  final TextEditingController _stock = TextEditingController();
  final TextEditingController _code = TextEditingController();
  final TextEditingController _purchase = TextEditingController();
  final TextEditingController _selling = TextEditingController();
  final TextEditingController _category = TextEditingController();
  XFile? _image;

  TextEditingController get name => _name;
  TextEditingController get stock => _stock;
  TextEditingController get code => _code;
  TextEditingController get purchase => _purchase;
  TextEditingController get selling => _selling;
  TextEditingController get category => _category;
  XFile? get image => _image;

  void clearController() {
    _name.clear();
    _stock.clear();
    _code.clear();
    _purchase.clear();
    _selling.clear();
    _category.clear();
    _image = null;
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
        "category_id": _category.text,
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
}
