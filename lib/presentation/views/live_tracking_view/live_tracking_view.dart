import 'package:flutter/material.dart';

import '../../../constants/extensions.dart';
import '../../../generated/assets.dart';
import '../../../utils/utils.dart';
import '../../elements/gradient_body.dart';

class LiveTrackingView extends StatelessWidget {
  const LiveTrackingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: getIt<Utils>().popIcon(context),
        title: const Text('Live Tracking'),
      ),
      body: GradientBody(
        child: Container(
          height: double.infinity,
          width: double.infinity,
          alignment: Alignment.bottomCenter,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(Assets.imagesDummyMap), fit: BoxFit.cover)),
          child: Container(
            height: 200,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 34),
            decoration: BoxDecoration(
                color: context.colorScheme.onPrimary,
                border:
                    Border.all(color: context.colorScheme.outline.withOp(.5)),
                borderRadius: BorderRadius.vertical(top: Radius.circular(12))),
            child: Column(
              children: [
                Row(
                  children: [
                    Image.asset(
                      Assets.iconsSpeed,
                      height: 16,
                      width: 16,
                      color: context.colorScheme.onPrimaryContainer.withOp(0.5),
                    ),
                    6.width,
                    Text(
                      'Current Speed',
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: context.colorScheme.onPrimaryContainer
                              .withOp(0.5)),
                    ),
                    10.width,
                    Expanded(
                      child: Text(
                        '80 km /hours',
                        textAlign: TextAlign.end,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    )
                  ],
                ),
                8.height,
                Row(
                  children: [
                    Icon(
                      Icons.location_on,
                      size: 16,
                      color: context.colorScheme.onPrimaryContainer.withOp(0.5),
                    ),
                    6.width,
                    Text(
                      'Location',
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: context.colorScheme.onPrimaryContainer
                              .withOp(0.5)),
                    ),
                    10.width,
                    Expanded(
                      child: Text(
                        'Islamabad',
                        textAlign: TextAlign.end,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    )
                  ],
                ),
                8.height,
                Row(
                  children: [
                    Image.asset(
                      Assets.iconsCar,
                      height: 16,
                      width: 16,
                      color: context.colorScheme.onPrimaryContainer.withOp(0.5),
                    ),
                    6.width,
                    Text(
                      'Suzuki :',
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: context.colorScheme.onPrimaryContainer
                              .withOp(0.5)),
                    ),
                    10.width,
                    Expanded(
                      child: Text(
                        'Reg: CA-678_XYZ',
                        textAlign: TextAlign.end,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    )
                  ],
                ),
                8.height,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
