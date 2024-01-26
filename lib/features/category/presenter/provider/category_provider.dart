import 'package:flutter/foundation.dart';
import 'package:garing_bakery_apk/core/models/catgory_model.dart';
import 'package:garing_bakery_apk/features/category/data/model/response_category.dart';
import 'package:garing_bakery_apk/features/category/data/service/category_service.dart';

class CategoryProvider with ChangeNotifier {
  bool _isLoading = true;
  bool _proccess = false;
  List<CategoryModel> _categories = [];
  List<Map<String, dynamic>> _items = [];
  CategoryAddResponse _responseAdd =
      CategoryAddResponse(success: false, message: "");

  bool get proccess => _proccess;
  bool get isLoading => _isLoading;
  List<CategoryModel> get categories => _categories;
  CategoryAddResponse get responseAdd => _responseAdd;
  List<Map<String, dynamic>> get items => _items;

  set isProccess(bool proccess) {
    _proccess = proccess;
    notifyListeners();
  }

  Future getCategories() async {
    try {
      _categories = await CategoryService.getCategory();
      _items = _categories.map(
        (e) {
          return {
            'value': e.id,
            'label': e.name,
          };
        },
      ).toList();
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      // return [];
    }
  }

  Future addCategory(Map<String, String> body, String image) async {
    try {
      final response = await CategoryService.addCategory(body, image);
      _responseAdd = response;
      if (response.data != null) {
        _categories.insert(0, response.data as CategoryModel);
      }
      notifyListeners();
    } catch (e) {
      _responseAdd = CategoryAddResponse(success: false, message: e.toString());
      notifyListeners();
    }
  }

  Future delete(int id) async {
    try {
      final response = await CategoryService.deleteCategory(id);
      // _categories =
      // _categories.removeWhere((item) => item.id == id);
    } catch (e) {}
  }
}
