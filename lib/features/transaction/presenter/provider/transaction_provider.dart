import 'package:flutter/foundation.dart';
import 'package:garing_bakery_apk/features/transaction/data/model/response_transaction.dart';
import 'package:garing_bakery_apk/features/transaction/data/service/transaction_service.dart';

class TransactionProvider with ChangeNotifier {
  List<RespTransactionModel> _transactions = [];
  bool _isLoading = true;

  List<RespTransactionModel> get transactions => _transactions;
  bool get isLoading => _isLoading;

  set setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  Future getTransaction() async {
    try {
      final resp = await TransactionService.allTransaction();
      _transactions = resp;
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      notifyListeners();
    }
  }
}
