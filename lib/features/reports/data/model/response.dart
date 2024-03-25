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

class ReportSalesResponse {
  int profit;
  int revenue;
  List<Detail> details;

  ReportSalesResponse({
    required this.profit,
    required this.revenue,
    required this.details,
  });

  factory ReportSalesResponse.fromJson(Map<String, dynamic> json) =>
      ReportSalesResponse(
        profit: json["profit"],
        revenue: json["revenue"],
        details:
            List<Detail>.from(json["details"].map((x) => Detail.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "profit": profit,
        "revenue": revenue,
        "details": List<dynamic>.from(details.map((x) => x.toJson())),
      };
}

class Detail {
  String indicator;
  int profit;
  int revenue;
  int totalTransactions;

  Detail({
    required this.indicator,
    required this.profit,
    required this.revenue,
    required this.totalTransactions,
  });

  factory Detail.fromJson(Map<String, dynamic> json) => Detail(
        indicator: json["indicator"],
        profit: json["profit"],
        revenue: json["revenue"],
        totalTransactions: json["total_transactions"],
      );

  Map<String, dynamic> toJson() => {
        "indicator": indicator,
        "profit": profit,
        "revenue": revenue,
        "total_transactions": totalTransactions,
      };
}

class ReportTransactionSalesResponse {
  bool status;
  String message;
  List<DetailSales> data;

  ReportTransactionSalesResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory ReportTransactionSalesResponse.fromJson(Map<String, dynamic> json) =>
      ReportTransactionSalesResponse(
        status: json["status"],
        message: json["message"],
        data: List<DetailSales>.from(
            json["data"].map((x) => DetailSales.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class DetailSales {
  String productName;
  int sellingPrice;
  String tanggal;
  int quantity;

  DetailSales({
    required this.productName,
    required this.sellingPrice,
    required this.tanggal,
    required this.quantity,
  });

  factory DetailSales.fromJson(Map<String, dynamic> json) => DetailSales(
        productName: json["product_name"],
        sellingPrice: json["selling_price"],
        tanggal: json["tanggal"],
        quantity: json["quantity"],
      );

  Map<String, dynamic> toJson() => {
        "product_name": productName,
        "selling_price": sellingPrice,
        "tanggal": tanggal,
        "quantity": quantity,
      };
}
