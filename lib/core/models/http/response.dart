class Response<T> {
  bool status;
  String message;
  T data;

  Response({required this.status, required this.message, required this.data});

  factory Response.fromJson(Map<String, dynamic> json,
      T Function(Map<String, dynamic>) fromJsonData) {
    return Response<T>(
      status: json['status'] as bool,
      message: json['message'] as String,
      data: fromJsonData(json['data']),
    );
  }

  Map<String, dynamic> toJson(Map<String, dynamic> Function(T) toJsonData) {
    return {
      'status': status,
      'message': message,
      'data': toJsonData(data),
    };
  }
}
