class VehicleTypeModel {
  final String? id;
  final String? typeName;
  final DateTime? date;
  final int? v;

  VehicleTypeModel({
    this.id,
    this.typeName,
    this.date,
    this.v,
  });

  VehicleTypeModel copyWith({
    String? id,
    String? typeName,
    DateTime? date,
    int? v,
  }) =>
      VehicleTypeModel(
        id: id ?? this.id,
        typeName: typeName ?? this.typeName,
        date: date ?? this.date,
        v: v ?? this.v,
      );

  factory VehicleTypeModel.fromJson(Map<String, dynamic> json) =>
      VehicleTypeModel(
        id: json["_id"],
        typeName: json["typeName"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "typeID": id,
        "typeName": typeName,
      };
}
