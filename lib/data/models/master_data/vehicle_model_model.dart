class VehicleModelModel {
  final String? id;
  final String? carTypeId;
  final String? modelName;
  final DateTime? date;
  final int? v;

  VehicleModelModel({
    this.id,
    this.carTypeId,
    this.modelName,
    this.date,
    this.v,
  });

  VehicleModelModel copyWith({
    String? id,
    String? carTypeId,
    String? modelName,
    DateTime? date,
    int? v,
  }) =>
      VehicleModelModel(
        id: id ?? this.id,
        carTypeId: carTypeId ?? this.carTypeId,
        modelName: modelName ?? this.modelName,
        date: date ?? this.date,
        v: v ?? this.v,
      );

  factory VehicleModelModel.fromJson(Map<String, dynamic> json) =>
      VehicleModelModel(
        id: json["_id"],
        carTypeId: json["carTypeID"],
        modelName: json["modelName"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "singleModelID": id,
        "carTypeID": carTypeId,
        "modelName": modelName,
      };
}
