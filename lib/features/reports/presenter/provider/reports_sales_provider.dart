import 'package:flutter/foundation.dart';

class ReportsSalesProvider with ChangeNotifier {
  DateTime _dateTime = DateTime.now();
  String _dropdownvalue = 'Today';
  bool _isLoading = false;

  final List<String> _filter = [
    'Today',
    'Yesterday',
    'Custom',
  ];
  String get dropdownValue => _dropdownvalue;
  List<String> get filter => _filter;
  bool get isLoading => _isLoading;
  DateTime get dateTime => _dateTime;

  set dateTime(DateTime dateTime) {
    _dateTime = dateTime;
    notifyListeners();
  }

  set isLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  set dropdownValue(String value) {
    _dropdownvalue = value;
    notifyListeners();
  }
}
