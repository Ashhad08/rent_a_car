import 'package:flutter/material.dart';

import '../../../constants/extensions.dart';
import '../../../generated/assets.dart';
import '../../../utils/utils.dart';
import '../../elements/gradient_body.dart';

class RentalRequestsView extends StatelessWidget {
  const RentalRequestsView({super.key});

  @override
  Widget build(BuildContext context) {
    final tabs = ['All', 'Pending', 'Approved', 'Declined'];
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: getIt<Utils>().popIcon(context),
        title: const Text('Rental Requests'),
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
                padding:
                    EdgeInsets.only(top: 5, right: 14, left: 14, bottom: 18),
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
                    ListTile(
                      dense: true,
                      contentPadding: EdgeInsets.zero,
                      leading: CircleAvatar(),
                      title: Text(
                        'John Sans',
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.w400),
                      ),
                      subtitle: Text(
                        'ID: RQ2412',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: context.colorScheme.onPrimaryContainer
                              .withOp(0.6),
                        ),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.access_time_filled,
                            color: context.colorScheme.onPrimaryContainer
                                .withOp(0.3),
                            size: 20,
                          ),
                          4.width,
                          Text(
                            '2 Days',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: context.colorScheme.onPrimaryContainer
                                  .withOp(0.8),
                            ),
                          )
                        ],
                      ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset(
                          Assets.iconsCarFront,
                          color: context.colorScheme.onPrimaryContainer
                              .withOp(0.3),
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
                              color: context.colorScheme.onPrimaryContainer
                                  .withOp(0.8),
                            ),
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
                          color: context.colorScheme.onPrimaryContainer
                              .withOp(0.3),
                          size: 20,
                        ),
                        4.width,
                        Expanded(
                          child: Text(
                            'Dec 28,2024- Dec 30,2024',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: context.colorScheme.onPrimaryContainer
                                  .withOp(0.8),
                            ),
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
                              'Pending',
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
                                backgroundColor: Color(0xff22C55E)),
                            child: Text(
                              'Approve',
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: context.colorScheme.onPrimary),
                            ),
                          ),
                        ),
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
