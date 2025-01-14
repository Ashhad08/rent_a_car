import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../blocs/master_data/vehicle_all_makes_bloc/vehicle_all_makes_bloc.dart';
import '../../../../blocs/master_data/vehicle_models_bloc/vehicle_models_bloc.dart';
import '../../../../constants/app_colors.dart';
import '../../../../constants/extensions.dart';
import '../../../../data/models/vehicle/vehicle_model.dart';
import '../../../../navigation/navigation_helper.dart';
import '../../vehicle_details_view/vehicle_details_view.dart';

class VehicleCard extends StatelessWidget {
  final VehicleModel vehicle;

  const VehicleCard({super.key, required this.vehicle});

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

    return Stack(
      children: [
        Positioned.fill(
          child: CustomPaint(
            size: Size(double.infinity, 130),
            painter: BorderPainter(
              clipper: CustomClipperForInwardBottomRight(),
              borderWidth: 1,
              borderColor: context.colorScheme.outline,
            ),
          ),
        ),
        ClipPath(
          clipper: CustomClipperForInwardBottomRight(),
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 1.2, vertical: 1),
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            color: getIt<AppColors>().kCardColor,
            height: 130,
            width: double.infinity,
            child: Row(
              children: [
                Expanded(
                  flex: 4,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: vehicle.images?.firstOrNull != null
                          ? DecorationImage(
                              image: NetworkImage(vehicle.images!.firstOrNull!),
                              fit: BoxFit.cover)
                          : null,
                    ),
                  ),
                ),
                8.width,
                Expanded(
                  flex: 6,
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
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: ElevatedButton(
            onPressed: () {
              getIt<NavigationHelper>().push(
                  context,
                  VehicleDetailsView(
                    vehicle: vehicle,
                  ));
            },
            style: ElevatedButton.styleFrom(
                foregroundColor: context.colorScheme.secondary,
                backgroundColor: getIt<AppColors>().kPrimaryColor,
                padding: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100))),
            child: Icon(
              Icons.arrow_forward,
              color: context.colorScheme.secondary,
              size: 26,
            ),
          ).space(height: 50, width: 50),
        )
      ],
    ).space(height: 130);
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

class CustomClipperForInwardBottomRight extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();

    // Top-left corner rounded
    path.moveTo(0, 25);
    path.quadraticBezierTo(0, 0, 25, 0);

    // Top-right corner rounded
    path.lineTo(size.width - 25, 0);
    path.quadraticBezierTo(size.width, 0, size.width, 25);

    // Bottom-right corner inward rounded
    path.lineTo(size.width, size.height - 50);
    path.arcToPoint(
      Offset(size.width - 50, size.height),
      radius: Radius.circular(25),
      clockwise: false,
    );

    // Bottom-left corner rounded
    path.lineTo(25, size.height);
    path.quadraticBezierTo(0, size.height, 0, size.height - 25);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}

class BorderPainter extends CustomPainter {
  final CustomClipper<Path> clipper;
  final double borderWidth;
  final Color borderColor;

  BorderPainter({
    required this.clipper,
    required this.borderWidth,
    required this.borderColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final path = clipper.getClip(size);
    final paint = Paint()
      ..color = borderColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = borderWidth;

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
