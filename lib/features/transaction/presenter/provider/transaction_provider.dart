import 'package:flutter/foundation.dart';
import 'package:garing_bakery_apk/features/transaction/data/model/response_transaction.dart';
import 'package:garing_bakery_apk/features/transaction/data/service/transaction_service.dart';

class TransactionProvider with ChangeNotifier {
  Future<List<RespTransactionModel>> getTransaction(String filter) async {
    try {
      List<RespTransactionModel> resp = [];
      if (filter == 'all') {
        resp = await TransactionService.allTransaction(filter);
      } else if (filter == 'month') {
        resp = await TransactionService.allTransaction(filter);
      } else if (filter == 'year') {
        resp = await TransactionService.allTransaction(filter);
      } else {
        resp = await TransactionService.allTransaction(filter);
      }
      notifyListeners();
      return resp;
    } catch (e) {
      rethrow;
    }
  }
}
