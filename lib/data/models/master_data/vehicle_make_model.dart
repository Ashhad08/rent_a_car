class VehicleMakeModel {
  final String? id;
  final String? makeName;
  final DateTime? date;
  final int? v;

  VehicleMakeModel({
    this.id,
    this.makeName,
    this.date,
    this.v,
  });

  VehicleMakeModel copyWith({
    String? id,
    String? makeName,
    DateTime? date,
    int? v,
  }) =>
      VehicleMakeModel(
        id: id ?? this.id,
        makeName: makeName ?? this.makeName,
        date: date ?? this.date,
        v: v ?? this.v,
      );

  factory VehicleMakeModel.fromJson(Map<String, dynamic> json) =>
      VehicleMakeModel(
        id: json["_id"],
        makeName: json["makeName"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "makeID": id,
        "makeName": makeName,
      };
}
