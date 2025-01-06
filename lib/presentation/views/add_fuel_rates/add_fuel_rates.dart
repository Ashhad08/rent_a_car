import 'package:flutter/material.dart';

import '../../../constants/extensions.dart';
import '../../../utils/utils.dart';
import '../../elements/app_text_field.dart';
import '../../elements/custom_drop_down.dart';
import '../../elements/custom_elevated_button.dart';
import '../../elements/gradient_body.dart';

class AddFuelRates extends StatelessWidget {
  const AddFuelRates({super.key});

  @override
  Widget build(BuildContext context) {
    final fuelRates = [
      MapEntry('Petrol (Super)', '252.1'),
      MapEntry('High-speed diesel', '255.38'),
      MapEntry('Light-speed diesel', '148.95'),
      MapEntry('Kerosene', '161.66'),
      MapEntry('Liquefied petroleum gas (LPG)', '254.86'),
      MapEntry('Compressed Natural gas (CNG)', '190'),
    ];
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: getIt<Utils>().popIcon(context),
        title: const Text('Add Fuel Rates'),
      ),
      body: GradientBody(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                  decoration: BoxDecoration(
                    color: context.colorScheme.onPrimary,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: context.colorScheme.outline.withOp(0.7),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Fuel Type',
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: context.colorScheme.onPrimaryContainer
                                .withOp(0.7)),
                      ),
                      8.height,
                      CustomDropDown(
                          isDense: true,
                          label: 'Select Type',
                          dropdownMenuEntries: [
                            MapEntry("0", "Petrol (Super)"),
                            MapEntry("1", "High-speed diesel"),
                            MapEntry("2", "Light-speed diesel"),
                            MapEntry("3", "Kerosene"),
                            MapEntry("4", "Liquefied petroleum gas (LPG)"),
                            MapEntry("5", "Compressed Natural gas (CNG)"),
                          ],
                          onSelected: (val) {},
                          enabled: true,
                          initialItem: null),
                      8.height,
                      AppTextField(
                        controller: TextEditingController(),
                        hintText: 'Enter Fuel Rate',
                      ),
                    ],
                  ),
                ),
                20.height,
                CustomElevatedButton(
                  onPressed: () {},
                  text: 'Save Rates',
                ),
                18.height,
                Text(
                  'Current Rates',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                ),
                12.height,
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 17),
                  decoration: BoxDecoration(
                    color: context.colorScheme.onPrimary,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: context.colorScheme.outline.withOp(0.7),
                    ),
                  ),
                  child: Column(
                    spacing: 20,
                    children: fuelRates
                        .map(
                          (e) => Row(
                            children: [
                              Expanded(
                                child: Text(
                                  e.key,
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: context
                                          .colorScheme.onPrimaryContainer
                                          .withOp(0.5)),
                                ),
                              ),
                              10.width,
                              Text(
                                e.value,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              )
                            ],
                          ),
                        )
                        .toList(),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
