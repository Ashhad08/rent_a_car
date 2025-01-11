import 'package:flutter/material.dart';

import '../vehicle/vehicle_model.dart';

class PromotionInfo {
  final String? id;
  final String? promoTitle;
  final int? discountPercentage;
  final List<VehicleModel>? vehicleList;
  final DateTime? startDate;
  final DateTime? endDate;
  final String? description;
  final bool? isActive;
  final DateTime? date;
  final int? v;

  PromotionInfo({
    this.id,
    this.promoTitle,
    this.discountPercentage,
    this.vehicleList,
    this.startDate,
    this.endDate,
    this.description,
    this.isActive,
    this.date,
    this.v,
  });

  PromotionInfo copyWith({
    String? id,
    String? promoTitle,
    int? discountPercentage,
    List<VehicleModel>? vehicleList,
    DateTime? startDate,
    DateTime? endDate,
    String? description,
    bool? isActive,
    DateTime? date,
    int? v,
  }) =>
      PromotionInfo(
        id: id ?? this.id,
        promoTitle: promoTitle ?? this.promoTitle,
        discountPercentage: discountPercentage ?? this.discountPercentage,
        vehicleList: vehicleList ?? this.vehicleList,
        startDate: startDate ?? this.startDate,
        endDate: endDate ?? this.endDate,
        description: description ?? this.description,
        isActive: isActive ?? this.isActive,
        date: date ?? this.date,
        v: v ?? this.v,
      );

  factory PromotionInfo.fromJson(Map<String, dynamic> json) {
    debugPrint(json["vehicleList"].runtimeType.toString());
    return PromotionInfo(
      id: json["_id"],
      promoTitle: json["promoTitle"],
      discountPercentage: json["discountPercentage"],
      vehicleList: json["vehicleList"] == null
          ? []
          : json["vehicleList"] is Iterable<String>
              ? List<VehicleModel>.from(json["vehicleList"]!.map(
                  (id) => VehicleModel(id: id))) // Handle string IDs directly
              : List<VehicleModel>.from(
                  json["vehicleList"]!.map((x) => VehicleModel.fromJson(x))),
      startDate:
          json["startDate"] == null ? null : DateTime.parse(json["startDate"]),
      endDate: json["endDate"] == null ? null : DateTime.parse(json["endDate"]),
      description: json["description"],
      isActive: json["status"] == null
          ? null
          : json["status"] == 'active'
              ? true
              : false,
      date: json["date"] == null ? null : DateTime.parse(json["date"]),
      v: json["__v"],
    );
  }

  Map<String, dynamic> toJson() => {
        if (id != null) "promoID": id,
        "promoTitle": promoTitle,
        "discountPercentage": discountPercentage,
        "vehicleList": vehicleList == null
            ? []
            : List<String>.from(vehicleList!.map((x) => x.id)),
        "startDate": startDate?.toIso8601String(),
        "endDate": endDate?.toIso8601String(),
        "description": description,
        "status": (isActive ?? false) ? 'active' : 'inactive',
        "date": date?.toIso8601String(),
      };
}
