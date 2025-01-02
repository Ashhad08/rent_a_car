import 'package:flutter/material.dart';

import '../../../constants/extensions.dart';
import '../../../generated/assets.dart';
import '../../../navigation/navigation_helper.dart';
import '../../../utils/utils.dart';
import '../../elements/gradient_body.dart';
import '../add_promotions_view/add_promotions_view.dart';

class AllPromotionsView extends StatelessWidget {
  const AllPromotionsView({super.key});

  @override
  Widget build(BuildContext context) {
    final tabs = [
      'Active',
      'Inactive',
    ];
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: getIt<Utils>().popIcon(context),
        title: const Text('All Promotions'),
        actions: [
          IconButton(
            style: IconButton.styleFrom(
              padding: EdgeInsets.zero,
              fixedSize: Size(24, 24),
              iconSize: 22,
              backgroundColor: context.colorScheme.secondary,
              foregroundColor: context.colorScheme.onPrimary,
            ),
            onPressed: () {
              getIt<NavigationHelper>().push(context, AddPromotionsView());
            },
            icon: Icon(Icons.add),
          ).space(height: 32, width: 32),
          20.width,
        ],
      ),
      body: GradientBody(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  spacing: 8,
                  children: List.generate(
                    tabs.length,
                    (index) => OutlinedButton(
                      onPressed: () {},
                      style: OutlinedButton.styleFrom(
                          backgroundColor: index == 0
                              ? context.colorScheme.primary
                              : context.colorScheme.onPrimary,
                          padding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          side: BorderSide(
                              color: index == 0
                                  ? Colors.transparent
                                  : context.colorScheme.outline.withOp(0.7)),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24))),
                      child: Text(
                        tabs[index],
                        style: TextStyle(
                            fontSize: 12,
                            color: index == 0
                                ? context.colorScheme.onPrimary
                                : context.colorScheme.onPrimaryContainer
                                    .withOp(0.6),
                            fontWeight:
                                index == 0 ? FontWeight.w500 : FontWeight.w400),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
                child: ListView.separated(
              separatorBuilder: (context, index) => 14.height,
              itemCount: 10,
              padding: EdgeInsets.all(20),
              itemBuilder: (context, index) => Container(
                padding: EdgeInsets.symmetric(horizontal: 14, vertical: 18),
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
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Weekly Rent Discounts',
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w600),
                          ),
                        ),
                        10.width,
                        Text(
                          '15% off',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: context.colorScheme.secondary),
                        ),
                      ],
                    ),
                    8.height,
                    Text(
                      'Vehicles: Suzuki Alto, Toyota Corolla',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color:
                            context.colorScheme.onPrimaryContainer.withOp(0.5),
                      ),
                    ),
                    8.height,
                    Text(
                      'Jan 1, 2024 - Jan 7, 2024',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color:
                            context.colorScheme.onPrimaryContainer.withOp(0.5),
                      ),
                    ),
                    15.height,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
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
                        12.width,
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
                    )
                  ],
                ),
              ),
            ))
          ],
        ),
      ),
    );
  }
}
