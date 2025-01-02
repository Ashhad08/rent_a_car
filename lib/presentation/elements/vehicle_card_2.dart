import 'package:flutter/material.dart';

import '../../constants/extensions.dart';
import '../../generated/assets.dart';
import '../../navigation/navigation_helper.dart';
import '../views/live_tracking_view/live_tracking_view.dart';

class VehicleCard2 extends StatelessWidget {
  const VehicleCard2({
    super.key,
    required this.status,
    required this.statusColor,
    this.statusIcon,
    this.showTrackLocationIcon = false,
  });

  final String status;
  final Color statusColor;
  final Widget? statusIcon;
  final bool showTrackLocationIcon;

  @override
  Widget build(BuildContext context) {
    final vehicleDetails = [
      {'label': 'Suzuki', 'value': 'Altas 2024'},
      {'label': 'Color', 'value': 'Black'},
      {'label': 'City', 'value': 'Lahore'},
      {'label': 'Rate', 'value': 'Rs.1000/day'},
    ];
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(14),
      decoration: BoxDecoration(
          color: context.colorScheme.onPrimary,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: context.colorScheme.outline.withOp(0.5))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(
              Assets.imagesCarDummy,
              height: 150,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          12.height,
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
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
                        color: statusColor.withOp(0.1),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: statusColor.withOp(0.3),
                        )),
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
                              color: statusColor,
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
                            color: statusColor.withOp(0.1),
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: statusColor.withOp(0.3),
                            )),
                        child: Text(
                          'Live Tracking',
                          style: TextStyle(
                              color: statusColor,
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
