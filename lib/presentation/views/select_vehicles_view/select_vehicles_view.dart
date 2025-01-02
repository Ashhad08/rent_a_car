import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../constants/extensions.dart';
import '../../../utils/utils.dart';
import '../../elements/app_text_field.dart';
import '../../elements/gradient_body.dart';
import '../../elements/vehicle_card_2.dart';

class SelectVehiclesView extends StatelessWidget {
  const SelectVehiclesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: getIt<Utils>().popIcon(context),
        title: const Text('Select Vehicles'),
      ),
      body: GradientBody(
        child: Column(
          children: [
            Padding(
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
                  Row(
                    children: [
                      Checkbox(
                        value: false,
                        onChanged: (value) {},
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4)),
                      ),
                      Text(
                        'Select All',
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w600),
                      )
                    ],
                  ),
                  10.height,
                ],
              ),
            ),
            Expanded(
              child: ListView.separated(
                padding: EdgeInsets.only(bottom: 20, right: 20),
                separatorBuilder: (context, index) => 14.height,
                itemCount: 10,
                physics: AlwaysScrollableScrollPhysics(),
                itemBuilder: (context, index) => Row(
                  children: [
                    Checkbox(
                      value: index % 2 != 0,
                      onChanged: (value) {},
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4)),
                    ),
                    Expanded(
                      child: VehicleCard2(
                          status: index % 2 == 0 ? 'Available' : "Assigned",
                          statusIcon: CircleAvatar(
                              radius: 5, backgroundColor: Color(0xff06A623)),
                          statusColor: Color(0xff06A623)),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
