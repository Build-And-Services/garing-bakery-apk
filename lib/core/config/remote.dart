// ignore_for_file: non_constant_identifier_names

class RemoteApi {
  final String API_BASE_URL = "https://gading-bakery.com";

  String get LOGIN => '$API_BASE_URL/api/login';
  String get PRODUCTS => '$API_BASE_URL/api/v1/products';
  String get CATEGORIES => '$API_BASE_URL/api/v1/categories';
  String get STOCKS => '$API_BASE_URL/api/v1/stocks';
  String get LAPORAN => '$API_BASE_URL/api/v1/reports';
  String get TRANSACTION => '$API_BASE_URL/api/v1/transactions';
  String get DASHBOARD => '$API_BASE_URL/api/v1/dashboard';
  String get REPORT_TRANSACTIONS => '$API_BASE_URL/api/v1/report-transactions';
  String get REPORTS => '$API_BASE_URL/api/v1/reports';
  String get REPORTSTOEXCEL => '$API_BASE_URL/api/v1/report-transaction-orders';
  String get PROFILE => '$API_BASE_URL/api/v1/profile';
}
