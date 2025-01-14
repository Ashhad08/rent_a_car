import 'package:flutter/material.dart';

import '../../../constants/extensions.dart';
import '../../../data/models/booking/make_update_booking_model.dart';
import '../../../data/models/payment_voucher/payment_voucher_model.dart';
import '../../../data/models/response/response_model.dart';
import '../../../data/models/vehicle/vehicle_model.dart';
import '../../../data/repositories/payment_voucher/base_payment_voucher_repository.dart';
import '../booking/booking_repository.dart';
import '../vehicle/vehicle_repository.dart';

class PaymentVoucherRepository extends BasePaymentVoucherRepository {
  PaymentVoucherRepository(
      {required super.backendConfigs, required super.networkRepository});

  @override
  Future<ResponseModel<PaymentReceiptModel>> createVoucher(
      PaymentReceiptModel voucher,
      VehicleModel vehicle,
      MakeUpdateBookingModel booking) async {
    try {
      final res = await super.networkRepository.post(
            uri: super.backendConfigs.buildUri(
              segments: [
                super.backendConfigs.booking,
                super.backendConfigs.createVoucher,
              ],
            ),
            data: voucher.toJson(booking.bookingId.toString()),
          );
      final model = ResponseModel<PaymentReceiptModel>.fromJson(
        res,
        (data) => PaymentReceiptModel.fromJson(data),
      );
      await getIt<BookingRepository>()
          .updateBooking(booking.copyWith(receiptVoucherId: model.data?.id));
      await getIt<VehicleRepository>()
          .updateVehicle(vehicle.copyWith(status: 'booked'));

      return model;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ResponseModel> updateVoucher(
      PaymentReceiptModel voucher, String bookingId) async {
    try {
      final res = await super.networkRepository.post(
            uri: super.backendConfigs.buildUri(
              segments: [
                super.backendConfigs.booking,
                super.backendConfigs.updateVoucher,
              ],
            ),
            data: voucher.toJson(bookingId),
          );
      return ResponseModel.fromJson(
        res,
        (data) => null,
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<PaymentReceiptModel>> getAllPaymentVouchers() async {
    try {
      final res = await super.networkRepository.get(
              uri: super.backendConfigs.buildUri(segments: [
            super.backendConfigs.booking,
            super.backendConfigs.allPaymentVouchers,
          ]));
      return ResponseModel<List<PaymentReceiptModel>>.fromJson(
            res,
            (data) => data == null
                ? []
                : List<PaymentReceiptModel>.from(
                    data!.map((e) => PaymentReceiptModel.fromJson(e))),
          ).data ??
          [];
    } catch (e, stackTrace) {
      debugPrint(stackTrace.toString());
      rethrow;
    }
  }
}
