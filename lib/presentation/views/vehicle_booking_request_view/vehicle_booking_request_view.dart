import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:loading_overlay/loading_overlay.dart';

import '../../../blocs/booking/pending_bookings_bloc/pending_bookings_bloc.dart';
import '../../../blocs/customer/all_customers/all_customers_bloc.dart';
import '../../../blocs/loading_bloc/loading_bloc.dart';
import '../../../blocs/master_data/vehicle_all_makes_bloc/vehicle_all_makes_bloc.dart';
import '../../../blocs/master_data/vehicle_models_bloc/vehicle_models_bloc.dart';
import '../../../blocs/vehicle/all_vehicles_bloc/all_vehicles_bloc.dart';
import '../../../blocs/vehicle/available_for_rent_vehicles_bloc/available_for_rent_vehicles_bloc.dart';
import '../../../constants/app_colors.dart';
import '../../../constants/extensions.dart';
import '../../../data/models/booking/make_update_booking_model.dart';
import '../../../data/models/vehicle/vehicle_model.dart';
import '../../../domain/implementations/booking/booking_repository.dart';
import '../../../generated/assets.dart';
import '../../../navigation/navigation_helper.dart';
import '../../../utils/utils.dart';
import '../../elements/app_text_field.dart';
import '../../elements/custom_drop_down.dart';
import '../../elements/custom_elevated_button.dart';
import '../../elements/gradient_body.dart';

class VehicleBookingRequestView extends StatefulWidget {
  const VehicleBookingRequestView({super.key, required this.vehicle});

  final VehicleModel vehicle;

  @override
  State<VehicleBookingRequestView> createState() =>
      _VehicleBookingRequestViewState();
}

class _VehicleBookingRequestViewState extends State<VehicleBookingRequestView> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _pickupDateController = TextEditingController();
  final TextEditingController _returnDateController = TextEditingController();
  final ValueNotifier<bool> _isWithOutDriver = ValueNotifier(true);
  MapEntry<String, String>? _customer;
  final ValueNotifier<int> _totalDays = ValueNotifier(0);
  final ValueNotifier<int> _totalAmount = ValueNotifier(0);
  final ValueNotifier<num> _discount = ValueNotifier(0);
  final ValueNotifier<int> _amountAfterDiscount = ValueNotifier(0);

  @override
  void dispose() {
    _pickupDateController.dispose();
    _returnDateController.dispose();
    _isWithOutDriver.dispose();
    _totalDays.dispose();
    _totalAmount.dispose();
    _discount.dispose();
    _amountAfterDiscount.dispose();
    super.dispose();
  }

  _calculateAmount() {
    final startDate =
        DateFormat('MMM d yyyy').tryParse(_pickupDateController.text);
    final endDate =
        DateFormat('MMM d yyyy').tryParse(_returnDateController.text);
    if (endDate != null && startDate != null) {
      _totalDays.value = endDate.difference(startDate).inDays;
      if (_totalDays.value > 0) {
        _totalAmount.value = _totalDays.value *
            (int.tryParse(_isWithOutDriver.value
                    ? widget.vehicle.rateWithoutDriver ?? ""
                    : widget.vehicle.rateWithDriver ?? "") ??
                0);
        if (_totalDays.value >= 30) {
          _discount.value =
              (num.tryParse(widget.vehicle.discountMonth ?? "0")) ?? 0;
          _amountAfterDiscount.value =
              (_totalAmount.value * (_discount.value / 100)).toInt();
        } else if (_totalDays.value >= 7) {
          _discount.value =
              (num.tryParse(widget.vehicle.discountWeek ?? "0")) ?? 0;
          _amountAfterDiscount.value =
              (_totalAmount.value * (_discount.value / 100)).toInt();
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = context.read<VehicleAllMakesBloc>().state;
    final stateModels = context.read<VehicleModelsBloc>().state;
    String vehicleMake = '';
    String vehicleModel = '';
    if (state is VehicleAllMakesLoaded) {
      vehicleMake = state.allMakes
              .where(
                (element) =>
                    element.makeName?.toLowerCase() ==
                    widget.vehicle.makeName?.toLowerCase(),
              )
              .firstOrNull
              ?.makeName ??
          "";
    }
    if (stateModels is VehicleModelsLoaded) {
      vehicleModel = stateModels.models
              .where(
                (element) => element.id == widget.vehicle.carModelId,
              )
              .firstOrNull
              ?.modelName ??
          "";
    }
    final vehicleDetails = [
      {'label': vehicleMake, 'value': vehicleModel},
      {'label': 'Reg', 'value': widget.vehicle.regNo ?? ""},
      {'label': 'Color', 'value': widget.vehicle.color ?? ""},
      {'label': 'City', 'value': widget.vehicle.regCity ?? ""},
    ];

    return BlocProvider<LoadingBloc>(
      create: (context) => LoadingBloc(),
      child: Builder(builder: (context) {
        return LoadingOverlay(
          isLoading: context.select((LoadingBloc bloc) => bloc.state.isLoading),
          progressIndicator: CircularProgressIndicator.adaptive(),
          child: Scaffold(
            extendBodyBehindAppBar: true,
            appBar: AppBar(
              leading: getIt<Utils>().popIcon(context),
              title: const Text('Booking Request'),
            ),
            body: GradientBody(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: double.infinity,
                          padding:
                              EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                          decoration: BoxDecoration(
                              color: getIt<AppColors>().kCardColor,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                  color: context.colorScheme.outline)),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: widget.vehicle.images?.firstOrNull !=
                                          null
                                      ? Image.network(
                                          widget.vehicle.images!.firstOrNull!,
                                          height: 100,
                                          width: 100,
                                          fit: BoxFit.cover,
                                        )
                                      : SizedBox(
                                          height: 100,
                                          width: 100,
                                        )),
                              12.width,
                              Expanded(
                                  child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: List.generate(
                                  vehicleDetails.length,
                                  (index) {
                                    final detail = vehicleDetails[index];
                                    return _buildDetailRow(
                                      detail['label']!,
                                      detail['value']!,
                                      isLast:
                                          index == vehicleDetails.length - 1,
                                    );
                                  },
                                ),
                              )),
                            ],
                          ),
                        ),
                        16.height,
                        Row(
                          children: [
                            Text(
                              'Booking With Driver',
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: context.colorScheme.onPrimary),
                            ),
                            Spacer(),
                            ValueListenableBuilder(
                                valueListenable: _isWithOutDriver,
                                builder: (context, isWithOutDriver, child) {
                                  return Switch.adaptive(
                                    value: !isWithOutDriver,
                                    onChanged: (value) {
                                      _isWithOutDriver.value = !value;
                                      _calculateAmount();
                                    },
                                  );
                                }),
                          ],
                        ),
                        Divider(),
                        16.height,
                        Text(
                          'Customer',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: context.colorScheme.onPrimary,
                          ),
                        ),
                        8.height,
                        BlocBuilder<AllCustomersBloc, AllCustomersState>(
                          builder: (context, state) {
                            return CustomDropDown(
                              prefixIcon: Image.asset(
                                Assets.iconsOwners,
                                height: 24,
                                width: 24,
                                color: context.colorScheme.onPrimary,
                              ),
                              label: 'Select Customer',
                              dropdownMenuEntries: (state is AllCustomersLoaded)
                                  ? (state.customers.map(
                                      (e) => MapEntry(e.id ?? "", e.name ?? ""),
                                    )).toList()
                                  : [],
                              onSelected: (val) {
                                if (val != null) {
                                  _customer = val;
                                }
                              },
                              errorMessageIfRequired: 'Kindly Select Customer',
                              enabled: (state is AllCustomersLoaded),
                              initialItem: _customer,
                            );
                          },
                        ),
                        16.height,
                        Row(
                          spacing: 14,
                          children: [
                            Expanded(
                                child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Pickup Date',
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: context.colorScheme.onPrimary),
                                ),
                                8.height,
                                ListenableBuilder(
                                    listenable: _pickupDateController,
                                    builder: (context, _) {
                                      return AppTextField(
                                          readOnly: true,
                                          validator: (val) {
                                            if (val == null || val.isEmpty) {
                                              return "Kindly enter pickup date";
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
                                                  _pickupDateController.text),
                                            );
                                            if (date != null) {
                                              _pickupDateController.text =
                                                  DateFormat('MMM d yyyy')
                                                      .format(date);
                                              _calculateAmount();
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
                                          controller: _pickupDateController,
                                          hintText: 'MMM d yyyy');
                                    }),
                              ],
                            )),
                            Expanded(
                                child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Return Date',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: context.colorScheme.onPrimary,
                                  ),
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
                                              _calculateAmount();
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
                          ],
                        ),
                        16.height,
                        Text(
                          'Total Days',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: context.colorScheme.onPrimary,
                          ),
                        ),
                        8.height,
                        ValueListenableBuilder(
                            valueListenable: _totalDays,
                            builder: (context, days, _) {
                              return Container(
                                width: double.infinity,
                                padding: const EdgeInsets.all(14),
                                decoration: BoxDecoration(
                                  color: context.colorScheme.secondary,
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: context.colorScheme.surface,
                                  ),
                                ),
                                child: Text(
                                  days < 0 ? '' : days.toString(),
                                  style: TextStyle(
                                      color: context.colorScheme.onPrimary),
                                ),
                              );
                            }),
                        16.height,
                        Text(
                          'Total Amount',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: context.colorScheme.onPrimary,
                          ),
                        ),
                        8.height,
                        ListenableBuilder(
                            listenable: Listenable.merge([
                              _totalAmount,
                              _discount,
                              _amountAfterDiscount,
                            ]),
                            builder: (context, _) {
                              return Container(
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
                                      _totalAmount.value <= 0
                                          ? ''
                                          : _totalAmount.value.toString(),
                                      style: _discount.value > 0
                                          ? TextStyle(
                                              decoration:
                                                  TextDecoration.lineThrough,
                                              color:
                                                  context.colorScheme.onPrimary)
                                          : TextStyle(
                                              color: context
                                                  .colorScheme.onPrimary),
                                    ),
                                    if (_discount.value > 0)
                                      Text(
                                        " ${_amountAfterDiscount.value} (${_discount.value}% discount applied)",
                                        style: TextStyle(
                                            color:
                                                context.colorScheme.onPrimary),
                                      ),
                                  ],
                                ),
                              );
                            }),
                        34.height,
                        CustomElevatedButton(
                            onPressed: () async {
                              final utils = getIt<Utils>();
                              if (_formKey.currentState!.validate() &&
                                  !context
                                      .read<LoadingBloc>()
                                      .state
                                      .isLoading) {
                                final repo = getIt<BookingRepository>();

                                try {
                                  context
                                      .read<LoadingBloc>()
                                      .add(StartLoading());
                                  final res = await repo
                                      .createBooking(MakeUpdateBookingModel(
                                    customerId: _customer?.key,
                                    fromDate: DateFormat('MMM d yyyy').parse(
                                        _pickupDateController.text.trim()),
                                    toDate: DateFormat('MMM d yyyy').parse(
                                        _returnDateController.text.trim()),
                                    vehicleId: widget.vehicle.id,
                                    withDriver: !_isWithOutDriver.value,
                                    vehicleLatitude: 0,
                                    vehicleLongitude: 0,
                                    returnCondition: '',
                                  ));
                                  if (mounted && context.mounted) {
                                    context
                                        .read<LoadingBloc>()
                                        .add(StopLoading());
                                    context
                                        .read<AllVehiclesBloc>()
                                        .add(LoadAllVehiclesEvent());
                                    context
                                        .read<AvailableForRentVehiclesBloc>()
                                        .add(
                                            LoadAvailableForRentVehiclesEvent());
                                    context
                                        .read<PendingBookingsBloc>()
                                        .add(LoadPendingBookingsEvent());

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
                            text: 'Book Now'),
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

  Widget _buildDetailRow(String label, String value, {bool isLast = false}) {
    return Padding(
      padding: EdgeInsets.only(bottom: isLast ? 0 : 6),
      child: Text(
        '$label :  $value',
        style: TextStyle(
            fontSize: 12, fontWeight: FontWeight.w400, color: Colors.white),
      ),
    );
  }
}
