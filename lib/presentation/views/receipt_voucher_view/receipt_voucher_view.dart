import 'package:flutter/material.dart';

import '../../../constants/extensions.dart';
import '../../../generated/assets.dart';
import '../../../utils/utils.dart';
import '../../elements/gradient_body.dart';

class ReceiptVoucherView extends StatelessWidget {
  const ReceiptVoucherView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: getIt<Utils>().popIcon(context),
        title: const Text('Receipt Voucher'),
      ),
      body: GradientBody(
        child: ListView.separated(
          padding: EdgeInsets.all(20),
          separatorBuilder: (context, index) => 14.height,
          itemCount: 10,
          physics: AlwaysScrollableScrollPhysics(),
          itemBuilder: (context, index) => Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 18),
            decoration: BoxDecoration(
                color: context.colorScheme.onPrimary,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: context.colorScheme.outline.withOp(0.7),
                )),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                        child: Column(
                      spacing: 4,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Petrol',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          'Refilled tank at shell station',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: context.colorScheme.onSecondaryContainer
                                  .withOp(0.6)),
                        ),
                        Text(
                          'Dec 27, 2024',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: context.colorScheme.onSecondaryContainer
                                  .withOp(0.8)),
                        )
                      ],
                    )),
                    10.width,
                    Column(
                      children: [
                        IconButton.outlined(
                            onPressed: () {},
                            padding: EdgeInsets.zero,
                            icon: Image.asset(
                              Assets.iconsEdit2,
                              color: context.colorScheme.onPrimaryContainer
                                  .withOp(0.5),
                              height: 18,
                              width: 18,
                            )).space(height: 30, width: 30),
                        12.height,
                        IconButton.outlined(
                            onPressed: () {},
                            padding: EdgeInsets.zero,
                            icon: Image.asset(
                              Assets.iconsDelete,
                              color: context.colorScheme.onPrimaryContainer
                                  .withOp(0.5),
                              height: 18,
                              width: 18,
                            )).space(height: 30, width: 30),
                      ],
                    ),
                  ],
                ),
                14.height,
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 18, vertical: 7),
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
                        'Amount',
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: context.colorScheme.onSecondaryContainer
                                .withOp(0.8)),
                      ),
                      Text(
                        2000.toString(),
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: context.colorScheme.primary),
                      )
                    ],
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
