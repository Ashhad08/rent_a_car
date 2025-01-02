import 'package:flutter/material.dart';

import '../../../constants/extensions.dart';
import '../../../generated/assets.dart';
import '../../../navigation/navigation_helper.dart';
import '../../../utils/utils.dart';
import '../../elements/app_text_field.dart';
import '../../elements/custom_elevated_button.dart';
import '../../elements/gradient_body.dart';
import '../select_vehicles_view/select_vehicles_view.dart';

class AddPromotionsView extends StatelessWidget {
  const AddPromotionsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: getIt<Utils>().popIcon(context),
        title: const Text('Add Promotion'),
      ),
      body: GradientBody(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Promotion title',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: context.colorScheme.onPrimaryContainer.withOp(0.6),
                  ),
                ),
                8.height,
                AppTextField(
                    controller: TextEditingController(),
                    hintText: 'e.g. Weekly Discount, Eid Offer'),
                16.height,
                Text(
                  'Discount Percentage',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: context.colorScheme.onPrimaryContainer.withOp(0.6),
                  ),
                ),
                8.height,
                AppTextField(
                    controller: TextEditingController(),
                    hintText: 'Enter Percentage'),
                16.height,
                Text(
                  'Vehicle Select',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: context.colorScheme.onPrimaryContainer.withOp(0.6),
                  ),
                ),
                8.height,
                InkWell(
                  onTap: () {
                    getIt<NavigationHelper>()
                        .push(context, SelectVehiclesView());
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: context.colorScheme.outline.withOp(0.7),
                        )),
                    padding: EdgeInsets.all(12),
                    child: Row(
                      children: [
                        Text(
                          'Select Vehicles',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: context.colorScheme.onSecondaryContainer
                                  .withOp(0.8)),
                        ),
                        Spacer(),
                        Icon(Icons.adaptive.arrow_forward)
                      ],
                    ),
                  ),
                ),
                16.height,
                Container(
                  decoration: BoxDecoration(
                      color: context.colorScheme.onPrimary,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: context.colorScheme.outline.withOp(0.7),
                      )),
                  padding: EdgeInsets.all(14),
                  child: Row(
                    children: [
                      Text(
                        'Vehicle Registration No',
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: context.colorScheme.onSecondaryContainer
                                .withOp(0.8)),
                      ),
                      Spacer(),
                      Text(
                        'Reg: CA-678_XYZ',
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: context.colorScheme.primary.withOp(0.8)),
                      ),
                    ],
                  ),
                ),
                16.height,
                Row(
                  spacing: 14,
                  children: [
                    Expanded(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Start Date',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: context.colorScheme.onPrimaryContainer
                                .withOp(0.6),
                          ),
                        ),
                        8.height,
                        AppTextField(
                            suffix: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.asset(
                                Assets.iconsCalender2,
                                height: 24,
                                width: 24,
                              ),
                            ),
                            controller: TextEditingController(),
                            hintText: 'DD/MM/YYYY'),
                      ],
                    )),
                    Expanded(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'End Date',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: context.colorScheme.onPrimaryContainer
                                .withOp(0.6),
                          ),
                        ),
                        8.height,
                        AppTextField(
                            controller: TextEditingController(),
                            suffix: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.asset(
                                Assets.iconsCalender2,
                                height: 24,
                                width: 24,
                              ),
                            ),
                            hintText: 'DD/MM/YYYY'),
                      ],
                    )),
                  ],
                ),
                16.height,
                Text(
                  'Description',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: context.colorScheme.onPrimaryContainer.withOp(0.6),
                  ),
                ),
                8.height,
                AppTextField(
                    maxLines: 3,
                    controller: TextEditingController(),
                    hintText: 'Enter Description'),
                16.height,
                Container(
                  decoration: BoxDecoration(
                      color: context.colorScheme.onPrimary,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: context.colorScheme.outline.withOp(0.7),
                      )),
                  child: Row(
                    children: [
                      14.width,
                      Text(
                        'Status',
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: context.colorScheme.onSecondaryContainer
                                .withOp(0.8)),
                      ),
                      Spacer(),
                      Switch.adaptive(
                        value: false,
                        onChanged: (value) {},
                      ),
                      10.width,
                    ],
                  ),
                ),
                34.height,
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {},
                        style: OutlinedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14)),
                        ),
                        child: Text(
                          'Reset',
                        ),
                      ).space(height: 54),
                    ),
                    14.width,
                    Expanded(
                      child: CustomElevatedButton(
                        onPressed: () {},
                        text: 'Save',
                      ),
                    ),
                  ],
                ),
                20.height,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
