import '../customer/customer_model.dart';
import '../payment_voucher/payment_voucher_model.dart';
import '../vehicle/vehicle_model.dart';

class BookingListModel {
  final String? id;
  final CustomerModel? customer;
  final VehicleModel? vehicle;
  final bool? withDriver;
  final DateTime? fromDate;
  final DateTime? toDate;
  final PaymentReceiptModel? receiptVoucher;
  final DateTime? returnDate;
  final String? returnCondition;
  final num? vehicleLatitude;
  final num? vehicleLongitude;
  final String? status;
  final DateTime? date;
  final int? v;

  BookingListModel({
    this.id,
    this.customer,
    this.vehicle,
    this.withDriver,
    this.fromDate,
    this.toDate,
    this.receiptVoucher,
    this.returnDate,
    this.returnCondition,
    this.vehicleLatitude,
    this.vehicleLongitude,
    this.status,
    this.date,
    this.v,
  });

  BookingListModel copyWith({
    String? id,
    CustomerModel? customer,
    VehicleModel? vehicle,
    bool? withDriver,
    DateTime? fromDate,
    DateTime? toDate,
    PaymentReceiptModel? receiptVoucher,
    DateTime? returnDate,
    String? returnCondition,
    num? vehicleLatitude,
    num? vehicleLongitude,
    String? status,
    DateTime? date,
    int? v,
  }) =>
      BookingListModel(
        id: id ?? this.id,
        customer: customer ?? this.customer,
        vehicle: vehicle ?? this.vehicle,
        withDriver: withDriver ?? this.withDriver,
        fromDate: fromDate ?? this.fromDate,
        toDate: toDate ?? this.toDate,
        receiptVoucher: receiptVoucher ?? this.receiptVoucher,
        returnDate: returnDate ?? this.returnDate,
        returnCondition: returnCondition ?? this.returnCondition,
        vehicleLatitude: vehicleLatitude ?? this.vehicleLatitude,
        vehicleLongitude: vehicleLongitude ?? this.vehicleLongitude,
        status: status ?? this.status,
        date: date ?? this.date,
        v: v ?? this.v,
      );

  factory BookingListModel.fromJson(Map<String, dynamic> json) =>
      BookingListModel(
        id: json["_id"],
        customer: json["customerID"] == null
            ? null
            : CustomerModel.fromJson(json["customerID"]),
        vehicle: json["vehicleID"] == null
            ? null
            : VehicleModel.fromJson(json["vehicleID"]),
        withDriver: json["withDriver"],
        fromDate:
            json["fromDate"] == null ? null : DateTime.parse(json["fromDate"]),
        toDate: json["toDate"] == null ? null : DateTime.parse(json["toDate"]),
        returnDate: (json["returnDate"] == null ||
                (json['returnDate'] as String).isEmpty)
            ? null
            : DateTime.parse(json["returnDate"]),
        receiptVoucher: json["receiptVoucherID"] == null
            ? null
            : PaymentReceiptModel.fromJson(json["receiptVoucherID"]),
        returnCondition: json["returnCondition"],
        vehicleLatitude: json["vehicleLatitude"],
        vehicleLongitude: json["vehicleLongitude"],
        status: json["status"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        v: json["__v"],
      );
}
