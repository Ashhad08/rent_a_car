import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/master_data/vehicle_all_colors_bloc/vehicle_all_colors_bloc.dart';
import '../../../blocs/master_data/vehicle_all_features_bloc/vehicle_all_features_bloc.dart';
import '../../../blocs/master_data/vehicle_all_types_bloc/vehicle_all_types_bloc.dart';
import '../../../blocs/master_data/vehicle_models_by_type_bloc/vehicle_models_by_type_bloc.dart';
import '../../../constants/extensions.dart';
import '../../../domain/implementations/master_data/master_data_repository.dart';
import '../../../generated/assets.dart';
import '../../../utils/utils.dart';
import '../../elements/app_text_field.dart';
import '../../elements/custom_drop_down.dart';
import '../../elements/custom_elevated_button.dart';
import '../../elements/gradient_body.dart';

class AddNewVehicleView extends StatefulWidget {
  const AddNewVehicleView({super.key});

  @override
  State<AddNewVehicleView> createState() => _AddNewVehicleViewState();
}

class _AddNewVehicleViewState extends State<AddNewVehicleView> {
  final _regNumberController = TextEditingController();
  final _regCityController = TextEditingController();
  final _yearOfModelController = TextEditingController();
  final _engineCapacityController = TextEditingController();
  final _chassisNumberController = TextEditingController();
  final _engineNumberController = TextEditingController();
  final _rateWithDriverController = TextEditingController();
  final _rateWithoutDriverController = TextEditingController();
  final _monthlyDiscountController = TextEditingController();
  final _weeklyDiscountController = TextEditingController();
  MapEntry<String, String>? _vehicleType;
  MapEntry<String, String>? _vehicleModel;
  MapEntry<String, String>? _vehicleColor;
  final ValueNotifier<List<String>> _selectedFeatures = ValueNotifier([]);

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> fuelTypes = [
      {
        'icon': Assets.iconsFuel,
        'text': 'Petrol',
      },
      {
        'icon': Assets.iconsElectricFuel,
        'text': 'Electric',
      },
      {
        'icon': Assets.iconsFuel,
        'text': 'Diesel',
      },
      {
        'icon': Assets.iconsElectricFuel,
        'text': 'Hybrid',
      },
    ];
    return BlocProvider(
      create: (context) =>
          VehicleModelsByTypeBloc(getIt<MasterDataRepository>()),
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          leading: getIt<Utils>().popIcon(context),
          title: const Text('New Vehicle Information'),
        ),
        body: GradientBody(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Vehicle Information',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                  16.height,
                  Text(
                    'Registration No',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: context.colorScheme.onPrimaryContainer.withOp(0.6),
                    ),
                  ),
                  8.height,
                  Row(
                    children: [
                      _buildIconContainer(context, Assets.iconsEditNote),
                      4.width,
                      Expanded(
                        child: AppTextField(
                            controller: _regNumberController,
                            hintText: 'Enter Registration Number'),
                      ),
                    ],
                  ),
                  16.height,
                  Text(
                    'Registered City',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: context.colorScheme.onPrimaryContainer.withOp(0.6),
                    ),
                  ),
                  8.height,
                  Row(
                    children: [
                      _buildIconContainer(context, Assets.iconsBuilding),
                      4.width,
                      Expanded(
                        child: AppTextField(
                            controller: _regCityController,
                            hintText: 'Enter Registered City'),
                      ),
                    ],
                  ),
                  16.height,
                  Text(
                    'Year of Model',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: context.colorScheme.onPrimaryContainer.withOp(0.6),
                    ),
                  ),
                  8.height,
                  Row(
                    children: [
                      _buildIconContainer(context, Assets.iconsBuilding),
                      4.width,
                      Expanded(
                        child: AppTextField(
                          controller: _yearOfModelController,
                          hintText: 'Enter Year of Model',
                          textInputType: TextInputType.numberWithOptions(
                              decimal: false, signed: false),
                        ),
                      ),
                    ],
                  ),
                  20.height,
                  Container(
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: context.colorScheme.onPrimary,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: context.colorScheme.outline.withOp(0.7),
                        ),
                      ),
                      child: Column(
                        children: [
                          BlocBuilder<VehicleAllTypesBloc,
                              VehicleAllTypesState>(
                            builder: (context, state) {
                              return CustomDropDown(
                                prefixIcon: Image.asset(
                                  Assets.iconsCarFront,
                                  height: 24,
                                  width: 24,
                                  color: context.colorScheme.outline,
                                ),
                                label: 'Car Type',
                                dropdownMenuEntries:
                                    (state is VehicleAllTypesLoaded)
                                        ? (state.allTypes.map(
                                            (e) => MapEntry(
                                                e.id ?? "", e.typeName ?? ""),
                                          )).toList()
                                        : [],
                                onSelected: (val) {
                                  if (val != null) {
                                    _vehicleType = val;
                                    context.read<VehicleModelsByTypeBloc>().add(
                                        LoadVehicleModelsByTypeEvent(
                                            typeId: val.key));
                                  }
                                },
                                enabled: (state is VehicleAllTypesLoaded)
                                    ? true
                                    : false,
                                initialItem: _vehicleType,
                              );
                            },
                          ),
                          16.height,
                          BlocBuilder<VehicleModelsByTypeBloc,
                              VehicleModelsByTypeState>(
                            builder: (context, state) {
                              return CustomDropDown(
                                prefixIcon: Image.asset(
                                  Assets.iconsCarFront,
                                  height: 24,
                                  width: 24,
                                  color: context.colorScheme.outline,
                                ),
                                label: 'Car Model',
                                dropdownMenuEntries:
                                    (state is VehicleModelsByTypeLoaded)
                                        ? (state.modelsByType.map(
                                            (e) => MapEntry(
                                                e.id ?? "", e.modelName ?? ""),
                                          )).toList()
                                        : [],
                                onSelected: (val) {
                                  if (val != null) {
                                    _vehicleModel = val;
                                  }
                                },
                                enabled: (state is VehicleModelsByTypeLoaded),
                                initialItem: _vehicleModel,
                              );
                            },
                          ),
                          16.height,
                          BlocBuilder<VehicleAllColorsBloc,
                              VehicleAllColorsState>(
                            builder: (context, state) {
                              return CustomDropDown(
                                prefixIcon: Image.asset(
                                  Assets.iconsColor2,
                                  height: 24,
                                  width: 24,
                                  color: context.colorScheme.outline,
                                ),
                                label: 'Color',
                                dropdownMenuEntries:
                                    (state is VehicleAllColorsLoaded)
                                        ? (state.allColors.map(
                                            (e) => MapEntry(
                                                e.id ?? "", e.colorName ?? ""),
                                          )).toList()
                                        : [],
                                onSelected: (val) {
                                  if (val != null) {
                                    _vehicleColor = val;
                                  }
                                },
                                enabled: (state is VehicleAllColorsLoaded),
                                initialItem: _vehicleColor,
                              );
                            },
                          ),
                          16.height,
                          CustomDropDown(
                            prefixIcon: Image.asset(
                              Assets.iconsSettings,
                              height: 24,
                              width: 24,
                              color: context.colorScheme.outline,
                            ),
                            label: 'Transmission Type',
                            dropdownMenuEntries: [
                              MapEntry("0", 'Manual'),
                              MapEntry("1", 'Automatic'),
                            ],
                            onSelected: (val) {},
                            enabled: true,
                            initialItem: null,
                          ),
                        ],
                      )),
                  16.height,
                  Text(
                    'Engine Capacity',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: context.colorScheme.onPrimaryContainer.withOp(0.6),
                    ),
                  ),
                  8.height,
                  AppTextField(
                    controller: _engineCapacityController,
                    hintText: 'Enter Engine Capacity',
                    textInputType: TextInputType.numberWithOptions(
                        decimal: false, signed: false),
                  ),
                  16.height,
                  Text(
                    'Chassis No',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: context.colorScheme.onPrimaryContainer.withOp(0.6),
                    ),
                  ),
                  8.height,
                  AppTextField(
                    controller: _chassisNumberController,
                    hintText: 'Enter Chassis Number',
                    textInputType: TextInputType.numberWithOptions(
                        decimal: false, signed: false),
                  ),
                  16.height,
                  Text(
                    'Engine No',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: context.colorScheme.onPrimaryContainer.withOp(0.6),
                    ),
                  ),
                  8.height,
                  AppTextField(
                    controller: _engineNumberController,
                    hintText: 'Enter Engine Number',
                    textInputType: TextInputType.numberWithOptions(
                        decimal: false, signed: false),
                  ),
                  16.height,
                  Text(
                    'Rate with driver',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: context.colorScheme.onPrimaryContainer.withOp(0.6),
                    ),
                  ),
                  8.height,
                  AppTextField(
                    controller: _rateWithDriverController,
                    hintText: 'Enter rate with driver',
                    textInputType: TextInputType.numberWithOptions(
                        decimal: false, signed: false),
                  ),
                  16.height,
                  Text(
                    'Rate without driver',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: context.colorScheme.onPrimaryContainer.withOp(0.6),
                    ),
                  ),
                  8.height,
                  AppTextField(
                    controller: _rateWithoutDriverController,
                    hintText: 'Enter rate without driver',
                    textInputType: TextInputType.numberWithOptions(
                        decimal: false, signed: false),
                  ),
                  16.height,
                  Text(
                    'Discount on week',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: context.colorScheme.onPrimaryContainer.withOp(0.6),
                    ),
                  ),
                  8.height,
                  AppTextField(
                    controller: _weeklyDiscountController,
                    hintText: 'Enter discount on week',
                    textInputType: TextInputType.numberWithOptions(
                        decimal: false, signed: false),
                  ),
                  16.height,
                  Text(
                    'Discount on month',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: context.colorScheme.onPrimaryContainer.withOp(0.6),
                    ),
                  ),
                  8.height,
                  AppTextField(
                    controller: _monthlyDiscountController,
                    hintText: 'Enter discount on month',
                    textInputType: TextInputType.numberWithOptions(
                        decimal: false, signed: false),
                  ),
                  18.height,
                  Text(
                    'Fuel Type',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  12.height,
                  GridView.builder(
                    itemCount: fuelTypes.length,
                    padding: EdgeInsets.zero,
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        childAspectRatio: 2 / 0.7),
                    itemBuilder: (context, index) {
                      final isSelected = index == 0;
                      return Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 13,
                        ),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? context.colorScheme.primary
                              : context.colorScheme.onPrimary,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: context.colorScheme.outline.withOp(0.5),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Image.asset(
                              fuelTypes[index]['icon'],
                              height: 16,
                              width: 16,
                              color: isSelected
                                  ? context.colorScheme.secondary
                                  : context.colorScheme.outline,
                            ),
                            10.width,
                            Expanded(
                                child: Text(
                              fuelTypes[index]['text'],
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: isSelected
                                    ? context.colorScheme.secondary
                                    : context.colorScheme.outline,
                              ),
                            ))
                          ],
                        ),
                      );
                    },
                  ),
                  35.height,
                  Text(
                    'Additional Features',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  ValueListenableBuilder(
                    valueListenable: _selectedFeatures,
                    builder: (context, selectedFeatures, child) => BlocBuilder<
                        VehicleAllFeaturesBloc, VehicleAllFeaturesState>(
                      builder: (context, state) {
                        if (state is VehicleAllFeaturesLoaded) {
                          return Column(
                            children: state.allFeatures
                                .map(
                                  (e) => CheckboxListTile(
                                    value: selectedFeatures
                                        .contains(e.featureName),
                                    title: Text(
                                      e.featureName ?? "",
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    contentPadding: EdgeInsets.zero,
                                    onChanged: (val) {
                                      final s = selectedFeatures;
                                      if (selectedFeatures
                                          .contains(e.featureName)) {
                                        s.remove(e.featureName);
                                        _selectedFeatures.value = s;
                                      } else {
                                        s.add(e.featureName ?? "");
                                        _selectedFeatures.value = s;
                                      }
                                    },
                                    dense: true,
                                    checkboxShape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(4)),
                                    controlAffinity:
                                        ListTileControlAffinity.leading,
                                  ),
                                )
                                .toList(),
                          );
                        }
                        return SizedBox.shrink();
                      },
                    ),
                  ),
                  10.height,
                  Row(
                    children: [
                      Text(
                        'Upload Photos',
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.w500),
                      ),
                      Spacer(),
                      Text(
                        '6/10',
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: context.colorScheme.outline),
                      ),
                    ],
                  ),
                  10.height,
                  Row(
                    children: [
                      Expanded(
                        child: _pickImageSource(
                          icon: Assets.iconsCamera,
                          context: context,
                          text: 'Take Photo',
                        ),
                      ),
                      18.width,
                      Expanded(
                          child: _pickImageSource(
                        icon: Assets.iconsUploadGallery,
                        context: context,
                        text: 'Upload Gallery',
                      )),
                    ],
                  ),
                  16.height,
                  ListView.separated(
                    separatorBuilder: (context, index) => 11.width,
                    scrollDirection: Axis.horizontal,
                    itemCount: 6,
                    itemBuilder: (context, index) => Stack(
                      children: [
                        Positioned(
                          bottom: 0,
                          right: 10,
                          left: 0,
                          child: Container(
                            height: 106,
                            width: 106,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: AssetImage(Assets.imagesCarDummy))),
                          ),
                        ),
                        Positioned(
                          top: 0,
                          right: 0,
                          child: Container(
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: Color(0xffF5F5F5),
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: context.colorScheme.onPrimary,
                              ),
                            ),
                            alignment: Alignment.center,
                            child: Icon(
                              CupertinoIcons.xmark,
                              size: 16,
                              color: context.colorScheme.error,
                            ),
                          ),
                        )
                      ],
                    ).space(
                      height: 115,
                      width: 119,
                    ),
                  ).space(
                    height: 115,
                    width: double.infinity,
                  ),
                  18.height,
                  Row(
                    children: [
                      Text(
                        'Vehicle Documents',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: context.colorScheme.primary),
                      ),
                      Spacer(),
                      Text(
                        '0/10',
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: context.colorScheme.outline),
                      ),
                    ],
                  ),
                  12.height,
                  _pickImageSource(
                    icon: Assets.iconsUploadCloud,
                    context: context,
                    text: 'Upload Documents',
                  ).space(width: double.infinity),
                  26.height,
                  CustomElevatedButton(
                      onPressed: () {}, text: 'Save Vehicle Information'),
                  20.height,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _pickImageSource(
      {required String icon,
      required String text,
      required BuildContext context}) {
    return DottedBorder(
      color: context.colorScheme.outline,
      borderType: BorderType.RRect,
      strokeCap: StrokeCap.round,
      dashPattern: [5],
      radius: Radius.circular(10),
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      child: Center(
        child: Column(
          children: [
            Container(
              height: 42,
              width: 42,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: context.colorScheme.onPrimary,
                borderRadius: BorderRadius.circular(6),
                border: Border.all(
                  color: context.colorScheme.outline.withOp(0.4),
                ),
              ),
              alignment: Alignment.center,
              child: Image.asset(
                icon,
                height: 24,
                width: 24,
                color: context.colorScheme.onPrimaryContainer.withOp(0.6),
              ),
            ),
            8.height,
            Text(
              text,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: context.colorScheme.onPrimaryContainer.withOp(0.6),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIconContainer(BuildContext context, String icon) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: context.colorScheme.onPrimary,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: context.colorScheme.outline.withOp(0.7),
        ),
      ),
      child: Image.asset(
        icon,
        height: 24,
        width: 24,
        color: context.colorScheme.primary,
      ),
    );
  }
}
