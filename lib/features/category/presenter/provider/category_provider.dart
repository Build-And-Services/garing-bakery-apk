import 'package:flutter/foundation.dart';
import 'package:garing_bakery_apk/core/models/catgory_model.dart';
import 'package:garing_bakery_apk/features/category/data/service/category_service.dart';

class CategoryProvider with ChangeNotifier {
  bool _isLoading = true;
  List<CategoryModel> _categories = [];
  List<Map<String, dynamic>> _items = [];

  bool get isLoading => _isLoading;
  List<CategoryModel> get categories => _categories;
  List<Map<String, dynamic>> get items => _items;

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
}
