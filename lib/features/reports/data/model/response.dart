class ReportTransactionsResponse {
  bool status;
  String message;
  List<DetailTransaction> data;

  ReportTransactionsResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory ReportTransactionsResponse.fromJson(Map<String, dynamic> json) =>
      ReportTransactionsResponse(
        status: json["status"],
        message: json["message"],
        data: List<DetailTransaction>.from(
            json["data"].map((x) => DetailTransaction.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class ReportTahunTransactionsResponse {
  bool status;
  String message;
  List<DetailTahunTransaction> data;

  ReportTahunTransactionsResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory ReportTahunTransactionsResponse.fromJson(Map<String, dynamic> json) =>
      ReportTahunTransactionsResponse(
        status: json["status"],
        message: json["message"],
        data: List<DetailTahunTransaction>.from(
          json["data"].map(
            (x) => DetailTahunTransaction.fromJson(x),
          ),
        ),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class ReportDayTransactionResponse {
  bool status;
  String message;
  List<DetailDayTransaction> data;

  ReportDayTransactionResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory ReportDayTransactionResponse.fromJson(Map<String, dynamic> json) =>
      ReportDayTransactionResponse(
        status: json["status"],
        message: json["message"],
        data: List<DetailDayTransaction>.from(
          json["data"].map(
            (x) => DetailDayTransaction.fromJson(x),
          ),
        ),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class DetailTahunTransaction {
  String time;
  int transactionCount;
  String revenue;
  String profit;

  DetailTahunTransaction({
    required this.time,
    required this.transactionCount,
    required this.revenue,
    required this.profit,
  });

  factory DetailTahunTransaction.fromJson(Map<String, dynamic> json) =>
      DetailTahunTransaction(
        time: json["time"],
        transactionCount: json["transaction_count"],
        revenue: json["revenue"],
        profit: json["profit"],
      );

  Map<String, dynamic> toJson() => {
        "time": time,
        "transaction_count": transactionCount,
        "revenue": revenue,
        "profit": profit,
      };
}

class DetailDayTransaction {
  String time;
  String hour;
  String revenue;
  String profit;

  DetailDayTransaction({
    required this.time,
    required this.hour,
    required this.revenue,
    required this.profit,
  });

  factory DetailDayTransaction.fromJson(Map<String, dynamic> json) =>
      DetailDayTransaction(
        time: json["time"],
        hour: json["hour"],
        revenue: json["revenue"],
        profit: json["profit"],
      );

  Map<String, dynamic> toJson() => {
        "time": time,
        "hour": hour,
        "revenue": revenue,
        "profit": profit,
      };
}

class DetailTransaction {
  int transactionYear;
  int transactionCount;
  String revenue;
  String profit;

  DetailTransaction({
    required this.transactionYear,
    required this.transactionCount,
    required this.revenue,
    required this.profit,
  });

  factory DetailTransaction.fromJson(Map<String, dynamic> json) =>
      DetailTransaction(
        transactionYear: json["transaction_year"],
        transactionCount: json["transaction_count"],
        revenue: json["revenue"],
        profit: json["profit"],
      );

  Map<String, dynamic> toJson() => {
        "transaction_year": transactionYear,
        "transaction_count": transactionCount,
        "revenue": revenue,
        "profit": profit,
      };
}
