import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../constants/extensions.dart';
import '../../../utils/utils.dart';
import '../../elements/app_text_field.dart';
import '../../elements/gradient_body.dart';
import '../../elements/vehicle_card_2.dart';

class OnRentVehiclesView extends StatelessWidget {
  const OnRentVehiclesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: getIt<Utils>().popIcon(context),
        title: const Text('On Rent Vehicles'),
      ),
      body: GradientBody(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              15.height,
              AppTextField(
                controller: TextEditingController(),
                textInputAction: TextInputAction.search,
                hintText: 'Search',
                prefixIcon: const Icon(
                  CupertinoIcons.search,
                  size: 22,
                ),
              ),
              10.height,
              Expanded(
                child: ListView.separated(
                  padding: EdgeInsets.only(bottom: 20),
                  separatorBuilder: (context, index) => 14.height,
                  itemCount: 10,
                  physics: AlwaysScrollableScrollPhysics(),
                  itemBuilder: (context, index) => Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      VehicleCard2(
                        status: index % 2 == 0 ? 'Active' : "Returned",
                        showTrackLocationIcon: index % 2 == 0,
                        statusColor: index % 2 == 0
                            ? Color(0xff06A623)
                            : Color(0xff004ABA),
                      ),
                      12.height,
                      Material(
                        color: Colors.transparent,
                        child: ListTile(
                          dense: true,
                          leading: CircleAvatar(),
                          tileColor: context.colorScheme.onPrimary,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                              side: BorderSide(
                                  color:
                                      context.colorScheme.outline.withOp(0.3))),
                          title: Text(
                            'Brooklyn Simmons',
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w400),
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton.outlined(
                                      style: IconButton.styleFrom(
                                        fixedSize: Size(30, 30),
                                        iconSize: 16,
                                        foregroundColor: context
                                            .colorScheme.onPrimaryContainer
                                            .withOp(0.5),
                                        padding: EdgeInsets.zero,
                                        side: BorderSide(
                                            color: context
                                                .colorScheme.onPrimaryContainer
                                                .withOp(0.2)),
                                      ),
                                      onPressed: () {},
                                      icon: Icon(CupertinoIcons.phone))
                                  .space(height: 30, width: 30),
                              12.width,
                              IconButton.outlined(
                                      style: IconButton.styleFrom(
                                        fixedSize: Size(30, 30),
                                        iconSize: 16,
                                        foregroundColor: context
                                            .colorScheme.onPrimaryContainer
                                            .withOp(0.5),
                                        padding: EdgeInsets.zero,
                                        side: BorderSide(
                                            color: context
                                                .colorScheme.onPrimaryContainer
                                                .withOp(0.2)),
                                      ),
                                      onPressed: () {},
                                      icon: Icon(CupertinoIcons.bubble_right))
                                  .space(height: 30, width: 30)
                            ],
                          ),
                          subtitle: Text(
                            '+92 123456789',
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: context.theme.listTileTheme
                                    .subtitleTextStyle?.color),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
