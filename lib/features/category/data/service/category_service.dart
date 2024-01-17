import 'dart:convert';

import 'package:garing_bakery_apk/core/config/remote.dart';
import 'package:garing_bakery_apk/core/models/catgory_model.dart';
import 'package:http/http.dart' as http;

class CategoryService {
  static Future<List<CategoryModel>> getCategory() async {
    List<CategoryModel> categories = [];
    try {
      final result = await http.get(Uri.parse(RemoteApi().CATEGORIES));
      if (result.statusCode == 200) {
        List data = jsonDecode(result.body)["data"];
        categories = data.map((e) => CategoryModel.fromJson(e)).toList();
        return categories;
      }
      return categories;
    } catch (e) {
      return categories;
    }
  }
}
