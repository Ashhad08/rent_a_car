import 'package:flutter/material.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/extensions.dart';
import '../../../generated/assets.dart';
import '../../../utils/utils.dart';
import '../../elements/gradient_body.dart';

class RentalRequestsView extends StatelessWidget {
  const RentalRequestsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: getIt<Utils>().popIcon(context),
        title: const Text('Rental Requests'),
      ),
      body: GradientBody(
        child: ListView.separated(
          separatorBuilder: (context, index) => 14.height,
          itemCount: 10,
          padding: EdgeInsets.all(20),
          itemBuilder: (context, index) => Container(
            padding: EdgeInsets.only(top: 5, right: 14, left: 14, bottom: 18),
            decoration: BoxDecoration(
              color: getIt<AppColors>().kCardColor,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: context.colorScheme.outline,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  dense: true,
                  contentPadding: EdgeInsets.zero,
                  leading: CircleAvatar(),
                  title: Text(
                    'John Sans',
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: context.colorScheme.onPrimary),
                  ),
                  subtitle: Text(
                    'ID: RQ2412',
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: context.colorScheme.onPrimary),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.access_time_filled,
                        color: context.colorScheme.onPrimary,
                        size: 20,
                      ),
                      4.width,
                      Text(
                        '2 Days',
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: context.colorScheme.onPrimary),
                      )
                    ],
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      Assets.iconsCarFront,
                      color: context.colorScheme.onPrimary,
                      height: 20,
                      width: 20,
                    ),
                    4.width,
                    Expanded(
                      child: Text(
                        'Honda Civic',
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: context.colorScheme.onPrimary),
                      ),
                    )
                  ],
                ),
                10.height,
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.access_time_filled,
                      color: context.colorScheme.onPrimary,
                      size: 20,
                    ),
                    4.width,
                    Expanded(
                      child: Text(
                        'Dec 28,2024- Dec 30,2024',
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: context.colorScheme.onPrimary),
                      ),
                    )
                  ],
                ),
                10.height,
                Row(
                  spacing: 8,
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xffEAB308)),
                        child: Text(
                          'Receipt',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: context.colorScheme.onPrimary),
                        ),
                      ),
                    ),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xffEF4444)),
                        child: Text(
                          'Decline',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: context.colorScheme.onPrimary),
                        ),
                      ),
                    ),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                            backgroundColor: getIt<AppColors>().kPrimaryColor),
                        child: Text(
                          'Approve',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: context.colorScheme.surface),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
