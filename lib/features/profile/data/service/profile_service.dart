import 'dart:convert';

import 'package:garing_bakery_apk/core/config/remote.dart';
import 'package:garing_bakery_apk/core/models/user_model.dart';
import 'package:garing_bakery_apk/features/auth/data/service/token_service.dart';
import 'package:garing_bakery_apk/features/profile/data/model/response.dart';
import 'package:http/http.dart' as http;

class ProfileService {
  static Future<ProfileUpdateResponse> update(
      Map<String, String> body, String filepath, String id) async {
    try {
      final token = await TokenService.getToken();
      Map<String, String> headers = {
        'Content-Type': 'multipart/form-data',
        'Authorization': "Bearer $token"
      };
      var request =
          http.MultipartRequest('POST', Uri.parse('${RemoteApi().PROFILE}/$id'))
            ..fields.addAll(body)
            ..headers.addAll(headers)
            ..files.add(await http.MultipartFile.fromPath('image', filepath));
      // print(request.fields);
      var response = await request.send();
      var decoded = await response.stream.bytesToString().then(json.decode);
      late ProfileUpdateResponse result;
      late UserModel? data;
      if (response.statusCode == 202) {
        data = UserModel(
          id: decoded["data"]["id"],
          name: decoded["data"]["name"],
          email: decoded["data"]["email"],
          image: decoded["data"]["image"],
          role: decoded["data"]["role"],
        );
      } else {
        return ProfileUpdateResponse(
          success: false,
          message: decoded["error"],
          data: null,
        );
      }
      result = ProfileUpdateResponse(
        success: decoded["success"],
        message: decoded["message"],
        data: data,
        accessToken: decoded["access_token"],
        tokenType: decoded["token_type"],
      );
      return result;
    } catch (e) {
      rethrow;
    }
  }
}
