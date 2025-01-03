import 'package:flutter/material.dart';

import '../../../constants/extensions.dart';
import '../../../utils/utils.dart';
import '../../elements/app_text_field.dart';
import '../../elements/custom_elevated_button.dart';
import '../../elements/gradient_body.dart';

class AddExpensesView extends StatelessWidget {
  const AddExpensesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: getIt<Utils>().popIcon(context),
        title: const Text('Add Expenses'),
      ),
      body: GradientBody(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Expense Type',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color:
                          context.colorScheme.onPrimaryContainer.withOp(0.5)),
                ),
                10.height,
                AppTextField(
                    controller: TextEditingController(),
                    hintText: 'Enter Expense Type'),
                18.height,
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Date',
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: context.colorScheme.onPrimaryContainer
                                    .withOp(0.5)),
                          ),
                          10.height,
                          AppTextField(
                              controller: TextEditingController(),
                              hintText: '12/28/2024'),
                        ],
                      ),
                    ),
                    14.width,
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Time',
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: context.colorScheme.onPrimaryContainer
                                    .withOp(0.5)),
                          ),
                          10.height,
                          AppTextField(
                              controller: TextEditingController(),
                              hintText: '02h 55m pm'),
                        ],
                      ),
                    )
                  ],
                ),
                18.height,
                Text(
                  'Description',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color:
                          context.colorScheme.onPrimaryContainer.withOp(0.5)),
                ),
                10.height,
                AppTextField(
                    maxLines: 3,
                    controller: TextEditingController(),
                    hintText: 'Enter Expense Details'),
                18.height,
                Text(
                  'Total Amount',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color:
                          context.colorScheme.onPrimaryContainer.withOp(0.5)),
                ),
                10.height,
                AppTextField(
                    controller: TextEditingController(), hintText: '2000'),
                34.height,
                CustomElevatedButton(
                  onPressed: () {},
                  text: 'Save Expense',
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
