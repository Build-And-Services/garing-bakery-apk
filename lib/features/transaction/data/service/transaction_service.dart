import 'dart:convert';
import 'package:garing_bakery_apk/core/config/remote.dart';
import 'package:garing_bakery_apk/features/auth/data/service/token_service.dart';
import 'package:garing_bakery_apk/features/transaction/data/model/requests/request_transaction.dart';
import 'package:garing_bakery_apk/features/transaction/data/model/response_transaction.dart';
import 'package:http/http.dart' as http;

class TransactionService {
  static Future<List<RespTransactionModel>> allTransaction(
      String filter) async {
    List<RespTransactionModel> products = [];
    try {
      late http.Response result;
      if (filter == 'all') {
        result = await http.get(Uri.parse(RemoteApi().TRANSACTION));
      } else {
        result = await http
            .get(Uri.parse('${RemoteApi().TRANSACTION}/filter/$filter'));
      }
      if (result.statusCode == 200) {
        List data = jsonDecode(result.body)["data"];
        products = data.map((e) => RespTransactionModel.fromJson(e)).toList();
        return products;
      }
      return products;
    } catch (e) {
      print(e);
      return products;
    }
  }

  static Future<http.Response> addTransaction(OrderRequest order) async {
    try {
      final token = await TokenService.getToken();

      print(jsonEncode(order.toJson()));
      final result = await http.post(
        Uri.parse(RemoteApi().TRANSACTION),
        headers: {
          'Content-Type': 'application/json',
          "Authorization": token,
        },
        body: jsonEncode(order.toJson()),
      );
      return result;
    } catch (e) {
      rethrow;
    }
  }
}
