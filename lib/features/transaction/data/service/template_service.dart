import 'dart:convert';
import 'package:garing_bakery_apk/core/config/remote.dart';
import 'package:garing_bakery_apk/features/transaction/data/model/response_transaction.dart';
import 'package:http/http.dart' as http;

class TransactionService {
  static Future<List<RespTransactionModel>> allTransaction() async {
    List<RespTransactionModel> products = [];
    try {
      final result = await http.get(Uri.parse(RemoteApi().TRANSACTION));
      if (result.statusCode == 200) {
        List data = jsonDecode(result.body)["data"];
        products = data.map((e) => RespTransactionModel.fromJson(e)).toList();
        return products;
      }
      return products;
    } catch (e) {
      return products;
    }
  }
}
