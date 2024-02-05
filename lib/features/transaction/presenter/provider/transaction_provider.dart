import 'package:flutter/foundation.dart';
import 'package:garing_bakery_apk/features/transaction/data/model/response_transaction.dart';
import 'package:garing_bakery_apk/features/transaction/data/service/transaction_service.dart';

class TransactionProvider with ChangeNotifier {
  List<RespTransactionModel> _transactionsDay = [];
  List<RespTransactionModel> _transactionsMonth = [];
  List<RespTransactionModel> _transactionsYear = [];
  List<RespTransactionModel> _transactions = [];
  bool _isLoading = true;

  List<RespTransactionModel> get transactionsDay => _transactionsDay;
  List<RespTransactionModel> get transactionsMonth => _transactionsMonth;
  List<RespTransactionModel> get transactionsYear => _transactionsYear;
  List<RespTransactionModel> get transactions => _transactions;
  bool get isLoading => _isLoading;

  set setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  Future getTransaction(String filter) async {
    try {
      if (filter == 'all') {
        final resp = await TransactionService.allTransaction(filter);
        _transactions = resp;
      } else if (filter == 'month') {
        final resp = await TransactionService.allTransaction(filter);
        _transactionsMonth = resp;
      } else if (filter == 'year') {
        final resp = await TransactionService.allTransaction(filter);
        _transactionsYear = resp;
      } else {
        final resp = await TransactionService.allTransaction(filter);
        _transactionsDay = resp;
      }
      // print(_transactions);
      notifyListeners();
    } catch (e) {
      notifyListeners();
    }
  }
}
