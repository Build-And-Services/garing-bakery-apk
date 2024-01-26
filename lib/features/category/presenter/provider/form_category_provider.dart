import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class FormCategoryProvider with ChangeNotifier {
  final ImagePicker picker = ImagePicker();
  final TextEditingController _name = TextEditingController();
  bool _isLoading = false;
  XFile? _image;

  bool get isLoading => _isLoading;

  XFile? get image => _image;

  Map<String, String> get body => {
        "name": _name.text,
      };

  TextEditingController get name => _name;

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

  set setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  clearForm() {
    _name.text = "";
    _image = null;
    notifyListeners();
  }

  Future getImage(ImageSource media) async {
    var img = await picker.pickImage(source: media);
    _image = img;
    notifyListeners();
  }
}
