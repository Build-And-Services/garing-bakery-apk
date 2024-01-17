import 'package:flutter/foundation.dart';
import 'package:garing_bakery_apk/features/dashboard/data/model/dashboard_model.dart';
import 'package:garing_bakery_apk/features/dashboard/data/service/dashboard_service.dart';
import 'dart:developer';

class DashboardProvider with ChangeNotifier {
  DashboardModel _dashboardData = DashboardModel(success: false, message: '');

  DashboardModel get dashboardData => _dashboardData;
  set setDashboard(DashboardModel dashboardData) {
    _dashboardData = dashboardData;
    notifyListeners();
  }

  Future<void> getDataDashboard() async {
    try {
      DashboardModel data = await DashboardService.getDashboard();
      setDashboard = data;
      return;
    } catch (e) {
      log(e.toString());
      return;
    }
  }
}
