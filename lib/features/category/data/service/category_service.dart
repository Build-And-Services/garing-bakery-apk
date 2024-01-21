import 'dart:convert';

import 'package:garing_bakery_apk/core/config/remote.dart';
import 'package:garing_bakery_apk/core/models/catgory_model.dart';
import 'package:garing_bakery_apk/features/category/data/model/response_category.dart';
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

  static Future<CategoryAddResponse> addCategory(
      Map<String, String> body, image) async {
    try {
      Map<String, String> headers = {
        'Content-Type': 'multipart/form-data',
      };
      var request =
          http.MultipartRequest('POST', Uri.parse(RemoteApi().CATEGORIES))
            ..fields.addAll(body)
            ..headers.addAll(headers)
            ..files.add(await http.MultipartFile.fromPath('image', image));
      var response = await request.send();
      var decoded = await response.stream.bytesToString().then(json.decode);
      late CategoryAddResponse result;
      late CategoryModel? data;
      if (response.statusCode == 201) {
        data = CategoryModel(
          id: decoded["data"]["id"],
          name: decoded["data"]["name"],
          image: decoded["data"]["image"],
        );
      } else {
        data = null;
      }
      result = CategoryAddResponse(
        success: decoded["success"],
        message: decoded["message"],
        data: data,
      );
      return result;
    } catch (e) {
      return CategoryAddResponse(success: false, message: e.toString());
    }
  }
}
