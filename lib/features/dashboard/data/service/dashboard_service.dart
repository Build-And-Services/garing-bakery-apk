import 'dart:convert';
import 'package:garing_bakery_apk/core/config/remote.dart';
import 'package:garing_bakery_apk/features/dashboard/data/model/dashboard_model.dart';
import 'package:http/http.dart' as http;

class DashboardService {
  static Future<DashboardModel> getDashboard() async {
    // Map<String, dynamic> dashboard = {};
    try {
      final result = await http.get(Uri.parse(RemoteApi().DASHBOARD));
      if (result.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(result.body);
        return DashboardModel.fromJson(data);
      }
      return DashboardModel.fromJson({});
    } catch (e) {
      rethrow;
    }
  }
}
