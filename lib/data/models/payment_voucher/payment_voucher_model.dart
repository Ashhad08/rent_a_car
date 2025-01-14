import '../booking/booking_list_model.dart';

class PaymentReceiptModel {
  final String? id;
  final BookingListModel? booking;
  final num? dueAmount;
  final num? recievedAmount;
  final num? balanceAmount;
  final bool? discountApplied;
  final DateTime? date;
  final int? v;

  PaymentReceiptModel({
    this.id,
    this.booking,
    this.dueAmount,
    this.recievedAmount,
    this.balanceAmount,
    this.discountApplied,
    this.date,
    this.v,
  });

  PaymentReceiptModel copyWith({
    String? id,
    BookingListModel? booking,
    num? dueAmount,
    num? recievedAmount,
    num? balanceAmount,
    bool? discountApplied,
    DateTime? date,
    int? v,
  }) =>
      PaymentReceiptModel(
        id: id ?? this.id,
        booking: booking ?? this.booking,
        dueAmount: dueAmount ?? this.dueAmount,
        recievedAmount: recievedAmount ?? this.recievedAmount,
        balanceAmount: balanceAmount ?? this.balanceAmount,
        discountApplied: discountApplied ?? this.discountApplied,
        date: date ?? this.date,
        v: v ?? this.v,
      );

  factory PaymentReceiptModel.fromJson(Map<String, dynamic> json) =>
      PaymentReceiptModel(
        id: json["_id"],
        booking: json["bookingID"] == null || json["bookingID"] is String
            ? null
            : BookingListModel.fromJson(json['bookingID']),
        dueAmount: json["dueAmount"],
        recievedAmount: json["recievedAmount"],
        balanceAmount: json["balanceAmount"],
        discountApplied: json["discountApplied"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson(String bookingId) => {
        if (id != null) "receiptID": id,
        "bookingID": bookingId,
        "dueAmount": dueAmount,
        "recievedAmount": recievedAmount,
        "balanceAmount": balanceAmount,
        "discountApplied": discountApplied,
      };
}
