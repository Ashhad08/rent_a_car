import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../blocs/booking/approved_bookings_bloc/approved_bookings_bloc.dart';
import '../../../../blocs/booking/pending_bookings_bloc/pending_bookings_bloc.dart';
import '../../../../blocs/loading_bloc/loading_bloc.dart';
import '../../../../blocs/master_data/vehicle_all_makes_bloc/vehicle_all_makes_bloc.dart';
import '../../../../blocs/master_data/vehicle_models_bloc/vehicle_models_bloc.dart';
import '../../../../blocs/vehicle/all_vehicles_bloc/all_vehicles_bloc.dart';
import '../../../../blocs/vehicle/available_for_rent_vehicles_bloc/available_for_rent_vehicles_bloc.dart';
import '../../../../constants/app_colors.dart';
import '../../../../constants/extensions.dart';
import '../../../../data/models/booking/booking_list_model.dart';
import '../../../../data/models/booking/make_update_booking_model.dart';
import '../../../../domain/implementations/booking/booking_repository.dart';
import '../../../../domain/implementations/vehicle/vehicle_repository.dart';
import '../../../../generated/assets.dart';
import '../../../../navigation/navigation_helper.dart';
import '../../../../utils/utils.dart';
import '../../add_update_payment_receipt_view/add_update_payment_receipt_view.dart';

class BookingCard extends StatelessWidget {
  const BookingCard(
      {super.key,
      required this.booking,
      required this.showActions,
      required this.showEditIcon});

  final BookingListModel booking;
  final bool showActions;
  final bool showEditIcon;

  @override
  Widget build(BuildContext context) {
    final canBook = booking.receiptVoucher != null;
    final stateMake = context.read<VehicleAllMakesBloc>().state;
    final stateModels = context.read<VehicleModelsBloc>().state;
    String vehicleMake = '';
    String vehicleModel = '';
    if (stateMake is VehicleAllMakesLoaded) {
      vehicleMake = stateMake.allMakes
              .where(
                (element) =>
                    element.makeName?.toLowerCase() ==
                    booking.vehicle?.makeName?.toLowerCase(),
              )
              .firstOrNull
              ?.makeName ??
          "";
    }
    if (stateModels is VehicleModelsLoaded) {
      vehicleModel = stateModels.models
              .where(
                (element) => element.id == booking.vehicle?.carModelId,
              )
              .firstOrNull
              ?.modelName ??
          "";
    }
    return Container(
      padding: EdgeInsets.only(top: 5, right: 14, left: 14, bottom: 18),
      decoration: BoxDecoration(
        color: getIt<AppColors>().kCardColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: context.colorScheme.outline,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            dense: true,
            contentPadding: EdgeInsets.zero,
            leading: CircleAvatar(
              backgroundImage: booking.customer?.profileImage != null
                  ? NetworkImage(booking.customer!.profileImage!)
                  : null,
            ),
            title: Text(
              booking.customer?.name ?? "",
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: context.colorScheme.onPrimary),
            ),
            subtitle: Text(
              'ID: ${booking.customer?.id}',
              style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w400,
                  color: context.colorScheme.onPrimary),
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.access_time_filled,
                  color: context.colorScheme.onPrimary,
                  size: 20,
                ),
                4.width,
                Text(
                  getRelativeDateText(booking.date),
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: context.colorScheme.onPrimary),
                )
              ],
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                Assets.iconsCarFront,
                color: context.colorScheme.onPrimary,
                height: 20,
                width: 20,
              ),
              4.width,
              Expanded(
                child: Text(
                  '$vehicleMake $vehicleModel',
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: context.colorScheme.onPrimary),
                ),
              )
            ],
          ),
          10.height,
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.access_time_filled,
                color: context.colorScheme.onPrimary,
                size: 20,
              ),
              4.width,
              Expanded(
                child: Text(
                  formatDateRange(booking.fromDate, booking.toDate),
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: context.colorScheme.onPrimary),
                ),
              )
            ],
          ),
          if (booking.receiptVoucher != null) ...[
            Divider(),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.payment,
                  color: context.colorScheme.onPrimary,
                  size: 20,
                ),
                4.width,
                Expanded(
                  child: Text(
                    'Due amount: ${booking.receiptVoucher?.dueAmount}/Rs',
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: context.colorScheme.onPrimary),
                  ),
                )
              ],
            ),
            10.height,
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.add,
                  color: context.colorScheme.onPrimary,
                  size: 20,
                ),
                4.width,
                Expanded(
                  child: Text(
                    'Received amount: ${booking.receiptVoucher?.recievedAmount}/Rs',
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: context.colorScheme.onPrimary),
                  ),
                )
              ],
            ),
            10.height,
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.balance,
                  color: context.colorScheme.onPrimary,
                  size: 20,
                ),
                4.width,
                Expanded(
                  child: Text(
                    'Balance: ${booking.receiptVoucher?.balanceAmount}/Rs',
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: context.colorScheme.onPrimary),
                  ),
                )
              ],
            ),
          ],
          if (showActions) ...[
            10.height,
            Row(
              spacing: 8,
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      getIt<NavigationHelper>().push(
                          context,
                          AddUpdatePaymentReceiptView(
                            booking: booking,
                          ));
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xffEAB308)),
                    child: Text(
                      canBook ? 'Edit Receipt' : 'Receipt',
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: context.colorScheme.onPrimary),
                    ),
                  ),
                ),
                if (!canBook)
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () async {
                        final utils = getIt<Utils>();
                        if (!context.read<LoadingBloc>().state.isLoading) {
                          final repo = getIt<BookingRepository>();

                          try {
                            context.read<LoadingBloc>().add(StartLoading());
                            final res =
                                await repo.updateBooking(MakeUpdateBookingModel(
                              bookingId: booking.id,
                              returnDate: booking.returnDate,
                              returnCondition: booking.returnCondition,
                              vehicleLongitude: booking.vehicleLongitude,
                              vehicleLatitude: booking.vehicleLatitude,
                              toDate: booking.toDate,
                              fromDate: booking.fromDate,
                              status: 'cancelled',
                              customerId: booking.customer?.id,
                              vehicleId: booking.vehicle?.id,
                              withDriver: booking.withDriver,
                              receiptVoucherId: booking.receiptVoucher?.id,
                            ));
                            if (context.mounted) {
                              context.read<LoadingBloc>().add(StopLoading());
                              context
                                  .read<PendingBookingsBloc>()
                                  .add(LoadPendingBookingsEvent());
                              utils.showSuccessFlushBar(context,
                                  message: res.message ??
                                      "Booking cancelled successfully");
                            }
                          } catch (e, stackTrace) {
                            if (context.mounted) {
                              debugPrint(stackTrace.toString());
                              context.read<LoadingBloc>().add(StopLoading());
                              utils.showErrorFlushBar(context,
                                  message: e.toString());
                            }
                          }
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xffEF4444)),
                      child: Text(
                        'Decline',
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: context.colorScheme.onPrimary),
                      ),
                    ),
                  ),
                Expanded(
                  child: ElevatedButton(
                    onPressed: canBook
                        ? () async {
                            final utils = getIt<Utils>();
                            if (!context.read<LoadingBloc>().state.isLoading) {
                              final repo = getIt<BookingRepository>();

                              try {
                                context.read<LoadingBloc>().add(StartLoading());
                                final res = await repo
                                    .updateBooking(MakeUpdateBookingModel(
                                  bookingId: booking.id,
                                  returnDate: booking.returnDate,
                                  returnCondition: booking.returnCondition,
                                  vehicleLongitude: booking.vehicleLongitude,
                                  vehicleLatitude: booking.vehicleLatitude,
                                  toDate: booking.toDate,
                                  fromDate: booking.fromDate,
                                  status: 'booked',
                                  customerId: booking.customer?.id,
                                  vehicleId: booking.vehicle?.id,
                                  withDriver: booking.withDriver,
                                  receiptVoucherId: booking.receiptVoucher?.id,
                                ));
                                await getIt<VehicleRepository>().updateVehicle(
                                    booking.vehicle!
                                        .copyWith(status: 'on-rent'));
                                if (context.mounted) {
                                  context
                                      .read<LoadingBloc>()
                                      .add(StopLoading());
                                  context
                                      .read<AllVehiclesBloc>()
                                      .add(LoadAllVehiclesEvent());
                                  context
                                      .read<AvailableForRentVehiclesBloc>()
                                      .add(LoadAvailableForRentVehiclesEvent());
                                  context
                                      .read<PendingBookingsBloc>()
                                      .add(LoadPendingBookingsEvent());
                                  context
                                      .read<ApprovedBookingsBloc>()
                                      .add(LoadApprovedBookingsEvent());

                                  utils.showSuccessFlushBar(context,
                                      message: res.message ??
                                          "Booking approved successfully");
                                }
                              } catch (e, stackTrace) {
                                if (context.mounted) {
                                  debugPrint(stackTrace.toString());
                                  context
                                      .read<LoadingBloc>()
                                      .add(StopLoading());
                                  utils.showErrorFlushBar(context,
                                      message: e.toString());
                                }
                              }
                            }
                          }
                        : null,
                    style: ElevatedButton.styleFrom(
                        backgroundColor: getIt<AppColors>().kPrimaryColor),
                    child: Text(
                      'Approve',
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: context.colorScheme.surface),
                    ),
                  ),
                ),
              ],
            )
          ],
          if (showEditIcon)
            Align(
              alignment: Alignment.centerRight,
              child: IconButton.outlined(
                  onPressed: () {
                    getIt<NavigationHelper>().push(
                        context,
                        AddUpdatePaymentReceiptView(
                          booking: booking,
                        ));
                  },
                  padding: EdgeInsets.zero,
                  style: IconButton.styleFrom(
                      side:
                          BorderSide(color: getIt<AppColors>().kPrimaryColor)),
                  icon: Image.asset(
                    Assets.iconsEdit2,
                    color: getIt<AppColors>().kPrimaryColor,
                    height: 18,
                    width: 18,
                  )).space(height: 30, width: 30),
            )
        ],
      ),
    );
  }

  String getRelativeDateText(DateTime? date) {
    if (date == null) return "Date not provided";

    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final comparisonDate = DateTime(date.year, date.month, date.day);

    final difference = comparisonDate.difference(today).inDays;

    switch (difference) {
      case 0:
        return "Today";
      case 1:
        return "Tomorrow";
      case -1:
        return "Yesterday";
      default:
        if (difference > 1) {
          return "$difference days after";
        } else {
          return "${-difference} days before";
        }
    }
  }

  String formatDateRange(DateTime? startDate, DateTime? endDate) {
    if (startDate == null && endDate == null) {
      return "No dates provided";
    }

    final dateFormat = DateFormat("MMM d, y");

    String formatDate(DateTime? date) {
      return date == null ? "N/A" : dateFormat.format(date);
    }

    return "${formatDate(startDate)} - ${formatDate(endDate)}";
  }
}
