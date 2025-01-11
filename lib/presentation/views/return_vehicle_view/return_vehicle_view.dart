import 'package:flutter/material.dart';

import '../../../constants/extensions.dart';
import '../../../generated/assets.dart';
import '../../../utils/utils.dart';
import '../../elements/app_text_field.dart';
import '../../elements/custom_elevated_button.dart';
import '../../elements/gradient_body.dart';

class ReturnVehicleView extends StatelessWidget {
  const ReturnVehicleView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: getIt<Utils>().popIcon(context),
        title: const Text('Return Vehicle'),
      ),
      body: GradientBody(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Date From',
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: context.colorScheme.onPrimary),
                          ),
                          10.height,
                          AppTextField(
                              prefixIcon: Image.asset(
                                Assets.iconsCalender2,
                                height: 24,
                                width: 24,
                              ),
                              controller: TextEditingController(),
                              hintText: ''),
                        ],
                      ),
                    ),
                    14.width,
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Time From',
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: context.colorScheme.onPrimary),
                          ),
                          10.height,
                          AppTextField(
                              prefixIcon: Image.asset(
                                Assets.iconsClock,
                                height: 24,
                                width: 24,
                              ),
                              controller: TextEditingController(),
                              hintText: ''),
                        ],
                      ),
                    )
                  ],
                ),
                18.height,
                Text(
                  'Registration No',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: context.colorScheme.onPrimary),
                ),
                10.height,
                AppTextField(
                    controller: TextEditingController(),
                    hintText: 'Enter Registration Number'),
                18.height,
                Text(
                  'Condition',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: context.colorScheme.onPrimary),
                ),
                10.height,
                AppTextField(
                    maxLines: 3,
                    controller: TextEditingController(),
                    hintText: 'What Condition'),
                18.height,
                Text(
                  'Total Amount',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: context.colorScheme.onPrimary),
                ),
                10.height,
                AppTextField(
                    controller: TextEditingController(), hintText: '2000'),
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
                          'Cancel',
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
