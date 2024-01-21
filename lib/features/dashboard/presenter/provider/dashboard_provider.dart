import 'package:flutter/foundation.dart';
import 'package:garing_bakery_apk/features/dashboard/data/model/dashboard_model.dart';
import 'package:garing_bakery_apk/features/dashboard/data/service/dashboard_service.dart';
import 'dart:developer';

class DashboardProvider with ChangeNotifier {
  DashboardModel _dashboardData = DashboardModel(success: false, message: '');
  bool _loading = true;

  DashboardModel get dashboardData => _dashboardData;
  bool get loading => _loading;

  set setDashboard(DashboardModel dashboardData) {
    _dashboardData = dashboardData;
    notifyListeners();
  }

  Future<void> getDataDashboard() async {
    try {
      DashboardModel data = await DashboardService.getDashboard();
      setDashboard = data;
      _loading = false;
      return;
    } catch (e) {
      log(e.toString());
      return;
    }
  }
}
