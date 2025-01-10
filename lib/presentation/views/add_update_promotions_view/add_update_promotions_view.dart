import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:loading_overlay/loading_overlay.dart';

import '../../../blocs/loading_bloc/loading_bloc.dart';
import '../../../blocs/promotion/all_promotions_bloc/all_promotions_bloc.dart';
import '../../../constants/extensions.dart';
import '../../../data/models/promotion/promotion_model.dart';
import '../../../data/models/vehicle/vehicle_model.dart';
import '../../../domain/implementations/promotion/promotion_repository.dart';
import '../../../generated/assets.dart';
import '../../../navigation/navigation_helper.dart';
import '../../../utils/utils.dart';
import '../../elements/app_text_field.dart';
import '../../elements/custom_elevated_button.dart';
import '../../elements/gradient_body.dart';
import '../assign_vehicles_to_promotion_view/assign_vehicles_to_promotion_view.dart';

class AddUpdatePromotionsView extends StatefulWidget {
  const AddUpdatePromotionsView(
      {super.key, this.promotion, this.assignedVehicles});

  final PromotionInfo? promotion;
  final List<VehicleModel>? assignedVehicles;

  @override
  State<AddUpdatePromotionsView> createState() =>
      _AddUpdatePromotionsViewState();
}

class _AddUpdatePromotionsViewState extends State<AddUpdatePromotionsView> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _discountController = TextEditingController();
  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  ValueNotifier<bool> _isActive = ValueNotifier<bool>(false);
  ValueNotifier<List<VehicleModel>> _assignedVehicles =
      ValueNotifier<List<VehicleModel>>([]);
  final _key = GlobalKey<FormState>();

  @override
  void initState() {
    if (widget.promotion != null) {
      _titleController.text = widget.promotion!.promoTitle ?? "";
      _discountController.text =
          widget.promotion!.discountPercentage.toString();
      _startDateController.text =
          DateFormat('MMM d yyyy').format(widget.promotion!.startDate!);
      _endDateController.text =
          DateFormat('MMM d yyyy').format(widget.promotion!.endDate!);
      _descriptionController.text = widget.promotion!.description ?? "";
      _isActive = ValueNotifier<bool>(widget.promotion!.isActive!);
      _assignedVehicles =
          ValueNotifier<List<VehicleModel>>(widget.assignedVehicles ?? []);
    }
    super.initState();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _discountController.dispose();
    _startDateController.dispose();
    _endDateController.dispose();
    _descriptionController.dispose();
    _isActive.dispose();
    _assignedVehicles.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoadingBloc(),
      child: Builder(builder: (context) {
        return LoadingOverlay(
          isLoading: context.select((LoadingBloc bloc) => bloc.state.isLoading),
          color: context.colorScheme.primary.withOp(0.2),
          progressIndicator: CircularProgressIndicator.adaptive(
            backgroundColor: context.colorScheme.onPrimary,
          ),
          child: Scaffold(
            extendBodyBehindAppBar: true,
            appBar: AppBar(
              leading: getIt<Utils>().popIcon(context),
              title: const Text('Add Promotion'),
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
                        Text(
                          'Promotion title',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: context.colorScheme.onPrimaryContainer
                                .withOp(0.6),
                          ),
                        ),
                        8.height,
                        AppTextField(
                            controller: _titleController,
                            validator: (val) {
                              if (val == null || val.isEmpty) {
                                return "Kindly enter title";
                              }
                              return null;
                            },
                            hintText: 'e.g. Weekly Discount, Eid Offer'),
                        16.height,
                        Text(
                          'Discount Percentage',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: context.colorScheme.onPrimaryContainer
                                .withOp(0.6),
                          ),
                        ),
                        8.height,
                        AppTextField(
                            controller: _discountController,
                            validator: (val) {
                              if (val == null || val.isEmpty) {
                                return 'Kindly enter discount';
                              } else if (val.isNotEmpty && !val.isPercentage) {
                                return 'Kindly enter valid discount from 0 to 100';
                              }
                              return null;
                            },
                            textInputType:
                                TextInputType.numberWithOptions(signed: false),
                            hintText: 'Enter Percentage'),
                        16.height,
                        Text(
                          'Vehicle Select',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: context.colorScheme.onPrimaryContainer
                                .withOp(0.6),
                          ),
                        ),
                        8.height,
                        InkWell(
                          onTap: () async {
                            final val = await getIt<NavigationHelper>().push(
                                context,
                                AssignVehiclesToPromotionView(
                                  assignedVehicles: _assignedVehicles.value,
                                ));
                            if (val != null && val is List<VehicleModel>) {
                              _assignedVehicles.value = val;
                            }
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color:
                                      context.colorScheme.outline.withOp(0.7),
                                )),
                            padding: EdgeInsets.all(12),
                            child: Row(
                              children: [
                                Text(
                                  'Select Vehicles',
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: context
                                          .colorScheme.onSecondaryContainer
                                          .withOp(0.8)),
                                ),
                                Spacer(),
                                Icon(Icons.adaptive.arrow_forward)
                              ],
                            ),
                          ),
                        ),
                        16.height,
                        ValueListenableBuilder(
                            valueListenable: _assignedVehicles,
                            builder: (context, list, child) => Column(
                                  spacing: 6,
                                  children: list
                                      .map(
                                        (e) => Container(
                                          decoration: BoxDecoration(
                                              color:
                                                  context.colorScheme.onPrimary,
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              border: Border.all(
                                                color: context
                                                    .colorScheme.outline
                                                    .withOp(0.7),
                                              )),
                                          padding: EdgeInsets.all(14),
                                          child: Row(
                                            children: [
                                              Text(
                                                'Vehicle Registration No',
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w400,
                                                    color: context.colorScheme
                                                        .onSecondaryContainer
                                                        .withOp(0.8)),
                                              ),
                                              Spacer(),
                                              Text(
                                                'Reg: ${e.regNo ?? ""}',
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w400,
                                                    color: context
                                                        .colorScheme.primary
                                                        .withOp(0.8)),
                                              ),
                                            ],
                                          ),
                                        ),
                                      )
                                      .toList(),
                                )),
                        16.height,
                        Row(
                          spacing: 14,
                          children: [
                            Expanded(
                                child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Start Date',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: context
                                        .colorScheme.onPrimaryContainer
                                        .withOp(0.6),
                                  ),
                                ),
                                8.height,
                                AppTextField(
                                    readOnly: true,
                                    validator: (val) {
                                      if (val == null || val.isEmpty) {
                                        return "Kindly enter start date";
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
                                            _startDateController.text),
                                      );
                                      if (date != null) {
                                        _startDateController.text =
                                            DateFormat('MMM d yyyy')
                                                .format(date);
                                        FocusManager.instance.primaryFocus!
                                            .unfocus();
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
                                    controller: _startDateController,
                                    hintText: 'MMM d yyyy'),
                              ],
                            )),
                            Expanded(
                                child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'End Date',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: context
                                        .colorScheme.onPrimaryContainer
                                        .withOp(0.6),
                                  ),
                                ),
                                8.height,
                                AppTextField(
                                    readOnly: true,
                                    validator: (val) {
                                      if (val == null || val.isEmpty) {
                                        return "Kindly enter end date";
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
                                            _endDateController.text),
                                      );
                                      if (date != null) {
                                        _endDateController.text =
                                            DateFormat('MMM d yyyy')
                                                .format(date);
                                        FocusManager.instance.primaryFocus!
                                            .unfocus();
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
                                    controller: _endDateController,
                                    hintText: 'MMM d yyyy'),
                              ],
                            )),
                          ],
                        ),
                        16.height,
                        Text(
                          'Description',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: context.colorScheme.onPrimaryContainer
                                .withOp(0.6),
                          ),
                        ),
                        8.height,
                        AppTextField(
                            maxLines: 3,
                            controller: _descriptionController,
                            validator: (val) {
                              if (val == null || val.isEmpty) {
                                return "Kindly enter description";
                              }
                              return null;
                            },
                            hintText: 'Enter Description'),
                        16.height,
                        Container(
                          decoration: BoxDecoration(
                              color: context.colorScheme.onPrimary,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: context.colorScheme.outline.withOp(0.7),
                              )),
                          child: Row(
                            children: [
                              14.width,
                              Text(
                                'Status',
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: context
                                        .colorScheme.onSecondaryContainer
                                        .withOp(0.8)),
                              ),
                              Spacer(),
                              ValueListenableBuilder(
                                  valueListenable: _isActive,
                                  builder: (context, val, _) {
                                    return Switch.adaptive(
                                      value: val,
                                      onChanged: (value) {
                                        _isActive.value = value;
                                      },
                                    );
                                  }),
                              10.width,
                            ],
                          ),
                        ),
                        34.height,
                        Row(
                          children: [
                            Expanded(
                              child: OutlinedButton(
                                onPressed: () {
                                  _titleController.clear();
                                  _discountController.clear();
                                  _startDateController.clear();
                                  _endDateController.clear();
                                  _descriptionController.clear();
                                  _isActive.value = false;
                                  _assignedVehicles.value = [];
                                  setState(() {});
                                },
                                style: OutlinedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(14)),
                                ),
                                child: Text(
                                  'Reset',
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
                                    if (_assignedVehicles.value.isEmpty) {
                                      context
                                          .read<LoadingBloc>()
                                          .add(StopLoading());
                                      utils.showErrorFlushBar(context,
                                          message:
                                              "Kindly assign vehicles to promotion");
                                      return;
                                    }
                                    final repo = getIt<PromotionRepository>();

                                    try {
                                      context
                                          .read<LoadingBloc>()
                                          .add(StartLoading());
                                      final res = widget.promotion != null
                                          ? await repo.updatePromotion(
                                              widget.promotion!.copyWith(
                                              description:
                                                  _descriptionController.text
                                                      .trim(),
                                              discountPercentage: int.tryParse(
                                                      _discountController
                                                          .text) ??
                                                  0,
                                              startDate:
                                                  DateFormat('MMM d yyyy')
                                                      .parse(
                                                          _startDateController
                                                              .text),
                                              endDate: DateFormat('MMM d yyyy')
                                                  .parse(
                                                      _endDateController.text),
                                              isActive: _isActive.value,
                                              promoTitle:
                                                  _titleController.text.trim(),
                                              vehicleList:
                                                  _assignedVehicles.value,
                                            ))
                                          : await repo
                                              .createPromotion(PromotionInfo(
                                              description:
                                                  _descriptionController.text
                                                      .trim(),
                                              discountPercentage: int.tryParse(
                                                      _discountController
                                                          .text) ??
                                                  0,
                                              startDate:
                                                  DateFormat('MMM d yyyy')
                                                      .parse(
                                                          _startDateController
                                                              .text),
                                              endDate: DateFormat('MMM d yyyy')
                                                  .parse(
                                                      _endDateController.text),
                                              isActive: _isActive.value,
                                              promoTitle:
                                                  _titleController.text.trim(),
                                              vehicleList:
                                                  _assignedVehicles.value,
                                              date: DateTime.now(),
                                            ));
                                      if (mounted && context.mounted) {
                                        context
                                            .read<LoadingBloc>()
                                            .add(StopLoading());
                                        context
                                            .read<AllPromotionsBloc>()
                                            .add(LoadAllPromotionsEvent());
                                        getIt<NavigationHelper>().pop(context);
                                        utils.showSuccessFlushBar(context,
                                            message: res.message ??
                                                (widget.promotion != null
                                                    ? "Promotion updated Successfully"
                                                    : "Promotion Added Successfully"));
                                      }
                                    } catch (e, stackTrace) {
                                      if (context.mounted) {
                                        debugPrint(stackTrace.toString());
                                        debugPrint(e.toString());
                                        context
                                            .read<LoadingBloc>()
                                            .add(StopLoading());
                                        utils.showErrorFlushBar(context,
                                            message: e.toString());
                                      }
                                    }
                                  }
                                },
                                text: 'Save',
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
