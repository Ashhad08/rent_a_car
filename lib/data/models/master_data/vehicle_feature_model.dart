class VehicleFeatureModel {
  final String? id;
  final String? featureName;
  final DateTime? date;
  final int? v;

  VehicleFeatureModel({
    this.id,
    this.featureName,
    this.date,
    this.v,
  });

  VehicleFeatureModel copyWith({
    String? id,
    String? featureName,
    DateTime? date,
    int? v,
  }) =>
      VehicleFeatureModel(
        id: id ?? this.id,
        featureName: featureName ?? this.featureName,
        date: date ?? this.date,
        v: v ?? this.v,
      );

  factory VehicleFeatureModel.fromJson(Map<String, dynamic> json) =>
      VehicleFeatureModel(
        id: json["_id"],
        featureName: json["featureName"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "featureID": id,
        "featureName": featureName,
      };
}
