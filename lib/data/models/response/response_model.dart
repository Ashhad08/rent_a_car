class ResponseModel<T> {
  final String? status;
  final String? message;
  final T? data;

  ResponseModel({
    this.status,
    this.message,
    this.data,
  });

  factory ResponseModel.fromJson(
    Map<String, dynamic> json,
    Function(dynamic) fromJsonModel,
  ) {
    return ResponseModel(
      status: json['status'],
      message: json['message'],
      data: json['data'] != null ? fromJsonModel(json['data']) as T : null,
    );
  }
}
