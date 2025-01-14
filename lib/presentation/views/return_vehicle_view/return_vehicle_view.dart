import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:loading_overlay/loading_overlay.dart';

import '../../../blocs/booking/approved_bookings_bloc/approved_bookings_bloc.dart';
import '../../../blocs/booking/pending_bookings_bloc/pending_bookings_bloc.dart';
import '../../../blocs/loading_bloc/loading_bloc.dart';
import '../../../blocs/vehicle/all_vehicles_bloc/all_vehicles_bloc.dart';
import '../../../blocs/vehicle/available_for_rent_vehicles_bloc/available_for_rent_vehicles_bloc.dart';
import '../../../constants/extensions.dart';
import '../../../data/models/booking/booking_list_model.dart';
import '../../../data/models/booking/make_update_booking_model.dart';
import '../../../domain/implementations/booking/booking_repository.dart';
import '../../../domain/implementations/vehicle/vehicle_repository.dart';
import '../../../generated/assets.dart';
import '../../../navigation/navigation_helper.dart';
import '../../../utils/utils.dart';
import '../../elements/app_text_field.dart';
import '../../elements/custom_elevated_button.dart';
import '../../elements/gradient_body.dart';
import '../add_update_payment_receipt_view/add_update_payment_receipt_view.dart';
import '../rental_requests_view/widgets/booking_card.dart';

class ReturnVehicleView extends StatefulWidget {
  const ReturnVehicleView({super.key, required this.booking});

  final BookingListModel booking;

  @override
  State<ReturnVehicleView> createState() => _ReturnVehicleViewState();
}

class _ReturnVehicleViewState extends State<ReturnVehicleView> {
  final _returnDateController = TextEditingController();
  final _returnTimeController = TextEditingController();
  final _returnConditionController = TextEditingController();
  final _key = GlobalKey<FormState>();

  @override
  void dispose() {
    _returnDateController.dispose();
    _returnTimeController.dispose();
    _returnConditionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoadingBloc(),
      child: Builder(builder: (context) {
        return LoadingOverlay(
          isLoading: context.select((LoadingBloc bloc) => bloc.state.isLoading),
          progressIndicator: CircularProgressIndicator.adaptive(),
          child: Scaffold(
            extendBodyBehindAppBar: true,
            appBar: AppBar(
              leading: getIt<Utils>().popIcon(context),
              title: const Text('Return Vehicle'),
            ),
            body: GradientBody(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Form(
                    key: _key,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        BlocBuilder<ApprovedBookingsBloc,
                            ApprovedBookingsState>(
                          builder: (context, state) {
                            final booking = (state is ApprovedBookingsLoaded)
                                ? state.bookings
                                        .where(
                                          (element) =>
                                              element.id == widget.booking.id,
                                        )
                                        .firstOrNull ??
                                    widget.booking
                                : widget.booking;
                            return BookingCard(
                              booking: booking,
                              showActions: false,
                              showEditIcon: false,
                            );
                          },
                        ),
                        Divider(
                          height: 10,
                        ),
                        Row(
                          spacing: 14,
                          children: [
                            Expanded(
                                child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Return Date',
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: context.colorScheme.onPrimary),
                                ),
                                8.height,
                                ListenableBuilder(
                                    listenable: _returnDateController,
                                    builder: (context, _) {
                                      return AppTextField(
                                          readOnly: true,
                                          validator: (val) {
                                            if (val == null || val.isEmpty) {
                                              return "Kindly enter return date";
                                            }
                                            return null;
                                          },
                                          onTap: () async {
                                            final date = await showDatePicker(
                                              context: context,
                                              firstDate: DateTime.now()
                                                  .subtract(
                                                      Duration(days: 10000)),
                                              lastDate: DateTime.now()
                                                  .add(Duration(days: 100000)),
                                              currentDate: DateTime.now(),
                                              initialDate: DateTime.tryParse(
                                                  _returnDateController.text),
                                            );
                                            if (date != null) {
                                              _returnDateController.text =
                                                  DateFormat('MMM d yyyy')
                                                      .format(date);
                                              FocusManager
                                                  .instance.primaryFocus!
                                                  .unfocus();
                                            }
                                          },
                                          suffix: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Image.asset(
                                              Assets.iconsCalender2,
                                              height: 24,
                                              width: 24,
                                              color:
                                                  context.colorScheme.onPrimary,
                                            ),
                                          ),
                                          controller: _returnDateController,
                                          hintText: 'MMM d yyyy');
                                    }),
                              ],
                            )),
                            Expanded(
                                child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Return Time',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: context.colorScheme.onPrimary,
                                  ),
                                ),
                                8.height,
                                ListenableBuilder(
                                    listenable: _returnTimeController,
                                    builder: (context, _) {
                                      return AppTextField(
                                          readOnly: true,
                                          validator: (val) {
                                            if (val == null || val.isEmpty) {
                                              return "Kindly enter return time";
                                            }
                                            return null;
                                          },
                                          onTap: () async {
                                            final time = await showTimePicker(
                                              context: context,
                                              initialTime: TimeOfDay.now(),
                                            );
                                            if (time != null) {
                                              final now = DateTime.now();
                                              final DateTime dateTime =
                                                  DateTime(
                                                      now.year,
                                                      now.month,
                                                      now.day,
                                                      time.hour,
                                                      time.minute);
                                              _returnTimeController.text =
                                                  DateFormat('h:mm a')
                                                      .format(dateTime);

                                              FocusManager
                                                  .instance.primaryFocus!
                                                  .unfocus();
                                            }
                                          },
                                          suffix: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Image.asset(
                                              Assets.iconsClock,
                                              height: 24,
                                              width: 24,
                                              color:
                                                  context.colorScheme.onPrimary,
                                            ),
                                          ),
                                          controller: _returnTimeController,
                                          hintText: '10:00 AM');
                                    }),
                              ],
                            )),
                          ],
                        ),
                        18.height,
                        Text(
                          'Condition',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: context.colorScheme.onPrimary),
                        ),
                        10.height,
                        AppTextField(
                            maxLines: 3,
                            controller: _returnConditionController,
                            hintText: 'What Condition'),
                        18.height,
                        BlocBuilder<ApprovedBookingsBloc,
                            ApprovedBookingsState>(
                          builder: (context, state) {
                            final booking = (state is ApprovedBookingsLoaded)
                                ? state.bookings
                                        .where(
                                          (element) =>
                                              element.id == widget.booking.id,
                                        )
                                        .firstOrNull ??
                                    widget.booking
                                : widget.booking;
                            return GestureDetector(
                              onTap: () {
                                getIt<NavigationHelper>().push(
                                    context,
                                    AddUpdatePaymentReceiptView(
                                        booking: booking));
                              },
                              child: Container(
                                width: double.infinity,
                                padding: const EdgeInsets.all(14),
                                decoration: BoxDecoration(
                                  color: context.colorScheme.secondary,
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: context.colorScheme.surface,
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Text(
                                      'Receipt voucher Id:\n${widget.booking.receiptVoucher?.id}',
                                      style: TextStyle(
                                          color: context.colorScheme.onPrimary),
                                    ),
                                    Spacer(),
                                    Icon(
                                      Icons.adaptive.arrow_forward,
                                      color: context.colorScheme.onPrimary,
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                        18.height,
                        Row(
                          children: [
                            Expanded(
                              child: OutlinedButton(
                                onPressed: () {
                                  getIt<NavigationHelper>().pop(context);
                                },
                                style: OutlinedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(14)),
                                ),
                                child: Text(
                                  'Cancel',
                                ),
                              ).space(height: 54),
                            ),
                            14.width,
                            Expanded(
                              child: CustomElevatedButton(
                                onPressed: () async {
                                  final utils = getIt<Utils>();
                                  if (_key.currentState!.validate() &&
                                      !context
                                          .read<LoadingBloc>()
                                          .state
                                          .isLoading) {
                                    final repo = getIt<BookingRepository>();

                                    try {
                                      context
                                          .read<LoadingBloc>()
                                          .add(StartLoading());
                                      final returnDate =
                                          DateFormat('MMM d yyyy').parse(
                                              _returnDateController.text
                                                  .trim());
                                      final returnTime = DateFormat('h:mm a')
                                          .parse(_returnTimeController.text
                                              .trim());
                                      final res = await repo
                                          .updateBooking(MakeUpdateBookingModel(
                                        bookingId: widget.booking.id,
                                        returnDate: returnDate.copyWith(
                                            hour: returnTime.hour,
                                            minute: returnTime.minute),
                                        returnCondition:
                                            _returnConditionController.text
                                                .trim(),
                                        vehicleLongitude:
                                            widget.booking.vehicleLongitude,
                                        vehicleLatitude:
                                            widget.booking.vehicleLatitude,
                                        toDate: widget.booking.toDate,
                                        fromDate: widget.booking.fromDate,
                                        status: 'returned',
                                        receiptVoucherId:
                                            widget.booking.receiptVoucher?.id,
                                        customerId: widget.booking.customer?.id,
                                        vehicleId: widget.booking.vehicle?.id,
                                        withDriver: widget.booking.withDriver,
                                      ));
                                      await getIt<VehicleRepository>()
                                          .updateVehicle(widget.booking.vehicle!
                                              .copyWith(status: 'available'));
                                      if (mounted && context.mounted) {
                                        context
                                            .read<LoadingBloc>()
                                            .add(StopLoading());
                                        context
                                            .read<AllVehiclesBloc>()
                                            .add(LoadAllVehiclesEvent());
                                        context
                                            .read<
                                                AvailableForRentVehiclesBloc>()
                                            .add(
                                                LoadAvailableForRentVehiclesEvent());
                                        context
                                            .read<PendingBookingsBloc>()
                                            .add(LoadPendingBookingsEvent());
                                        context
                                            .read<ApprovedBookingsBloc>()
                                            .add(LoadApprovedBookingsEvent());

                                        getIt<NavigationHelper>().pop(context);
                                        getIt<NavigationHelper>().pop(context);
                                        utils.showSuccessFlushBar(context,
                                            message: res.message ??
                                                "Booking made successfully");
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
                                },
                                text: 'Return',
                              ),
                            ),
                          ],
                        ),
                        20.height,
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
