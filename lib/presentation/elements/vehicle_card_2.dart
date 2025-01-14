import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/master_data/vehicle_all_makes_bloc/vehicle_all_makes_bloc.dart';
import '../../blocs/master_data/vehicle_models_bloc/vehicle_models_bloc.dart';
import '../../constants/app_colors.dart';
import '../../constants/extensions.dart';
import '../../data/models/booking/booking_list_model.dart';
import '../../data/models/vehicle/vehicle_model.dart';
import '../../navigation/navigation_helper.dart';
import '../views/live_tracking_view/live_tracking_view.dart';
import '../views/return_vehicle_view/return_vehicle_view.dart';

class VehicleCard2 extends StatelessWidget {
  const VehicleCard2({
    super.key,
    required this.status,
    this.statusIcon,
    this.showTrackLocationIcon = false,
    required this.vehicle,
    this.showReturnVehicleIcon = false,
    this.booking,
  });

  final String status;
  final Widget? statusIcon;
  final bool showTrackLocationIcon;
  final bool showReturnVehicleIcon;
  final VehicleModel vehicle;
  final BookingListModel? booking;

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
                    vehicle.makeName?.toLowerCase(),
              )
              .firstOrNull
              ?.makeName ??
          "";
    }
    if (stateModels is VehicleModelsLoaded) {
      vehicleModel = stateModels.models
              .where(
                (element) => element.id == vehicle.carModelId,
              )
              .firstOrNull
              ?.modelName ??
          "";
    }

    final vehicleDetails = [
      {'label': vehicleMake, 'value': vehicleModel},
      {'label': 'Color', 'value': vehicle.color ?? ""},
      {'label': 'Reg', 'value': vehicle.regNo ?? ""},
      {'label': 'City', 'value': vehicle.regCity ?? ""},
      {'label': 'Rate', 'value': 'Rs.${vehicle.rateWithoutDriver ?? ""}'},
    ];
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(14),
      decoration: BoxDecoration(
          color: getIt<AppColors>().kCardColor,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: context.colorScheme.outline)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: vehicle.images?.firstOrNull != null
                  ? Image.network(
                      vehicle.images!.firstOrNull!,
                      height: 150,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    )
                  : SizedBox(
                      height: 150,
                      width: double.infinity,
                    )),
          12.height,
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
                      isLast: index == vehicleDetails.length - 1,
                    );
                  },
                ),
              )),
              10.width,
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: context.colorScheme.surface,
                      border: Border.all(
                        color: getIt<AppColors>().kPrimaryColor,
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (statusIcon != null) ...[
                          statusIcon!,
                          4.width,
                        ],
                        Text(
                          status,
                          style: TextStyle(
                              color: getIt<AppColors>().kPrimaryColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                  ),
                  if (showTrackLocationIcon) ...[
                    5.height,
                    InkWell(
                      onTap: () {
                        getIt<NavigationHelper>()
                            .push(context, LiveTrackingView());
                      },
                      child: Container(
                        alignment: Alignment.center,
                        padding:
                            EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: context.colorScheme.surface,
                          border: Border.all(
                            color: getIt<AppColors>().kPrimaryColor,
                          ),
                        ),
                        child: Text(
                          'Live Tracking',
                          style: TextStyle(
                              color: getIt<AppColors>().kPrimaryColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                    ),
                  ],
                  if (showReturnVehicleIcon) ...[
                    5.height,
                    InkWell(
                      onTap: () {
                        if (booking != null) {
                          getIt<NavigationHelper>().push(
                              context,
                              ReturnVehicleView(
                                booking: booking!,
                              ));
                        }
                      },
                      child: Container(
                        alignment: Alignment.center,
                        padding:
                            EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: context.colorScheme.surface,
                          border: Border.all(
                            color: getIt<AppColors>().kPrimaryColor,
                          ),
                        ),
                        child: Text(
                          'Return Vehicle',
                          style: TextStyle(
                              color: getIt<AppColors>().kPrimaryColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ],
          )
        ],
      ),
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
