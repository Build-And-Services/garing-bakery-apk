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
      print(e.toString());
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

  static Future<ProductDelResponse> delete(int id) async {
    try {
      final response =
          await http.delete(Uri.parse('${RemoteApi().PRODUCTS}/$id'));
      final body = jsonDecode(response.body);
      return ProductDelResponse.fromJson(body);
    } catch (e) {
      return ProductDelResponse(
        success: false,
        message: "terjadi kesalahan di server",
      );
    }
  }

  static Future<ProductResponse> getProductById(String id) async {
    try {
      final result = await http.get(Uri.parse("${RemoteApi().PRODUCTS}/$id"));

      if (result.statusCode != 200) {
        return ProductResponse(
            success: false, message: "Something when wrong!!");
      }

      ProductResponse data = ProductResponse.fromJson(jsonDecode(result.body));
      return data;
    } catch (e) {
      rethrow;
    }
  }

  static Future<StockProductResponse?> getStockProduct(String id) async {
    try {
      final result =
          await http.get(Uri.parse("${RemoteApi().PRODUCTS}/$id/stocks"));

      if (result.statusCode != 200) {
        return null;
      }
      final response = jsonDecode(result.body);
      StockProductResponse data =
          StockProductResponse.fromJson(response["data"]);
      return data;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  static Future<ProductModel?> getProduct(String id) async {
    try {
      final result = await http.get(Uri.parse("${RemoteApi().PRODUCTS}/$id"));

      if (result.statusCode != 200) {
        return null;
      }
      final response = jsonDecode(result.body);
      ProductModel data = ProductModel.fromJson(response["data"]);
      return data;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
