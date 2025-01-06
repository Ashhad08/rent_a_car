class ColorModel {
  final String? id;
  final String? colorName;
  final DateTime? date;
  final int? v;

  ColorModel({
    this.id,
    this.colorName,
    this.date,
    this.v,
  });

  ColorModel copyWith({
    String? id,
    String? colorName,
    DateTime? date,
    int? v,
  }) =>
      ColorModel(
        id: id ?? this.id,
        colorName: colorName ?? this.colorName,
        date: date ?? this.date,
        v: v ?? this.v,
      );

  factory ColorModel.fromJson(Map<String, dynamic> json) => ColorModel(
        id: json["_id"],
        colorName: json["colorName"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "colorID": id,
        "colorName": colorName,
      };
}
