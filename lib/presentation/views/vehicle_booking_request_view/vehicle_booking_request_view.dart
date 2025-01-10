import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../blocs/customer/all_customers/all_customers_bloc.dart';
import '../../../blocs/master_data/vehicle_all_types_bloc/vehicle_all_types_bloc.dart';
import '../../../constants/extensions.dart';
import '../../../data/models/master_data/vehicle_model_model.dart';
import '../../../data/models/vehicle/vehicle_model.dart';
import '../../../domain/implementations/master_data/master_data_repository.dart';
import '../../../generated/assets.dart';
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
    final state = context.read<VehicleAllTypesBloc>().state;
    String vehicleType = '';
    if (state is VehicleAllTypesLoaded) {
      vehicleType = state.allTypes
              .where(
                (element) => element.id == widget.vehicle.carTypeId,
              )
              .firstOrNull
              ?.typeName ??
          "";
    }
    final vehicleDetails = [
      {'label': 'Color', 'value': widget.vehicle.color ?? ""},
      {'label': 'City', 'value': widget.vehicle.regCity ?? ""},
    ];
    return Scaffold(
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
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                        color: context.colorScheme.onPrimary,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                            color: context.colorScheme.outline.withOp(0.5))),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: widget.vehicle.images?.firstOrNull != null
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
                                children: [
                              FutureBuilder<VehicleModelModel?>(
                                  future: getIt<MasterDataRepository>()
                                      .getVehicleModelModelById(
                                          vehicleModelId:
                                              widget.vehicle.carModelId ?? ""),
                                  builder: (context, snap) {
                                    return _buildDetailRow(
                                      vehicleType,
                                      '${snap.data?.modelName ?? ""} ${widget.vehicle.yearOfModel ?? ""}',
                                      isLast: false,
                                    );
                                  }),
                              ...List.generate(
                                vehicleDetails.length,
                                (index) {
                                  final detail = vehicleDetails[index];
                                  return _buildDetailRow(
                                    detail['label']!,
                                    detail['value']!,
                                    isLast: false,
                                  );
                                },
                              ),
                              ValueListenableBuilder(
                                  valueListenable: _isWithOutDriver,
                                  builder: (context, isWithOutDriver, child) {
                                    return _buildDetailRow(
                                        'Rate',
                                        isWithOutDriver
                                            ? 'Rs.${widget.vehicle.rateWithoutDriver ?? ""}/without driver'
                                            : 'Rs.${widget.vehicle.rateWithDriver ?? ""}/with driver',
                                        isLast: true);
                                  }),
                            ])),
                      ],
                    ),
                  ),
                  16.height,
                  Row(
                    children: [
                      Text(
                        'Booking With Driver',
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w500),
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
                      color: context.colorScheme.onPrimaryContainer.withOp(0.6),
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
                          color: context.colorScheme.outline,
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
                              color: context.colorScheme.onPrimaryContainer
                                  .withOp(0.6),
                            ),
                          ),
                          8.height,
                          AppTextField(
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
                                      .subtract(Duration(days: 10000)),
                                  lastDate: DateTime.now()
                                      .add(Duration(days: 100000)),
                                  currentDate: DateTime.now(),
                                  initialDate: DateTime.tryParse(
                                      _pickupDateController.text),
                                );
                                if (date != null) {
                                  _pickupDateController.text =
                                      DateFormat('MMM d yyyy').format(date);
                                  _calculateAmount();
                                  FocusManager.instance.primaryFocus!.unfocus();
                                }
                              },
                              suffix: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Image.asset(
                                  Assets.iconsCalender2,
                                  height: 24,
                                  width: 24,
                                ),
                              ),
                              controller: _pickupDateController,
                              hintText: 'MMM d yyyy'),
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
                              color: context.colorScheme.onPrimaryContainer
                                  .withOp(0.6),
                            ),
                          ),
                          8.height,
                          AppTextField(
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
                                      .subtract(Duration(days: 10000)),
                                  lastDate: DateTime.now()
                                      .add(Duration(days: 100000)),
                                  currentDate: DateTime.now(),
                                  initialDate: DateTime.tryParse(
                                      _returnDateController.text),
                                );
                                if (date != null) {
                                  _returnDateController.text =
                                      DateFormat('MMM d yyyy').format(date);
                                  _calculateAmount();
                                  FocusManager.instance.primaryFocus!.unfocus();
                                }
                              },
                              suffix: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Image.asset(
                                  Assets.iconsCalender2,
                                  height: 24,
                                  width: 24,
                                ),
                              ),
                              controller: _returnDateController,
                              hintText: 'MMM d yyyy'),
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
                      color: context.colorScheme.onPrimaryContainer.withOp(0.6),
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
                            color: context.colorScheme.onPrimary,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: context.colorScheme.outline.withOp(0.7),
                            ),
                          ),
                          child: Text(
                            days < 0 ? '' : days.toString(),
                          ),
                        );
                      }),
                  16.height,
                  Text(
                    'Total Amount',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: context.colorScheme.onPrimaryContainer.withOp(0.6),
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
                            color: context.colorScheme.onPrimary,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: context.colorScheme.outline.withOp(0.7),
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
                                        decoration: TextDecoration.lineThrough,
                                      )
                                    : null,
                              ),
                              if (_discount.value > 0)
                                Text(
                                  " ${_amountAfterDiscount.value} (${_discount.value}% discount applied)",
                                ),
                            ],
                          ),
                        );
                      }),
                  34.height,
                  CustomElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {}
                      },
                      text: 'Book Now'),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value, {bool isLast = false}) {
    return Padding(
      padding: EdgeInsets.only(bottom: isLast ? 0 : 6),
      child: Text.rich(
        TextSpan(
          text: '$label :',
          children: [
            TextSpan(
              text: '   $value',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: Color(0xff585858),
              ),
            ),
          ],
        ),
        style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
      ),
    );
  }
}
