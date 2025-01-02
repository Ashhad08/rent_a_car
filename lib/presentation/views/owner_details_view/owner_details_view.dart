import 'package:flutter/material.dart';

import '../../../constants/extensions.dart';
import '../../../navigation/navigation_helper.dart';
import '../../../utils/utils.dart';
import '../../elements/gradient_body.dart';
import '../../elements/vehicle_card_2.dart';
import '../select_vehicles_view/select_vehicles_view.dart';

class OwnerDetailsView extends StatelessWidget {
  const OwnerDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    final List<MapEntry<String, dynamic>> ownersInfo = [
      MapEntry('Owner Code', 'OWN12345'),
      MapEntry('Date From', '01-01-2024'),
      MapEntry('Owner Name', 'Ahmad Ali'),
      MapEntry('Father Name', 'Muhammad Akram'),
      MapEntry('CNIC Number', '42101-1234567-9'),
      MapEntry('Address', 'Street 5 Model Town'),
      MapEntry('City', 'Lahore'),
      MapEntry('Mobile No', '0301-1234567'),
      MapEntry('Residence Phone', '0301-1234567'),
      MapEntry('Profession', 'UI/UX Designer'),
    ];
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: getIt<Utils>().popIcon(context),
        title: const Text('Owner Details'),
      ),
      body: GradientBody(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Material(
                  color: Colors.transparent,
                  child: ListTile(
                    leading: CircleAvatar(),
                    style: ListTileStyle.list,
                    tileColor: context.colorScheme.onPrimary,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                        side: BorderSide(
                            color: context.colorScheme.outline.withOp(0.5))),
                    title: Text(
                      'Brooklyn Simmons',
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                    ),
                    subtitle: Text(
                      '+92 123456789',
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: context
                              .theme.listTileTheme.subtitleTextStyle?.color),
                    ),
                  ),
                ),
                12.height,
                Container(
                  padding: EdgeInsets.only(top: 20, right: 20, left: 20),
                  decoration: BoxDecoration(
                      color: context.colorScheme.onPrimary,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                          color: context.colorScheme.outline.withOp(0.8))),
                  child: Column(
                    children: ownersInfo
                        .map(
                          (e) => Padding(
                            padding: const EdgeInsets.only(bottom: 20.0),
                            child: Row(
                              children: [
                                Text(
                                  e.key,
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    color: context
                                        .colorScheme.onPrimaryContainer
                                        .withOp(0.7),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    e.value,
                                    textAlign: TextAlign.end,
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ),
                18.height,
                Row(
                  children: [
                    Text(
                      '3 Vehicle Assigned',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: context.colorScheme.onPrimaryContainer
                              .withOp(0.7)),
                    ),
                    Spacer(),
                    IconButton(
                      style: IconButton.styleFrom(
                        padding: EdgeInsets.zero,
                        fixedSize: Size(24, 24),
                        iconSize: 20,
                        backgroundColor: context.colorScheme.secondary,
                        foregroundColor: context.colorScheme.onPrimary,
                      ),
                      onPressed: () {
                        getIt<NavigationHelper>()
                            .push(context, SelectVehiclesView());
                      },
                      icon: Icon(Icons.add),
                    ).space(height: 24, width: 24)
                  ],
                ),
                12.height,
                VehicleCard2(
                  status: 'Assigned',
                  statusColor: Color(0xff004ABA),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
