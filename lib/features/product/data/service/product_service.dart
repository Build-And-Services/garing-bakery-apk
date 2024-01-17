import 'dart:convert';
import 'package:garing_bakery_apk/core/config/remote.dart';
import 'package:garing_bakery_apk/core/models/products_model.dart';
import 'package:garing_bakery_apk/features/product/data/model/response_product.dart';
import 'package:http/http.dart' as http;

class ProductService {
  static Future<List<ProductModel>> allProducts() async {
    List<ProductModel> products = [];
    try {
      final result = await http.get(Uri.parse(RemoteApi().PRODUCTS));
      if (result.statusCode == 200) {
        List data = jsonDecode(result.body)["data"];
        products = data.map((e) => ProductModel.fromJson(e)).toList();
        return products;
      }
      return products;
    } catch (e) {
      return products;
    }
  }

  static Future<ProductAddResponse> addImage(
      Map<String, String> body, String filepath) async {
    try {
      Map<String, String> headers = {
        'Content-Type': 'multipart/form-data',
      };
      var request =
          http.MultipartRequest('POST', Uri.parse(RemoteApi().PRODUCTS))
            ..fields.addAll(body)
            ..headers.addAll(headers)
            ..files.add(await http.MultipartFile.fromPath('image', filepath));
      var response = await request.send();
      var decoded = await response.stream.bytesToString().then(json.decode);
      late ProductAddResponse result;
      late ProductModel? data;
      if (response.statusCode == 201) {
        data = ProductModel(
          id: decoded["data"]["id"],
          name: decoded["data"]["name"],
          image: decoded["data"]["image"],
          productCode: decoded["data"]["product_code"],
          category: decoded["data"]["category"],
          quantity: int.parse(decoded["data"]["selling_price"]),
          purchasePrice: int.parse(decoded["data"]["selling_price"]),
          sellingPrice: int.parse(decoded["data"]["selling_price"]),
        );
      } else {
        data = null;
      }
      result = ProductAddResponse(
        success: decoded["success"],
        message: decoded["message"],
        data: data,
      );
      return result;
    } catch (e) {
      rethrow;
    }
  }
}
