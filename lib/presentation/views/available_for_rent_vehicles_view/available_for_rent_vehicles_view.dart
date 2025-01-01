import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../constants/extensions.dart';
import '../../../utils/utils.dart';
import '../../elements/app_text_field.dart';
import '../../elements/gradient_body.dart';
import '../../elements/vehicle_card_2.dart';

class AvailableForRentVehiclesView extends StatelessWidget {
  const AvailableForRentVehiclesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: getIt<Utils>().popIcon(context),
        title: const Text('Available For Rent'),
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
                  itemBuilder: (context, index) => VehicleCard2(
                      status: index % 2 == 0 ? 'Available' : "Assigned",
                      statusIcon: CircleAvatar(
                          radius: 5, backgroundColor: Color(0xff06A623)),
                      statusColor: Color(0xff06A623)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
