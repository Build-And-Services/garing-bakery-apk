import 'dart:convert';

import 'package:garing_bakery_apk/core/config/remote.dart';
import 'package:garing_bakery_apk/features/reports/data/model/response.dart';
import 'package:http/http.dart' as http;

class ReportsService {
  static Future<ReportTransactionsResponse> getAllTransactions() async {
    try {
      final result = await http.get(Uri.parse(RemoteApi().REPORT_TRANSACTIONS));

      if (result.statusCode != 200) {
        return ReportTransactionsResponse(
          status: false,
          message: "Something when wrong!!",
          data: [],
        );
      }
      ReportTransactionsResponse data =
          ReportTransactionsResponse.fromJson(jsonDecode(result.body));
      return data;
    } catch (e) {
      rethrow;
    }
  }

  static Future<ReportTahunTransactionsResponse> getTransactionTahun(
      String params) async {
    try {
      final result = await http
          .get(Uri.parse("${RemoteApi().REPORT_TRANSACTIONS}/$params"));

      if (result.statusCode != 200) {
        return ReportTahunTransactionsResponse(
          status: false,
          message: "Something when wrong!!",
          data: [],
        );
      }
      ReportTahunTransactionsResponse data =
          ReportTahunTransactionsResponse.fromJson(jsonDecode(result.body));
      return data;
    } catch (e) {
      print(e.toString());
      rethrow;
    }
  }

  static Future<ReportTahunTransactionsResponse> getTransactionBulan(
      String date, String tahun) async {
    try {
      final result = await http
          .get(Uri.parse("${RemoteApi().REPORT_TRANSACTIONS}/$date/$tahun"));

      if (result.statusCode != 200) {
        return ReportTahunTransactionsResponse(
          status: false,
          message: "Something when wrong!!",
          data: [],
        );
      }
      ReportTahunTransactionsResponse data =
          ReportTahunTransactionsResponse.fromJson(jsonDecode(result.body));
      return data;
    } catch (e) {
      print(e.toString());
      rethrow;
    }
  }

  static Future<ReportDayTransactionResponse> getTransactionDay(
      String date, String month, String tahun) async {
    try {
      final result = await http.get(
          Uri.parse("${RemoteApi().REPORT_TRANSACTIONS}/$date/$month/$tahun"));

      if (result.statusCode != 200) {
        return ReportDayTransactionResponse(
          status: false,
          message: "Something when wrong!!",
          data: [],
        );
      }
      ReportDayTransactionResponse data =
          ReportDayTransactionResponse.fromJson(jsonDecode(result.body));
      return data;
    } catch (e) {
      print(e.toString());
      rethrow;
    }
  }
}
