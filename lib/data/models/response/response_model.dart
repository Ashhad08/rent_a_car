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
      Map<String, dynamic> json, Function(Map<String, dynamic>) fromJsonModel) {
    final data = _parseData<T>(json["data"], fromJsonModel);
    return ResponseModel(
      status: json["status"],
      message: json["message"],
      data: data,
    );
  }

  static T? _parseData<T>(
      dynamic data, Function(Map<String, dynamic>) fromJsonModel) {
    if (data == null) return null;

    if (T == List) {
      return List.from(
              data.map((e) => e is Map<String, dynamic> ? fromJsonModel(e) : e))
          as T;
    }

    if (data is Map<String, dynamic>) {
      return fromJsonModel(data);
    }

    if (T == String || T == num || T == bool) {
      return data as T;
    }

    return null; // Return null if type is not supported
  }
}
