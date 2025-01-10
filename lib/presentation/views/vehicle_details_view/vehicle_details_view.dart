import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/master_data/vehicle_all_features_bloc/vehicle_all_features_bloc.dart';
import '../../../blocs/master_data/vehicle_all_types_bloc/vehicle_all_types_bloc.dart';
import '../../../constants/extensions.dart';
import '../../../data/models/master_data/vehicle_model_model.dart';
import '../../../data/models/vehicle/vehicle_model.dart';
import '../../../domain/implementations/master_data/master_data_repository.dart';
import '../../../generated/assets.dart';
import '../../../navigation/navigation_helper.dart';
import '../../../utils/utils.dart';
import '../../elements/custom_elevated_button.dart';
import '../../elements/gradient_body.dart';
import '../vehicle_booking_request_view/vehicle_booking_request_view.dart';

class VehicleDetailsView extends StatelessWidget {
  const VehicleDetailsView({super.key, required this.vehicle});

  final VehicleModel vehicle;

  @override
  Widget build(BuildContext context) {
    final state = context.read<VehicleAllTypesBloc>().state;
    String vehicleType = '';
    if (state is VehicleAllTypesLoaded) {
      vehicleType = state.allTypes
              .where(
                (element) => element.id == vehicle.carTypeId,
              )
              .firstOrNull
              ?.typeName ??
          "";
    }
    final List<Map<String, String>> overViewItems = [
      // {
      //   'image': Assets.iconsCarFront,
      //   'title': 'Make',
      //   'value': 'Honda',
      // },
      {
        'image': Assets.iconsCalender,
        'title': 'Year',
        'value': vehicle.yearOfModel ?? "",
      },
      {
        'image': Assets.iconsColor,
        'title': 'Color',
        'value': vehicle.color ?? "",
      },
    ];
    final List<Map<String, String>> rentalInfoItems = [
      {
        'title': 'Rate Without Driver',
        'value': 'Rs. ${vehicle.rateWithoutDriver ?? ""}',
      },
      {
        'title': 'Rate With Driver',
        'value': 'Rs. ${vehicle.rateWithDriver ?? ""}',
      },
      {
        'title': 'Rate With Driver',
        'value': 'Rs. ${vehicle.rateWithDriver ?? ""}',
      },
      {
        'title': 'Rate With Driver',
        'value': 'Rs. ${vehicle.rateWithDriver ?? ""}',
      },
      {
        'title': 'Weekly Discount',
        'value': '${vehicle.discountWeek ?? ""}%',
      },
      {
        'title': 'Monthly Discount',
        'value': '${vehicle.discountMonth ?? ""}%',
      },
      {
        'title': 'Registered City',
        'value': vehicle.regCity ?? "",
      },
      {
        'title': 'Vehicle Type',
        'value': vehicleType,
      },
      {
        'title': 'Status',
        'value': (vehicle.status ?? "available").capitalizeFirst,
      },
    ];
    final List<Map<String, String>> vehicleSpecification = [
      {
        'title': 'Transmission',
        'value': vehicle.transmission ?? "",
      },
      {
        'title': 'Fuel Type',
        'value': vehicle.fuelType ?? "",
      },
      {
        'title': 'Engine Capacity',
        'value': vehicle.engineCapacity ?? "",
      },
      {
        'title': 'Chassis No',
        'value': vehicle.chasisNo ?? "",
      },
      {
        'title': 'Engine No',
        'value': vehicle.engineNo ?? "",
      },
    ];
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: getIt<Utils>().popIcon(context),
        title: const Text('Details'),
        // actions: [
        //   IconButton(
        //     style: IconButton.styleFrom(
        //       iconSize: 22,
        //       backgroundColor: context.colorScheme.onPrimary,
        //     ),
        //     onPressed: () {},
        //     icon: Icon(CupertinoIcons.heart),
        //   ),
        //   6.width,
        // ],
      ),
      body: GradientBody(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: vehicle.images?.firstOrNull != null
                          ? Image.network(
                              vehicle.images!.firstOrNull!,
                              fit: BoxFit.cover,
                            )
                          : SizedBox())
                  .space(
                      height: context.screenHeight * 0.25,
                      width: double.infinity),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: context.colorScheme.onPrimary,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(24),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 20, right: 20, left: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Vehicle Overview',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                          14.height,
                          Row(
                            spacing: context.screenWidth * 0.03,
                            children: [
                              Expanded(
                                child: Container(
                                  height: 92,
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: context.colorScheme.outline
                                            .withOp(0.2)),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Image.asset(
                                        Assets.iconsCar3,
                                        height: 26,
                                        width: 26,
                                      ),
                                      Spacer(),
                                      Text(
                                        'Model',
                                        style: TextStyle(
                                            fontSize: 10,
                                            color: context.colorScheme.outline,
                                            fontWeight: FontWeight.w400),
                                      ),
                                      FutureBuilder<VehicleModelModel?>(
                                          future: getIt<MasterDataRepository>()
                                              .getVehicleModelModelById(
                                                  vehicleModelId:
                                                      vehicle.carModelId ?? ""),
                                          builder: (context, snap) {
                                            return Text(
                                              snap.data?.modelName ?? "",
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w400),
                                            );
                                          }),
                                    ],
                                  ),
                                ),
                              ),
                              ...overViewItems.map(
                                (e) => Expanded(
                                  child: Container(
                                    height: 92,
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: context.colorScheme.outline
                                              .withOp(0.2)),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Image.asset(
                                          e['image'] as String,
                                          height: 26,
                                          width: 26,
                                        ),
                                        Spacer(),
                                        Text(
                                          e['title'] as String,
                                          style: TextStyle(
                                              fontSize: 10,
                                              color:
                                                  context.colorScheme.outline,
                                              fontWeight: FontWeight.w400),
                                        ),
                                        Text(
                                          e['value'] as String,
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          20.height,
                          Text(
                            'Rental Information',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: context.colorScheme.primary),
                          ),
                          15.height,
                          Column(
                            children: rentalInfoItems
                                .map((tile) => Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                            child: Text(
                                          tile['title'] as String,
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                              color:
                                                  context.colorScheme.outline),
                                        )),
                                        Expanded(
                                            child: Text(
                                          tile['value'] as String,
                                          textAlign: TextAlign.end,
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        )),
                                      ],
                                    ))
                                .expand((widget) => [
                                      widget,
                                      Divider(),
                                      6.height,
                                    ])
                                .toList(),
                          ),
                          15.height,
                          Text(
                            'Vehicle Specification',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: context.colorScheme.primary),
                          ),
                          12.height,
                          GridView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: vehicleSpecification.length,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3, mainAxisExtent: 70),
                            itemBuilder: (context, index) => Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  vehicleSpecification[index]['title']
                                      as String,
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: context.colorScheme.outline,
                                      fontWeight: FontWeight.w400),
                                ),
                                Text(
                                  vehicleSpecification[index]['value']
                                      as String,
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400),
                                )
                              ],
                            ),
                          ),
                          Text(
                            'Additional Features',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: context.colorScheme.primary),
                          ),
                          12.height,
                          BlocBuilder<VehicleAllFeaturesBloc,
                                  VehicleAllFeaturesState>(
                              builder: (context, state) {
                            if (state is VehicleAllFeaturesLoaded) {
                              return Column(
                                children: state.allFeatures
                                    .map((tile) => Padding(
                                          padding: const EdgeInsets.only(
                                              bottom: 16.0),
                                          child: Row(
                                            children: [
                                              Image.asset(
                                                (vehicle.features ?? [])
                                                        .contains(
                                                            tile.featureName)
                                                    ? Assets.iconsAvailable
                                                    : Assets.iconsNotAvailable,
                                                height: 26,
                                                width: 26,
                                              ),
                                              12.width,
                                              Expanded(
                                                  child: Text(
                                                tile.featureName ?? "",
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              )),
                                            ],
                                          ),
                                        ))
                                    .toList(),
                              );
                            }
                            return const SizedBox.shrink();
                          }),
                          if (vehicle.images?.isNotEmpty ?? false) ...[
                            Text(
                              'Gallery',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: context.colorScheme.primary),
                            ),
                            12.height,
                          ]
                        ],
                      ),
                    ),
                    if (vehicle.images?.isNotEmpty ?? false)
                      CarouselView.weighted(
                        itemSnapping: true,
                        flexWeights: const <int>[1, 7, 1],
                        controller: CarouselController(initialItem: 2),
                        children: List.generate(
                          vehicle.images?.length ?? 0,
                          (index) => ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: OverflowBox(
                              maxWidth: context.screenWidth * 7 / 8,
                              minWidth: context.screenWidth * 7 / 8,
                              child: Image(
                                fit: BoxFit.cover,
                                image:
                                    NetworkImage((vehicle.images ?? [])[index]),
                              ),
                            ),
                          ),
                        ),
                      ).space(height: context.screenHeight * 0.25),
                    30.height,
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: CustomElevatedButton(
                          onPressed: () {
                            getIt<NavigationHelper>().push(
                                context,
                                VehicleBookingRequestView(
                                  vehicle: vehicle,
                                ));
                          },
                          text: 'Continue Booking'),
                    ),
                    20.height,
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
