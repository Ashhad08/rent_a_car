class VehicleModel {
  final String? id;
  final String? regNo;
  final String? regCity;
  final String? yearOfModel;
  final String? carTypeId;
  final String? carModelId;
  final String? color;
  final String? transmission;
  final String? engineCapacity;
  final String? chasisNo;
  final String? engineNo;
  final String? rateWithDriver;
  final String? rateWithoutDriver;
  final String? discountWeek;
  final String? discountMonth;
  final String? fuelType;
  final String? status;
  final String? makeName;
  final List<String>? features;
  final List<String>? images;
  final List<String>? documents;
  final DateTime? date;
  final int? v;

  VehicleModel({
    this.id,
    this.regNo,
    this.makeName,
    this.status,
    this.regCity,
    this.yearOfModel,
    this.carTypeId,
    this.carModelId,
    this.color,
    this.transmission,
    this.engineCapacity,
    this.chasisNo,
    this.engineNo,
    this.rateWithDriver,
    this.rateWithoutDriver,
    this.discountWeek,
    this.discountMonth,
    this.fuelType,
    this.features,
    this.images,
    this.documents,
    this.date,
    this.v,
  });

  VehicleModel copyWith({
    String? id,
    String? regNo,
    String? regCity,
    String? yearOfModel,
    String? carTypeId,
    String? carModelId,
    String? color,
    String? transmission,
    String? engineCapacity,
    String? chasisNo,
    String? makeName,
    String? engineNo,
    String? rateWithDriver,
    String? rateWithoutDriver,
    String? discountWeek,
    String? discountMonth,
    String? fuelType,
    String? status,
    List<String>? features,
    List<String>? images,
    List<String>? documents,
    DateTime? date,
    int? v,
  }) =>
      VehicleModel(
        id: id ?? this.id,
        status: status ?? this.status,
        regNo: regNo ?? this.regNo,
        makeName: makeName ?? this.makeName,
        regCity: regCity ?? this.regCity,
        yearOfModel: yearOfModel ?? this.yearOfModel,
        carTypeId: carTypeId ?? this.carTypeId,
        carModelId: carModelId ?? this.carModelId,
        color: color ?? this.color,
        transmission: transmission ?? this.transmission,
        engineCapacity: engineCapacity ?? this.engineCapacity,
        chasisNo: chasisNo ?? this.chasisNo,
        engineNo: engineNo ?? this.engineNo,
        rateWithDriver: rateWithDriver ?? this.rateWithDriver,
        rateWithoutDriver: rateWithoutDriver ?? this.rateWithoutDriver,
        discountWeek: discountWeek ?? this.discountWeek,
        discountMonth: discountMonth ?? this.discountMonth,
        fuelType: fuelType ?? this.fuelType,
        features: features ?? this.features,
        images: images ?? this.images,
        documents: documents ?? this.documents,
        date: date ?? this.date,
        v: v ?? this.v,
      );

  factory VehicleModel.fromJson(Map<String, dynamic> json) => VehicleModel(
        id: json["_id"],
        regNo: json["regNo"],
        regCity: json["regCity"],
        yearOfModel: json["yearOfModel"],
        carTypeId: json["carTypeID"],
        carModelId: json["carModelID"],
        color: json["color"],
        transmission: json["transmission"],
        engineCapacity: json["engineCapacity"],
        chasisNo: json["chasisNo"],
        makeName: json["makeName"],
        engineNo: json["engineNo"],
        rateWithDriver: json["rateWithDriver"],
        rateWithoutDriver: json["rateWithoutDriver"],
        status: json["status"] ?? "available",
        discountWeek: json["discountWeek"] == null
            ? null
            : (json["discountWeek"] as String).replaceAll("%", ""),
        discountMonth: json["discountMonth"] == null
            ? null
            : (json["discountMonth"] as String).replaceAll("%", ""),
        fuelType: json["fuelType"],
        features: json["features"] == null
            ? []
            : List<String>.from(json["features"]!.map((x) => x)),
        images: json["images"] == null
            ? []
            : List<String>.from(json["images"]!.map((x) => x)),
        documents: json["documents"] == null
            ? []
            : List<String>.from(json["documents"]!.map((x) => x)),
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        if (id != null) "vehicleID": id,
        "regNo": regNo,
        "regCity": regCity,
        "yearOfModel": yearOfModel,
        "carTypeID": carTypeId,
        "carModelID": carModelId,
        "color": color,
        "transmission": transmission,
        "engineCapacity": engineCapacity,
        "chasisNo": chasisNo,
        "engineNo": engineNo,
        "rateWithDriver": rateWithDriver,
        "rateWithoutDriver": rateWithoutDriver,
        "discountWeek": discountWeek,
        "discountMonth": discountMonth,
        "fuelType": fuelType,
        "status": status ?? "available",
        "makeName": makeName,
        "features":
            features == null ? [] : List<dynamic>.from(features!.map((x) => x)),
        "images":
            images == null ? [] : List<dynamic>.from(images!.map((x) => x)),
        "documents": documents == null
            ? []
            : List<dynamic>.from(documents!.map((x) => x)),
      };
}
