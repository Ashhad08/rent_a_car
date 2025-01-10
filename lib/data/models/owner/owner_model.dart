import '../vehicle/vehicle_model.dart';

class OwnerModel {
  final OwnerInfo? ownerInfo;
  final List<VehicleModel>? vehicles;

  OwnerModel({
    this.ownerInfo,
    this.vehicles,
  });

  OwnerModel copyWith({
    OwnerInfo? ownerInfo,
    List<VehicleModel>? vehicles,
  }) =>
      OwnerModel(
        ownerInfo: ownerInfo ?? this.ownerInfo,
        vehicles: vehicles ?? this.vehicles,
      );

  factory OwnerModel.fromJson(Map<String, dynamic> json) => OwnerModel(
        ownerInfo: json["ownerInfo"] == null
            ? null
            : OwnerInfo.fromJson(json["ownerInfo"]),
        vehicles: json["vehicles"] == null
            ? []
            : List<VehicleModel>.from(
                json["vehicles"]!.map((x) => VehicleModel.fromJson(x))),
      );
}

class OwnerInfo {
  final String? id;
  final String? ownerImage;
  final String? ownerCode;
  final DateTime? dateFrom;
  final String? ownerName;
  final String? fatherName;
  final String? cnic;
  final String? address;
  final String? city;
  final String? mobileNumber;
  final String? resedenceNumber;
  final String? profession;
  final List<String>? vehicles;
  final DateTime? date;
  final int? v;

  OwnerInfo({
    this.id,
    this.ownerImage,
    this.ownerCode,
    this.dateFrom,
    this.ownerName,
    this.fatherName,
    this.cnic,
    this.address,
    this.city,
    this.mobileNumber,
    this.resedenceNumber,
    this.profession,
    this.vehicles,
    this.date,
    this.v,
  });

  OwnerInfo copyWith({
    String? id,
    String? ownerImage,
    String? ownerCode,
    DateTime? dateFrom,
    String? ownerName,
    String? fatherName,
    String? cnic,
    String? address,
    String? city,
    String? mobileNumber,
    String? resedenceNumber,
    String? profession,
    List<String>? vehicles,
    DateTime? date,
    int? v,
  }) =>
      OwnerInfo(
        id: id ?? this.id,
        ownerImage: ownerImage ?? this.ownerImage,
        ownerCode: ownerCode ?? this.ownerCode,
        dateFrom: dateFrom ?? this.dateFrom,
        ownerName: ownerName ?? this.ownerName,
        fatherName: fatherName ?? this.fatherName,
        cnic: cnic ?? this.cnic,
        address: address ?? this.address,
        city: city ?? this.city,
        mobileNumber: mobileNumber ?? this.mobileNumber,
        resedenceNumber: resedenceNumber ?? this.resedenceNumber,
        profession: profession ?? this.profession,
        vehicles: vehicles ?? this.vehicles,
        date: date ?? this.date,
        v: v ?? this.v,
      );

  factory OwnerInfo.fromJson(Map<String, dynamic> json) => OwnerInfo(
        id: json["_id"],
        ownerImage: json["ownerImage"],
        ownerCode: json["ownerCode"],
        dateFrom:
            json["dateFrom"] == null ? null : DateTime.parse(json["dateFrom"]),
        ownerName: json["ownerName"],
        fatherName: json["fatherName"],
        cnic: json["cnic"],
        address: json["address"],
        city: json["city"],
        mobileNumber: json["mobileNumber"],
        resedenceNumber: json["resedenceNumber"],
        profession: json["profession"],
        vehicles: json["vehicles"] == null
            ? []
            : List<String>.from(json["vehicles"]!.map((x) => x)),
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        if (id != null) "ownerID": id,
        "ownerImage": ownerImage,
        "ownerCode": ownerCode,
        "dateFrom": dateFrom?.toIso8601String(),
        "ownerName": ownerName,
        "fatherName": fatherName,
        "cnic": cnic,
        "address": address,
        "city": city,
        "mobileNumber": mobileNumber,
        "resedenceNumber": resedenceNumber,
        "profession": profession,
        "vehicles":
            vehicles == null ? [] : List<dynamic>.from(vehicles!.map((x) => x)),
      };
}
