import 'package:flutter/material.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/extensions.dart';
import '../../../generated/assets.dart';
import '../../../navigation/navigation_helper.dart';
import '../../../utils/utils.dart';
import '../../elements/gradient_body.dart';
import '../add_expenses_view/add_expenses_view.dart';

class AllExpensesView extends StatelessWidget {
  const AllExpensesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: getIt<Utils>().popIcon(context),
        title: const Text('All Expenses'),
        actions: [
          IconButton(
            style: IconButton.styleFrom(
              padding: EdgeInsets.zero,
              fixedSize: Size(24, 24),
              iconSize: 22,
              backgroundColor: getIt<AppColors>().kPrimaryColor,
              foregroundColor: context.colorScheme.secondary,
            ),
            onPressed: () {
              getIt<NavigationHelper>().push(context, AddExpensesView());
            },
            icon: Icon(Icons.add),
          ).space(height: 32, width: 32),
          20.width,
        ],
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
                color: getIt<AppColors>().kCardColor,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: context.colorScheme.outline)),
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
                              color: context.colorScheme.onPrimary),
                        ),
                        Text(
                          'Refilled tank at shell station',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: context.colorScheme.onPrimary),
                        ),
                        Text(
                          'Dec 27, 2024',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: context.colorScheme.onPrimary),
                        )
                      ],
                    )),
                    10.width,
                    Column(
                      children: [
                        IconButton.outlined(
                            onPressed: () {},
                            padding: EdgeInsets.zero,
                            style: IconButton.styleFrom(
                                side: BorderSide(
                                    color: getIt<AppColors>().kPrimaryColor)),
                            icon: Image.asset(
                              Assets.iconsEdit2,
                              color: getIt<AppColors>().kPrimaryColor,
                              height: 18,
                              width: 18,
                            )).space(height: 30, width: 30),
                        12.height,
                        IconButton.outlined(
                            onPressed: () {},
                            style: IconButton.styleFrom(
                                side: BorderSide(
                                    color: getIt<AppColors>().kPrimaryColor)),
                            padding: EdgeInsets.zero,
                            icon: Image.asset(
                              Assets.iconsDelete,
                              color: getIt<AppColors>().kPrimaryColor,
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
                    color: context.colorScheme.surface,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: context.colorScheme.outline),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Amount',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: getIt<AppColors>().kPrimaryColor,
                        ),
                      ),
                      Text(
                        2000.toString(),
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: getIt<AppColors>().kPrimaryColor,
                        ),
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
