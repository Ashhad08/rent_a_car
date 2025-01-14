class MakeUpdateBookingModel {
  final String? bookingId;
  final String? customerId;
  final String? vehicleId;
  final String? receiptVoucherId;
  final bool? withDriver;
  final DateTime? fromDate;
  final DateTime? toDate;
  final DateTime? returnDate;
  final String? returnCondition;
  final num? vehicleLatitude;
  final num? vehicleLongitude;
  final String? status;

  MakeUpdateBookingModel({
    this.bookingId,
    this.customerId,
    this.vehicleId,
    this.receiptVoucherId,
    this.withDriver,
    this.fromDate,
    this.toDate,
    this.returnDate,
    this.returnCondition,
    this.vehicleLatitude,
    this.vehicleLongitude,
    this.status,
  });

  MakeUpdateBookingModel copyWith({
    String? bookingId,
    String? customerId,
    String? vehicleId,
    String? receiptVoucherId,
    bool? withDriver,
    DateTime? fromDate,
    DateTime? toDate,
    DateTime? returnDate,
    String? returnCondition,
    num? vehicleLatitude,
    num? vehicleLongitude,
    String? status,
  }) =>
      MakeUpdateBookingModel(
        bookingId: bookingId ?? this.bookingId,
        customerId: customerId ?? this.customerId,
        vehicleId: vehicleId ?? this.vehicleId,
        receiptVoucherId: receiptVoucherId ?? this.receiptVoucherId,
        withDriver: withDriver ?? this.withDriver,
        fromDate: fromDate ?? this.fromDate,
        toDate: toDate ?? this.toDate,
        returnDate: returnDate ?? this.returnDate,
        returnCondition: returnCondition ?? this.returnCondition,
        vehicleLatitude: vehicleLatitude ?? this.vehicleLatitude,
        vehicleLongitude: vehicleLongitude ?? this.vehicleLongitude,
        status: status ?? this.status,
      );

  Map<String, dynamic> toJsonPost() => {
        "customerID": customerId,
        "vehicleID": vehicleId,
        "withDriver": withDriver,
        "fromDate": fromDate?.toIso8601String(),
        "toDate": toDate?.toIso8601String(),
      };

  Map<String, dynamic> toJsonPut() => {
        "bookingID": bookingId,
        "receiptVoucherID": receiptVoucherId,
        "withDriver": withDriver,
        "fromDate": fromDate?.toIso8601String(),
        "toDate": toDate?.toIso8601String(),
        "returnDate": returnDate?.toIso8601String() ?? '',
        "returnCondition": returnCondition ?? '',
        "vehicleLatitude": vehicleLatitude ?? 0,
        "vehicleLongitude": vehicleLongitude ?? 0,
        "returnAmount": 0,
        "status": status,
        "customerID": customerId,
        "vehicleID": vehicleId,
      };
}
