import 'dart:developer';

import 'package:flutter/material.dart';

import '../../../data/models/booking/booking_list_model.dart';
import '../../../data/models/booking/make_update_booking_model.dart';
import '../../../data/models/response/response_model.dart';
import '../../../data/repositories/booking/base_booking_repository.dart';

class BookingRepository extends BaseBookingRepository {
  BookingRepository(
      {required super.backendConfigs, required super.networkRepository});

  @override
  Future<ResponseModel> createBooking(MakeUpdateBookingModel booking) async {
    try {
      final res = await super.networkRepository.post(
            uri: super.backendConfigs.buildUri(
              segments: [
                super.backendConfigs.booking,
                super.backendConfigs.createBooking,
              ],
            ),
            data: booking.toJsonPost(),
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
  Future<ResponseModel> updateBooking(MakeUpdateBookingModel booking) async {
    try {
      log(booking.toJsonPut().toString());
      final res = await super.networkRepository.post(
            uri: super.backendConfigs.buildUri(
              segments: [
                super.backendConfigs.booking,
                super.backendConfigs.editBooking,
              ],
            ),
            data: booking.toJsonPut(),
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
  Future<List<BookingListModel>> getPendingBookings() async {
    try {
      final res = await super.networkRepository.get(
              uri: super.backendConfigs.buildUri(segments: [
            super.backendConfigs.booking,
            super.backendConfigs.pendingBookings,
          ]));
      return ResponseModel<List<BookingListModel>>.fromJson(
            res,
            (data) => data == null
                ? []
                : List<BookingListModel>.from(
                    data!.map((e) => BookingListModel.fromJson(e))),
          ).data ??
          [];
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<BookingListModel>> getApprovedBookings() async {
    try {
      final res = await super.networkRepository.get(
              uri: super.backendConfigs.buildUri(segments: [
            super.backendConfigs.booking,
            super.backendConfigs.approvedBookings,
          ]));
      return ResponseModel<List<BookingListModel>>.fromJson(
            res,
            (data) => data == null
                ? []
                : List<BookingListModel>.from(
                    data!.map((e) => BookingListModel.fromJson(e))),
          ).data ??
          [];
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<BookingListModel>> getBookingsByCustomer(
      String customerId) async {
    try {
      final res = await super.networkRepository.post(
          uri: super.backendConfigs.buildUri(
            segments: [
              super.backendConfigs.booking,
              super.backendConfigs.bookingsByCustomer,
            ],
          ),
          data: {
            'customerID': customerId,
          });
      return ResponseModel<List<BookingListModel>>.fromJson(
            res,
            (data) => data == null
                ? []
                : List<BookingListModel>.from(
                    data!.map((e) => BookingListModel.fromJson(e))),
          ).data ??
          [];
    } catch (e, stackTrace) {
      debugPrint(stackTrace.toString());
      rethrow;
    }
  }
}
