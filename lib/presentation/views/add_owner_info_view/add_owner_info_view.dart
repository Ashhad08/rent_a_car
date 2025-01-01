import 'package:flutter/material.dart';

import '../../../constants/extensions.dart';
import '../../../generated/assets.dart';
import '../../../utils/utils.dart';
import '../../elements/app_text_field.dart';
import '../../elements/custom_elevated_button.dart';
import '../../elements/gradient_body.dart';

class AddOwnerInfoView extends StatelessWidget {
  const AddOwnerInfoView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: getIt<Utils>().popIcon(context),
        title: const Text('Owner Information'),
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
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
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
                      Align(
                        alignment: Alignment.center,
                        child: Stack(
                          children: [
                            Container(
                              height: 92,
                              width: 92,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                      color: context.colorScheme.outline
                                          .withOp(0.4))),
                              alignment: Alignment.center,
                              child: Text(
                                'Pick a image',
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    color: context.colorScheme.outline
                                        .withOp(0.7)),
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: Container(
                                padding: EdgeInsets.all(6),
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: context.colorScheme.outline
                                        .withOp(0.6)),
                                alignment: Alignment.center,
                                child: Image.asset(
                                  Assets.iconsEdit,
                                  height: 16,
                                  width: 16,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      20.height,
                      Text(
                        'Owner Code',
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: context.colorScheme.onPrimaryContainer
                                .withOp(0.5)),
                      ),
                      8.height,
                      AppTextField(
                        controller: TextEditingController(),
                        hintText: 'Enter Owner Code',
                      ),
                      16.height,
                      Text(
                        'Date From',
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: context.colorScheme.onPrimaryContainer
                                .withOp(0.5)),
                      ),
                      8.height,
                      AppTextField(
                        controller: TextEditingController(),
                        hintText: 'Select Start Date',
                      ),
                      16.height,
                      Text(
                        'Owner Name',
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: context.colorScheme.onPrimaryContainer
                                .withOp(0.5)),
                      ),
                      8.height,
                      AppTextField(
                        controller: TextEditingController(),
                        hintText: 'Enter Full Name',
                      ),
                      16.height,
                      Text(
                        'Father Name',
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: context.colorScheme.onPrimaryContainer
                                .withOp(0.5)),
                      ),
                      8.height,
                      AppTextField(
                        controller: TextEditingController(),
                        hintText: 'Enter Father Name',
                      ),
                      16.height,
                      Text(
                        'CNIC Number',
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: context.colorScheme.onPrimaryContainer
                                .withOp(0.5)),
                      ),
                      8.height,
                      AppTextField(
                        controller: TextEditingController(),
                        hintText: 'Enter CNIC Number',
                      ),
                      16.height,
                      Text(
                        'Address',
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: context.colorScheme.onPrimaryContainer
                                .withOp(0.5)),
                      ),
                      8.height,
                      AppTextField(
                        controller: TextEditingController(),
                        hintText: 'Enter Full Address',
                      ),
                      16.height,
                      Text(
                        'City',
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: context.colorScheme.onPrimaryContainer
                                .withOp(0.5)),
                      ),
                      8.height,
                      AppTextField(
                        controller: TextEditingController(),
                        hintText: 'Enter Your City',
                      ),
                      16.height,
                      Text(
                        'Mobile No',
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: context.colorScheme.onPrimaryContainer
                                .withOp(0.5)),
                      ),
                      8.height,
                      AppTextField(
                        controller: TextEditingController(),
                        hintText: 'Enter Mobile Number',
                      ),
                      16.height,
                      Text(
                        'Residence Phone',
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: context.colorScheme.onPrimaryContainer
                                .withOp(0.5)),
                      ),
                      8.height,
                      AppTextField(
                        controller: TextEditingController(),
                        hintText: 'Enter Residence Phone',
                      ),
                      16.height,
                      Text(
                        'Profession',
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: context.colorScheme.onPrimaryContainer
                                .withOp(0.5)),
                      ),
                      8.height,
                      AppTextField(
                        controller: TextEditingController(),
                        hintText: 'Enter Profession',
                      ),
                    ],
                  ),
                ),
                34.height,
                CustomElevatedButton(
                    onPressed: () {}, text: 'Save  Information'),
                20.height,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
