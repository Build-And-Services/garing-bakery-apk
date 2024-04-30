import 'package:flutter/foundation.dart';
import 'package:garing_bakery_apk/features/dashboard/data/model/dashboard_model.dart';
import 'package:garing_bakery_apk/features/dashboard/data/service/dashboard_service.dart';

class DashboardProvider with ChangeNotifier {
  DashboardModel _dashboardData = DashboardModel(success: false, message: '');
  bool _loading = true;
  int _selectedTab = 0;

  DashboardModel get dashboardData => _dashboardData;
  bool get loading => _loading;
  int get selectedTab => _selectedTab;

  set setLoading(bool loading) {
    _loading = loading;
    notifyListeners();
  }

  set changeTab(int tab) {
    _selectedTab = tab;
    notifyListeners();
  }

  set setDashboard(DashboardModel dashboardData) {
    _dashboardData = dashboardData;
    notifyListeners();
  }

  Future<void> getDataDashboard() async {
    try {
      DashboardModel data = await DashboardService.getDashboard();
      setDashboard = data;
      _loading = false;
      notifyListeners();
      return;
    } catch (e) {
      _loading = false;
      notifyListeners();
      return;
    }
  }
}
