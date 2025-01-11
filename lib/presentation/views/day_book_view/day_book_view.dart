import 'package:flutter/material.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/extensions.dart';
import '../../../utils/utils.dart';
import '../../elements/gradient_body.dart';

class DayBookView extends StatelessWidget {
  const DayBookView({super.key});

  @override
  Widget build(BuildContext context) {
    final tabs = [
      'Advance',
      'Remaining',
    ];
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: getIt<Utils>().popIcon(context),
        title: const Text('Day Book'),
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
                              ? getIt<AppColors>().kPrimaryColor
                              : context.colorScheme.surface,
                          padding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          side: BorderSide(
                              color: index == 0
                                  ? Colors.transparent
                                  : getIt<AppColors>().kPrimaryColor),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24))),
                      child: Text(
                        tabs[index],
                        style: TextStyle(
                            fontSize: 12,
                            color: index == 0
                                ? context.colorScheme.secondary
                                : getIt<AppColors>().kPrimaryColor,
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
                    itemBuilder: (context, index) => Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Advance',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: context.colorScheme.onPrimary,
                              ),
                            ),
                            9.height,
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      'Muhammad Akram',
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                        color: context.colorScheme.onPrimary,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    'Rs. 3000',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: context.colorScheme.onPrimary,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Divider(),
                          ],
                        )))
          ],
        ),
      ),
    );
  }
}
