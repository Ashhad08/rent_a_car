import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../constants/extensions.dart';
import '../../../data/models/owner/owner_model.dart';
import '../../../navigation/navigation_helper.dart';
import '../../../utils/utils.dart';
import '../../elements/gradient_body.dart';
import '../../elements/vehicle_card_2.dart';
import '../assign_vehicles_to_owner_view/assign_vehicles_to_owner_view.dart';

class OwnerDetailsView extends StatelessWidget {
  const OwnerDetailsView({super.key, required this.owner});

  final OwnerModel owner;

  @override
  Widget build(BuildContext context) {
    final List<MapEntry<String, String>> ownersInfo = [
      MapEntry('Owner Code', owner.ownerInfo?.ownerCode ?? ""),
      MapEntry(
          'Date From',
          owner.ownerInfo?.dateFrom == null
              ? ''
              : DateFormat('dd-MM-yyyy').format(owner.ownerInfo!.dateFrom!)),
      MapEntry('Owner Name', owner.ownerInfo?.ownerName ?? ""),
      MapEntry('Father Name', owner.ownerInfo?.fatherName ?? ''),
      MapEntry('CNIC Number', owner.ownerInfo?.cnic ?? ''),
      MapEntry('Address', owner.ownerInfo?.address ?? ""),
      MapEntry('City', owner.ownerInfo?.city ?? ""),
      MapEntry('Mobile No', owner.ownerInfo?.mobileNumber ?? ""),
      MapEntry('Residence Phone', owner.ownerInfo?.resedenceNumber ?? ""),
      MapEntry('Profession', owner.ownerInfo?.profession ?? ""),
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
                    leading: CircleAvatar(
                      backgroundImage: owner.ownerInfo?.ownerImage == null
                          ? null
                          : NetworkImage(owner.ownerInfo!.ownerImage!),
                    ),
                    style: ListTileStyle.list,
                    tileColor: context.colorScheme.onPrimary,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                        side: BorderSide(
                            color: context.colorScheme.outline.withOp(0.5))),
                    title: Text(
                      owner.ownerInfo?.ownerName ?? "",
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                    ),
                    subtitle: Text(
                      owner.ownerInfo?.mobileNumber ?? "",
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
                      '${(owner.vehicles ?? [].length) == 0 ? "No" : (owner.vehicles ?? []).length} ${(owner.vehicles ?? []).length == 1 ? "Vehicle" : 'Vehicles'} Assigned',
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
                        getIt<NavigationHelper>().push(
                            context,
                            AssignVehiclesToOwnerView(
                              assignedVehicles: owner.vehicles ?? [],
                              owner: owner.ownerInfo!,
                            ));
                      },
                      icon: Icon(Icons.add),
                    ).space(height: 24, width: 24)
                  ],
                ),
                12.height,
                ...(owner.vehicles ?? []).map(
                  (e) => Padding(
                    padding: const EdgeInsets.only(bottom: 12.0),
                    child: VehicleCard2(
                      status: 'Assigned',
                      vehicle: e,
                      statusColor: Color(0xff004ABA),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
