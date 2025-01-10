class FuelTypeModel {
  final String? id;
  final String? fuelName;
  final num? fuelRate;
  final DateTime? date;
  final int? v;

  FuelTypeModel({
    this.id,
    this.fuelName,
    this.fuelRate,
    this.date,
    this.v,
  });

  FuelTypeModel copyWith({
    String? id,
    String? fuelName,
    num? fuelRate,
    DateTime? date,
    int? v,
  }) =>
      FuelTypeModel(
        id: id ?? this.id,
        fuelName: fuelName ?? this.fuelName,
        fuelRate: fuelRate ?? this.fuelRate,
        date: date ?? this.date,
        v: v ?? this.v,
      );

  factory FuelTypeModel.fromJson(Map<String, dynamic> json) => FuelTypeModel(
        id: json["_id"],
        fuelName: json["fuelName"],
        fuelRate:
            json["fuelRate"] == null ? null : num.tryParse(json["fuelRate"]),
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        if (id != null) "fuelTypeID": id,
        "fuelName": fuelName,
        "fuelRate": fuelRate.toString(),
      };
}
