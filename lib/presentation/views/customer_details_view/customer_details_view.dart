import 'package:flutter/material.dart';

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
        'statusColor': Color(0xff06A623)
      },
      {
        'carName': 'Honda civic',
        'regNumber': 'Reg: CA-678_XYZ',
        'pickDate': 'Mar 15, 2024',
        'returnDate': 'Mar 16, 2024',
        'amountPaid': false,
        'amount': '2000',
        'status': 'Returned',
        'statusColor': Color(0xffEB6200)
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
          child: Column(
            children: [
              15.height,
              Material(
                color: Colors.transparent,
                child: ListTile(
                  leading: CircleAvatar(),
                  style: ListTileStyle.list,
                  tileColor: context.colorScheme.onPrimary,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                      side: BorderSide(
                          color: context.colorScheme.outline.withOp(0.5))),
                  title: Text(
                    'Brooklyn Simmons',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                  ),
                  subtitle: Text(
                    '+92 123456789',
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: context
                            .theme.listTileTheme.subtitleTextStyle?.color),
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
                            color: context.colorScheme.onPrimary,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: context.colorScheme.outline.withOp(0.6),
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
                                              color: context.colorScheme
                                                  .onPrimaryContainer
                                                  .withOp(0.8),
                                              fontWeight: FontWeight.w400),
                                        ),
                                        Text(
                                          data['regNumber'],
                                          style: TextStyle(
                                              fontSize: 14,
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
                                        color: (data['statusColor'] as Color)
                                            .withOp(0.1),
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                          color: (data['statusColor'] as Color)
                                              .withOp(0.3),
                                        )),
                                    child: Text(
                                      data['status'],
                                      style: TextStyle(
                                          color: (data['statusColor'] as Color),
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
                                    color: context
                                        .colorScheme.onPrimaryContainer
                                        .withOp(0.8),
                                    fontWeight: FontWeight.w400),
                              ),
                              Text(
                                data['pickDate'],
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.w400),
                              ),
                              12.height,
                              Text(
                                'Return Date',
                                style: TextStyle(
                                    fontSize: 12,
                                    color: context
                                        .colorScheme.onPrimaryContainer
                                        .withOp(0.8),
                                    fontWeight: FontWeight.w400),
                              ),
                              Text(
                                data['returnDate'],
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.w400),
                              ),
                              12.height,
                              Text(
                                'Amount',
                                style: TextStyle(
                                    fontSize: 12,
                                    color: context
                                        .colorScheme.onPrimaryContainer
                                        .withOp(0.8),
                                    fontWeight: FontWeight.w400),
                              ),
                              Text(
                                (data['amountPaid'] as bool)
                                    ? 'Paid'
                                    : 'Unpaid',
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: (data['amountPaid'] as bool)
                                        ? Color(0xff03C203)
                                        : Color(0xffEB6200)),
                              ),
                            ],
                          ),
                        ),
                        12.height,
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 18, vertical: 12),
                          decoration: BoxDecoration(
                            color: context.colorScheme.onPrimary,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: context.colorScheme.outline.withOp(0.6),
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
                                  color: context.colorScheme.onPrimaryContainer
                                      .withOp(0.5),
                                ),
                              ),
                              Text(
                                data['amount'],
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: context.colorScheme.primary),
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
    );
  }
}
