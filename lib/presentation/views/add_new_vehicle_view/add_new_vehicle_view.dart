import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loading_overlay/loading_overlay.dart';

import '../../../blocs/loading_bloc/loading_bloc.dart';
import '../../../blocs/master_data/all_fuel_types_bloc/all_fuel_types_bloc.dart';
import '../../../blocs/master_data/vehicle_all_colors_bloc/vehicle_all_colors_bloc.dart';
import '../../../blocs/master_data/vehicle_all_features_bloc/vehicle_all_features_bloc.dart';
import '../../../blocs/master_data/vehicle_all_types_bloc/vehicle_all_types_bloc.dart';
import '../../../blocs/master_data/vehicle_models_by_type_bloc/vehicle_models_by_type_bloc.dart';
import '../../../blocs/vehicle/all_vehicles_bloc/all_vehicles_bloc.dart';
import '../../../blocs/vehicle/vehicle_documents_bloc/vehicle_documents_bloc.dart';
import '../../../blocs/vehicle/vehicle_images_bloc/vehicle_images_bloc.dart';
import '../../../constants/extensions.dart';
import '../../../data/models/vehicle/vehicle_model.dart';
import '../../../domain/implementations/master_data/master_data_repository.dart';
import '../../../domain/implementations/vehicle/vehicle_repository.dart';
import '../../../domain/services/image_services.dart';
import '../../../generated/assets.dart';
import '../../../navigation/navigation_helper.dart';
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
  MapEntry<String, String>? _vehicleTransmission;
  final ValueNotifier<List<String>> _selectedFeatures = ValueNotifier([]);
  final ValueNotifier<String?> _selectedFuel = ValueNotifier(null);
  final _key = GlobalKey<FormState>();

  @override
  void dispose() {
    _regNumberController.dispose();
    _regCityController.dispose();
    _yearOfModelController.dispose();
    _engineCapacityController.dispose();
    _chassisNumberController.dispose();
    _engineNumberController.dispose();
    _rateWithDriverController.dispose();
    _rateWithoutDriverController.dispose();
    _monthlyDiscountController.dispose();
    _weeklyDiscountController.dispose();
    _selectedFeatures.dispose();
    _selectedFuel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final imageServices = getIt<ImageServices>();
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LoadingBloc(),
        ),
        BlocProvider(
            create: (context) =>
                VehicleModelsByTypeBloc(getIt<MasterDataRepository>())),
        BlocProvider(
          create: (context) => VehicleImagesBloc(
            maxLength: 10,
          ),
        ),
        BlocProvider(
          create: (context) => VehicleDocumentsBloc(
            maxLength: 10,
          ),
        ),
      ],
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
              title: const Text('New Vehicle Information'),
            ),
            body: GradientBody(
              child: RefreshIndicator(
                onRefresh: () async {
                  _vehicleType = null;
                  _vehicleColor = null;
                  _selectedFeatures.value = [];
                  _selectedFuel.value = null;
                  context
                      .read<VehicleAllTypesBloc>()
                      .add(LoadVehicleAllTypesEvent());

                  context
                      .read<VehicleAllColorsBloc>()
                      .add(LoadVehicleAllColorsEvent());
                  context
                      .read<VehicleAllFeaturesBloc>()
                      .add(LoadVehicleAllFeaturesEvent());
                  context.read<AllFuelTypesBloc>().add(LoadAllFuelTypesEvent());
                },
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Form(
                      key: _key,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Vehicle Information',
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w500),
                          ),
                          16.height,
                          Text(
                            'Registration No',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: context.colorScheme.onPrimaryContainer
                                  .withOp(0.6),
                            ),
                          ),
                          8.height,
                          Row(
                            children: [
                              _buildIconContainer(
                                  context, Assets.iconsEditNote),
                              4.width,
                              Expanded(
                                child: AppTextField(
                                    controller: _regNumberController,
                                    validator: (val) {
                                      if (val == null || val.isEmpty) {
                                        return 'Kindly enter registration number';
                                      }
                                      return null;
                                    },
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
                              color: context.colorScheme.onPrimaryContainer
                                  .withOp(0.6),
                            ),
                          ),
                          8.height,
                          Row(
                            children: [
                              _buildIconContainer(
                                  context, Assets.iconsBuilding),
                              4.width,
                              Expanded(
                                child: AppTextField(
                                    controller: _regCityController,
                                    validator: (val) {
                                      if (val == null || val.isEmpty) {
                                        return 'Kindly enter registered city';
                                      }
                                      return null;
                                    },
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
                              color: context.colorScheme.onPrimaryContainer
                                  .withOp(0.6),
                            ),
                          ),
                          8.height,
                          Row(
                            children: [
                              _buildIconContainer(
                                  context, Assets.iconsBuilding),
                              4.width,
                              Expanded(
                                child: AppTextField(
                                  controller: _yearOfModelController,
                                  hintText: 'Enter Year of Model',
                                  validator: (val) {
                                    if (val == null || val.isEmpty) {
                                      return 'Kindly enter registered city';
                                    } else if (val.isNotEmpty &&
                                        !val.isPositiveNumber) {
                                      return 'Kindly enter valid year';
                                    }
                                    return null;
                                  },
                                  textInputType:
                                      TextInputType.numberWithOptions(
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
                                  color:
                                      context.colorScheme.outline.withOp(0.7),
                                ),
                              ),
                              child: Column(
                                children: [
                                  BlocBuilder<VehicleAllTypesBloc,
                                      VehicleAllTypesState>(
                                    builder: (context, state) {
                                      return CustomDropDown(
                                        errorMessageIfRequired:
                                            'Kindly Select Vehicle Type',
                                        prefixIcon: Image.asset(
                                          Assets.iconsCarFront,
                                          height: 24,
                                          width: 24,
                                          color: context.colorScheme.outline,
                                        ),
                                        label: 'Vehicle Type',
                                        dropdownMenuEntries:
                                            (state is VehicleAllTypesLoaded)
                                                ? (state.allTypes.map(
                                                    (e) => MapEntry(e.id ?? "",
                                                        e.typeName ?? ""),
                                                  )).toList()
                                                : [],
                                        onSelected: (val) {
                                          if (val != null) {
                                            _vehicleType = val;
                                            context
                                                .read<VehicleModelsByTypeBloc>()
                                                .add(
                                                    LoadVehicleModelsByTypeEvent(
                                                        typeId: val.key));
                                          }
                                        },
                                        enabled:
                                            (state is VehicleAllTypesLoaded)
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
                                        errorMessageIfRequired:
                                            'Kindly Select Vehicle Model',
                                        prefixIcon: Image.asset(
                                          Assets.iconsCarFront,
                                          height: 24,
                                          width: 24,
                                          color: context.colorScheme.outline,
                                        ),
                                        label: 'Vehicle Model',
                                        dropdownMenuEntries:
                                            (state is VehicleModelsByTypeLoaded)
                                                ? (state.modelsByType.map(
                                                    (e) => MapEntry(e.id ?? "",
                                                        e.modelName ?? ""),
                                                  )).toList()
                                                : [],
                                        onSelected: (val) {
                                          if (val != null) {
                                            _vehicleModel = val;
                                          }
                                        },
                                        enabled: (state
                                            is VehicleModelsByTypeLoaded),
                                        initialItem: _vehicleModel,
                                      );
                                    },
                                  ),
                                  16.height,
                                  BlocBuilder<VehicleAllColorsBloc,
                                      VehicleAllColorsState>(
                                    builder: (context, state) {
                                      return CustomDropDown(
                                        errorMessageIfRequired:
                                            'Kindly Select Color',
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
                                                    (e) => MapEntry(e.id ?? "",
                                                        e.colorName ?? ""),
                                                  )).toList()
                                                : [],
                                        onSelected: (val) {
                                          if (val != null) {
                                            _vehicleColor = val;
                                          }
                                        },
                                        enabled:
                                            (state is VehicleAllColorsLoaded),
                                        initialItem: _vehicleColor,
                                      );
                                    },
                                  ),
                                  16.height,
                                  CustomDropDown(
                                    errorMessageIfRequired:
                                        'Kindly Select Transmission Type',
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
                                    onSelected: (val) {
                                      if (val != null) {
                                        _vehicleTransmission = val;
                                      }
                                    },
                                    enabled: true,
                                    initialItem: _vehicleTransmission,
                                  ),
                                ],
                              )),
                          16.height,
                          Text(
                            'Engine Capacity',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: context.colorScheme.onPrimaryContainer
                                  .withOp(0.6),
                            ),
                          ),
                          8.height,
                          AppTextField(
                            controller: _engineCapacityController,
                            hintText: 'Enter Engine Capacity',
                            validator: (val) {
                              if (val == null || val.isEmpty) {
                                return 'Kindly enter engine capacity';
                              }
                              return null;
                            },
                          ),
                          16.height,
                          Text(
                            'Chassis No',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: context.colorScheme.onPrimaryContainer
                                  .withOp(0.6),
                            ),
                          ),
                          8.height,
                          AppTextField(
                            controller: _chassisNumberController,
                            hintText: 'Enter Chassis Number',
                            validator: (val) {
                              if (val == null || val.isEmpty) {
                                return 'Kindly enter chassis number';
                              }
                              return null;
                            },
                          ),
                          16.height,
                          Text(
                            'Engine No',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: context.colorScheme.onPrimaryContainer
                                  .withOp(0.6),
                            ),
                          ),
                          8.height,
                          AppTextField(
                            controller: _engineNumberController,
                            hintText: 'Enter Engine Number',
                            validator: (val) {
                              if (val == null || val.isEmpty) {
                                return 'Kindly enter engine number';
                              }
                              return null;
                            },
                          ),
                          16.height,
                          Text(
                            'Rate with driver',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: context.colorScheme.onPrimaryContainer
                                  .withOp(0.6),
                            ),
                          ),
                          8.height,
                          AppTextField(
                            controller: _rateWithDriverController,
                            hintText: 'Enter rate with driver',
                            validator: (val) {
                              if (val == null || val.isEmpty) {
                                return 'Kindly enter rate with driver';
                              } else if (val.isNotEmpty &&
                                  !val.isDecimalPositiveNumber) {
                                return 'Kindly enter valid rate';
                              }
                              return null;
                            },
                            textInputType:
                                TextInputType.numberWithOptions(signed: false),
                          ),
                          16.height,
                          Text(
                            'Rate without driver',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: context.colorScheme.onPrimaryContainer
                                  .withOp(0.6),
                            ),
                          ),
                          8.height,
                          AppTextField(
                            controller: _rateWithoutDriverController,
                            hintText: 'Enter rate without driver',
                            validator: (val) {
                              if (val == null || val.isEmpty) {
                                return 'Kindly enter rate without driver';
                              } else if (val.isNotEmpty &&
                                  !val.isDecimalPositiveNumber) {
                                return 'Kindly enter valid rate';
                              }
                              return null;
                            },
                            textInputType:
                                TextInputType.numberWithOptions(signed: false),
                          ),
                          16.height,
                          Text(
                            'Discount on week',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: context.colorScheme.onPrimaryContainer
                                  .withOp(0.6),
                            ),
                          ),
                          8.height,
                          AppTextField(
                            controller: _weeklyDiscountController,
                            hintText: 'Enter discount on week',
                            validator: (val) {
                              if (val == null || val.isEmpty) {
                                return 'Kindly enter discount on week';
                              } else if (val.isNotEmpty && !val.isPercentage) {
                                return 'Kindly enter valid discount from 0 to 100';
                              }
                              return null;
                            },
                            textInputType:
                                TextInputType.numberWithOptions(signed: false),
                          ),
                          16.height,
                          Text(
                            'Discount on month',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: context.colorScheme.onPrimaryContainer
                                  .withOp(0.6),
                            ),
                          ),
                          8.height,
                          AppTextField(
                            controller: _monthlyDiscountController,
                            hintText: 'Enter discount on month',
                            validator: (val) {
                              if (val == null || val.isEmpty) {
                                return 'Kindly enter discount on month';
                              } else if (val.isNotEmpty && !val.isPercentage) {
                                return 'Kindly enter valid discount from 0 to 100';
                              }
                              return null;
                            },
                            textInputType:
                                TextInputType.numberWithOptions(signed: false),
                          ),
                          BlocBuilder<AllFuelTypesBloc, AllFuelTypesState>(
                            builder: (context, state) {
                              if (state is AllFuelTypesLoaded) {
                                final fuelTypes = state.fuelTypes;
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    18.height,
                                    Text(
                                      'Fuel Type',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    12.height,
                                    ValueListenableBuilder(
                                        valueListenable: _selectedFuel,
                                        builder: (context, val, _) {
                                          return GridView.builder(
                                            itemCount: fuelTypes.length,
                                            padding: EdgeInsets.zero,
                                            physics:
                                                NeverScrollableScrollPhysics(),
                                            shrinkWrap: true,
                                            gridDelegate:
                                                SliverGridDelegateWithFixedCrossAxisCount(
                                                    crossAxisCount: 2,
                                                    crossAxisSpacing: 10,
                                                    mainAxisSpacing: 10,
                                                    childAspectRatio: 2 / 0.6),
                                            itemBuilder: (context, index) {
                                              final isSelected =
                                                  fuelTypes[index].fuelName ==
                                                      val;
                                              return GestureDetector(
                                                onTap: () {
                                                  _selectedFuel.value =
                                                      fuelTypes[index].fuelName;
                                                },
                                                child: Container(
                                                  padding: EdgeInsets.symmetric(
                                                    horizontal: 15,
                                                    vertical: 8,
                                                  ),
                                                  decoration: BoxDecoration(
                                                    color: isSelected
                                                        ? context
                                                            .colorScheme.primary
                                                        : context.colorScheme
                                                            .onPrimary,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                    border: Border.all(
                                                      color: context
                                                          .colorScheme.outline
                                                          .withOp(0.5),
                                                    ),
                                                  ),
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                    fuelTypes[index].fuelName ??
                                                        "",
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: isSelected
                                                          ? context.colorScheme
                                                              .secondary
                                                          : context.colorScheme
                                                              .outline,
                                                    ),
                                                  ),
                                                ),
                                              );
                                            },
                                          );
                                        }),
                                  ],
                                );
                              }
                              return SizedBox.shrink();
                            },
                          ),
                          35.height,
                          Text(
                            'Additional Features',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                          ValueListenableBuilder(
                            valueListenable: _selectedFeatures,
                            builder: (context, selectedFeatures, child) =>
                                BlocBuilder<VehicleAllFeaturesBloc,
                                    VehicleAllFeaturesState>(
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
                                              final updatedList =
                                                  List<String>.from(
                                                      selectedFeatures);
                                              if (val == true) {
                                                updatedList
                                                    .add(e.featureName ?? "");
                                              } else {
                                                updatedList
                                                    .remove(e.featureName);
                                              }
                                              _selectedFeatures.value =
                                                  updatedList;
                                            },
                                            dense: true,
                                            checkboxShape:
                                                RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            4)),
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
                          BlocBuilder<VehicleImagesBloc, VehicleImagesState>(
                            builder: (context, state) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        'Upload Photos',
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      Spacer(),
                                      Text(
                                        '${state.images.length}/${state.maxLength}',
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                            color: context.colorScheme.outline),
                                      ),
                                    ],
                                  ),
                                  if (state.images.length <
                                      state.maxLength) ...[
                                    10.height,
                                    Row(
                                      children: [
                                        Expanded(
                                          child: _pickImageSource(
                                            onTap: () async {
                                              await imageServices.pickImage(
                                                ImageSource.camera,
                                                (file) {
                                                  context
                                                      .read<VehicleImagesBloc>()
                                                      .add(AddFileImage(
                                                          image: file));
                                                },
                                              );
                                            },
                                            icon: Assets.iconsCamera,
                                            context: context,
                                            text: 'Take Photo',
                                          ),
                                        ),
                                        18.width,
                                        Expanded(
                                            child: _pickImageSource(
                                          onTap: () async {
                                            await imageServices.pickImage(
                                              ImageSource.gallery,
                                              (file) {
                                                context
                                                    .read<VehicleImagesBloc>()
                                                    .add(AddFileImage(
                                                        image: file));
                                              },
                                            );
                                          },
                                          icon: Assets.iconsUploadGallery,
                                          context: context,
                                          text: 'Upload Gallery',
                                        )),
                                      ],
                                    ),
                                  ],
                                  16.height,
                                  if (state.images.isNotEmpty)
                                    ListView.separated(
                                      separatorBuilder: (context, index) =>
                                          11.width,
                                      scrollDirection: Axis.horizontal,
                                      itemCount: state.images.length,
                                      itemBuilder: (context, index) {
                                        final image =
                                            state.images[index] as File;
                                        return Stack(
                                          children: [
                                            Positioned(
                                              bottom: 0,
                                              right: 10,
                                              left: 0,
                                              child: Container(
                                                height: 106,
                                                width: 106,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  image: DecorationImage(
                                                    fit: BoxFit.cover,
                                                    image: FileImage(image),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Positioned(
                                              top: 0,
                                              right: 0,
                                              child: GestureDetector(
                                                onTap: () {
                                                  context
                                                      .read<VehicleImagesBloc>()
                                                      .add(RemoveImage(
                                                          image: image));
                                                },
                                                child: Container(
                                                  padding: EdgeInsets.all(5),
                                                  decoration: BoxDecoration(
                                                    color: Color(0xffF5F5F5),
                                                    shape: BoxShape.circle,
                                                    border: Border.all(
                                                      color: context.colorScheme
                                                          .onPrimary,
                                                    ),
                                                  ),
                                                  alignment: Alignment.center,
                                                  child: Icon(
                                                    CupertinoIcons.xmark,
                                                    size: 16,
                                                    color: context
                                                        .colorScheme.error,
                                                  ),
                                                ),
                                              ),
                                            )
                                          ],
                                        ).space(
                                          height: 115,
                                          width: 119,
                                        );
                                      },
                                    ).space(
                                      height: 115,
                                      width: double.infinity,
                                    ),
                                ],
                              );
                            },
                          ),
                          18.height,
                          BlocBuilder<VehicleDocumentsBloc,
                              VehicleDocumentsState>(
                            builder: (context, state) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        'Vehicle Documents',
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      Spacer(),
                                      Text(
                                        '${state.images.length}/${state.maxLength}',
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                            color: context.colorScheme.outline),
                                      ),
                                    ],
                                  ),
                                  if (state.images.length <
                                      state.maxLength) ...[
                                    10.height,
                                    _pickImageSource(
                                      onTap: () async {
                                        await imageServices.pickImage(
                                          ImageSource.gallery,
                                          (file) {
                                            context
                                                .read<VehicleDocumentsBloc>()
                                                .add(AddDocumentFileImage(
                                                    image: file));
                                          },
                                        );
                                      },
                                      icon: Assets.iconsUploadCloud,
                                      context: context,
                                      text: 'Upload Documents',
                                    ).space(width: double.infinity),
                                  ],
                                  16.height,
                                  if (state.images.isNotEmpty)
                                    ListView.separated(
                                      separatorBuilder: (context, index) =>
                                          11.width,
                                      scrollDirection: Axis.horizontal,
                                      itemCount: state.images.length,
                                      itemBuilder: (context, index) {
                                        final image =
                                            state.images[index] as File;
                                        return Stack(
                                          children: [
                                            Positioned(
                                              bottom: 0,
                                              right: 10,
                                              left: 0,
                                              child: Container(
                                                height: 106,
                                                width: 106,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  image: DecorationImage(
                                                    fit: BoxFit.cover,
                                                    image: FileImage(image),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Positioned(
                                              top: 0,
                                              right: 0,
                                              child: GestureDetector(
                                                onTap: () {
                                                  context
                                                      .read<
                                                          VehicleDocumentsBloc>()
                                                      .add(RemoveDocumentImage(
                                                          image: image));
                                                },
                                                child: Container(
                                                  padding: EdgeInsets.all(5),
                                                  decoration: BoxDecoration(
                                                    color: Color(0xffF5F5F5),
                                                    shape: BoxShape.circle,
                                                    border: Border.all(
                                                      color: context.colorScheme
                                                          .onPrimary,
                                                    ),
                                                  ),
                                                  alignment: Alignment.center,
                                                  child: Icon(
                                                    CupertinoIcons.xmark,
                                                    size: 16,
                                                    color: context
                                                        .colorScheme.error,
                                                  ),
                                                ),
                                              ),
                                            )
                                          ],
                                        ).space(
                                          height: 115,
                                          width: 119,
                                        );
                                      },
                                    ).space(
                                      height: 115,
                                      width: double.infinity,
                                    ),
                                ],
                              );
                            },
                          ),
                          26.height,
                          CustomElevatedButton(
                              onPressed: () async {
                                final utils = getIt<Utils>();
                                if (_key.currentState!.validate() &&
                                    !context
                                        .read<LoadingBloc>()
                                        .state
                                        .isLoading) {
                                  if (context
                                      .read<VehicleImagesBloc>()
                                      .state
                                      .images
                                      .isEmpty) {
                                    context
                                        .read<LoadingBloc>()
                                        .add(StopLoading());
                                    utils.showErrorFlushBar(context,
                                        message:
                                            "At least one image must be uploaded");
                                    return;
                                  }
                                  final repo = getIt<VehicleRepository>();

                                  try {
                                    context
                                        .read<LoadingBloc>()
                                        .add(StartLoading());
                                    final res =
                                        await repo.createVehicle(VehicleModel(
                                      regNo: _regNumberController.text.trim(),
                                      regCity: _regCityController.text.trim(),
                                      yearOfModel:
                                          _yearOfModelController.text.trim(),
                                      carTypeId: _vehicleType?.key,
                                      carModelId: _vehicleModel?.key,
                                      color: _vehicleColor?.value,
                                      transmission: _vehicleTransmission?.value,
                                      engineCapacity:
                                          _engineCapacityController.text.trim(),
                                      chasisNo:
                                          _chassisNumberController.text.trim(),
                                      engineNo:
                                          _engineNumberController.text.trim(),
                                      rateWithDriver:
                                          _rateWithDriverController.text.trim(),
                                      rateWithoutDriver:
                                          _rateWithoutDriverController.text
                                              .trim(),
                                      discountWeek:
                                          _weeklyDiscountController.text.trim(),
                                      discountMonth: _monthlyDiscountController
                                          .text
                                          .trim(),
                                      fuelType: _selectedFuel.value,
                                      features: _selectedFeatures.value,
                                      images: (context
                                              .read<VehicleImagesBloc>()
                                              .state
                                              .images)
                                          .whereType<File>()
                                          .map((File e) => e.path)
                                          .toList(),
                                      documents: (context
                                              .read<VehicleDocumentsBloc>()
                                              .state
                                              .images)
                                          .whereType<File>()
                                          .map((File e) => e.path)
                                          .toList(),
                                    ));
                                    if (mounted && context.mounted) {
                                      context
                                          .read<LoadingBloc>()
                                          .add(StopLoading());
                                      context
                                          .read<AllVehiclesBloc>()
                                          .add(LoadAllVehiclesEvent());
                                      getIt<NavigationHelper>().pop(context);
                                      utils.showSuccessFlushBar(context,
                                          message: res.message ??
                                              "Vehicle Added Successfully");
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
                              text: 'Save Vehicle Information'),
                          20.height,
                        ],
                      ),
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

  Widget _pickImageSource(
      {required String icon,
      required String text,
      required VoidCallback onTap,
      required BuildContext context}) {
    return GestureDetector(
      onTap: onTap,
      child: DottedBorder(
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
