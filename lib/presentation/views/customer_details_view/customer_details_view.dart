import 'package:flutter/material.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/extensions.dart';
import '../../../utils/utils.dart';
import '../../elements/gradient_body.dart';

class CustomerDetailsView extends StatelessWidget {
  const CustomerDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> customerData = [
      {
        'carName': 'Honda civic',
        'regNumber': 'Reg: CA-678_XYZ',
        'pickDate': 'Mar 15, 2024',
        'returnDate': 'Mar 16, 2024',
        'amountPaid': true,
        'amount': '2000',
        'status': 'Active',
      },
      {
        'carName': 'Honda civic',
        'regNumber': 'Reg: CA-678_XYZ',
        'pickDate': 'Mar 15, 2024',
        'returnDate': 'Mar 16, 2024',
        'amountPaid': false,
        'amount': '2000',
        'status': 'Returned',
      }
    ];
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: getIt<Utils>().popIcon(context),
        title: const Text('Customer Details'),
      ),
      body: GradientBody(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: DefaultTextStyle(
            style: TextStyle(color: context.colorScheme.onPrimary),
            child: Column(
              children: [
                15.height,
                Material(
                  color: Colors.transparent,
                  child: ListTile(
                    leading: CircleAvatar(),
                    style: ListTileStyle.list,
                    tileColor: getIt<AppColors>().kCardColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                        side: BorderSide(color: context.colorScheme.outline)),
                    title: Text(
                      'Brooklyn Simmons',
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: context.colorScheme.onPrimary),
                    ),
                    subtitle: Text(
                      '+92 123456789',
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: context.colorScheme.onPrimary),
                    ),
                  ),
                ),
                18.height,
                Expanded(
                  child: ListView.separated(
                    padding: EdgeInsets.only(bottom: 20),
                    separatorBuilder: (context, index) => 18.height,
                    itemCount: customerData.length,
                    physics: AlwaysScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      final data = customerData[index];
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            padding: EdgeInsets.all(18),
                            decoration: BoxDecoration(
                              color: getIt<AppColors>().kCardColor,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: context.colorScheme.outline,
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            data['carName'],
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: context
                                                    .colorScheme.onPrimary,
                                                fontWeight: FontWeight.w400),
                                          ),
                                          6.height,
                                          Text(
                                            data['regNumber'],
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: context
                                                    .colorScheme.onPrimary,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.center,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 14, vertical: 6),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: context.colorScheme.surface,
                                        border: Border.all(
                                          color:
                                              getIt<AppColors>().kPrimaryColor,
                                        ),
                                      ),
                                      child: Text(
                                        data['status'],
                                        style: TextStyle(
                                            color: getIt<AppColors>()
                                                .kPrimaryColor,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    )
                                  ],
                                ),
                                12.height,
                                Text(
                                  'Pick Date',
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400),
                                ),
                                6.height,
                                Text(
                                  data['pickDate'],
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400),
                                ),
                                12.height,
                                Text(
                                  'Return Date',
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400),
                                ),
                                6.height,
                                Text(
                                  data['returnDate'],
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400),
                                ),
                                12.height,
                                Text(
                                  'Amount',
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400),
                                ),
                                6.height,
                                Text(
                                  (data['amountPaid'] as bool)
                                      ? 'Paid'
                                      : 'Unpaid',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          12.height,
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 18, vertical: 12),
                            decoration: BoxDecoration(
                              color: getIt<AppColors>().kCardColor,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: context.colorScheme.outline,
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Total Amount',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  data['amount'],
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      );
                    },
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
