import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../constants/extensions.dart';
import '../../../generated/assets.dart';
import '../../../utils/utils.dart';
import '../../elements/gradient_body.dart';

class VehicleDetailsView extends StatelessWidget {
  const VehicleDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> overViewItems = [
      {
        'image': Assets.iconsCar2,
        'title': 'Make',
        'value': 'Honda',
      },
      {
        'image': Assets.iconsCar3,
        'title': 'Model',
        'value': 'Civic',
      },
      {
        'image': Assets.iconsCalender,
        'title': 'Year',
        'value': '2024',
      },
      {
        'image': Assets.iconsColor,
        'title': 'Color',
        'value': 'Gray',
      },
    ];
    final List<Map<String, String>> rentalInfoItems = [
      {
        'title': 'Rate Per Day',
        'value': 'Rs. 2000',
      },
      {
        'title': 'Registered City',
        'value': 'Lahore',
      },
      {
        'title': 'Vehicle Type',
        'value': 'Car',
      },
      {
        'title': 'Status',
        'value': 'Available',
      },
    ];
    final List<Map<String, String>> vehicleSpecification = [
      {
        'title': 'Transmission',
        'value': 'Diesel',
      },
      {
        'title': 'Fuel Type',
        'value': 'Petrol',
      },
      {
        'title': 'Seating Capacity',
        'value': '4',
      },
      {
        'title': 'Max Speed',
        'value': '300 km/h',
      },
    ];
    final List<Map<String, dynamic>> additionalFeatures = [
      {
        'title': 'Air Conditioner',
        'value': true,
      },
      {
        'title': 'Heater',
        'value': false,
      },
      {
        'title': 'Sun Roof',
        'value': true,
      },
      {
        'title': 'CD/DVD',
        'value': false,
      },
      {
        'title': 'Front Camera',
        'value': false,
      },
      {
        'title': 'Rear Camera',
        'value': true,
      },
    ];
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: getIt<Utils>().popIcon(context),
        title: const Text('Details'),
        actions: [
          IconButton(
            style: IconButton.styleFrom(
              iconSize: 22,
              backgroundColor: context.colorScheme.onPrimary,
            ),
            onPressed: () {},
            icon: Icon(CupertinoIcons.heart),
          ),
          6.width,
        ],
      ),
      body: GradientBody(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // CarouselView(
              //   itemSnapping: false,
              //   backgroundColor: Colors.transparent,
              //   shrinkExtent: 0,
              //   padding: EdgeInsets.zero,
              //   itemExtent: context.screenWidth,
              //   children: List.generate(
              //     6,
              //     (index) => Padding(
              //       padding: const EdgeInsets.all(12.0),
              //       child: Image.asset(
              //         Assets.imagesCarDummy2,
              //         fit: BoxFit.cover,
              //       ),
              //     ),
              //   ),
              // ).space(height: context.screenHeight * 0.25),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Image.asset(
                  Assets.imagesCarDummy2,
                  fit: BoxFit.cover,
                ),
              ).space(height: context.screenHeight * 0.25),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: context.colorScheme.onPrimary,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(24),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 20, right: 20, left: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Vehicle Overview',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                          14.height,
                          Row(
                            spacing: context.screenWidth * 0.03,
                            children: overViewItems
                                .map(
                                  (e) => Expanded(
                                    child: Container(
                                      height: 92,
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: context.colorScheme.outline
                                                .withOp(0.2)),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Image.asset(
                                            e['image'] as String,
                                            height: 26,
                                            width: 26,
                                          ),
                                          Spacer(),
                                          Text(
                                            e['title'] as String,
                                            style: TextStyle(
                                                fontSize: 10,
                                                color:
                                                    context.colorScheme.outline,
                                                fontWeight: FontWeight.w400),
                                          ),
                                          Text(
                                            e['value'] as String,
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
                          20.height,
                          Text(
                            'Rental Information',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: context.colorScheme.primary),
                          ),
                          15.height,
                          Column(
                            children: rentalInfoItems
                                .map((tile) => Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                            child: Text(
                                          tile['title'] as String,
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                              color:
                                                  context.colorScheme.outline),
                                        )),
                                        Expanded(
                                            child: Text(
                                          tile['value'] as String,
                                          textAlign: TextAlign.end,
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        )),
                                      ],
                                    ))
                                .expand((widget) => [
                                      widget,
                                      Divider(),
                                      6.height,
                                    ])
                                .toList(),
                          ),
                          15.height,
                          Text(
                            'Vehicle Specification',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: context.colorScheme.primary),
                          ),
                          12.height,
                          GridView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: vehicleSpecification.length,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3, mainAxisExtent: 70),
                            itemBuilder: (context, index) => Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  vehicleSpecification[index]['title']
                                      as String,
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: context.colorScheme.outline,
                                      fontWeight: FontWeight.w400),
                                ),
                                Text(
                                  vehicleSpecification[index]['value']
                                      as String,
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400),
                                )
                              ],
                            ),
                          ),
                          Text(
                            'Additional Features',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: context.colorScheme.primary),
                          ),
                          12.height,
                          Column(
                            children: additionalFeatures
                                .map((tile) => Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 16.0),
                                      child: Row(
                                        children: [
                                          Image.asset(
                                            (tile['value'] as bool)
                                                ? Assets.iconsAvailable
                                                : Assets.iconsNotAvailable,
                                            height: 26,
                                            width: 26,
                                          ),
                                          12.width,
                                          Expanded(
                                              child: Text(
                                            tile['title'] as String,
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          )),
                                        ],
                                      ),
                                    ))
                                .toList(),
                          ),
                          Text(
                            'Gallery',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: context.colorScheme.primary),
                          ),
                          12.height,
                        ],
                      ),
                    ),
                    CarouselView.weighted(
                      itemSnapping: true,
                      flexWeights: const <int>[1, 7, 1],
                      controller: CarouselController(initialItem: 2),
                      children: List.generate(
                        5,
                        (index) => ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: OverflowBox(
                            maxWidth: context.screenWidth * 7 / 8,
                            minWidth: context.screenWidth * 7 / 8,
                            child: Image(
                              fit: BoxFit.cover,
                              image: AssetImage(Assets.imagesCarDummy),
                            ),
                          ),
                        ),
                      ),
                    ).space(height: context.screenHeight * 0.25),
                    20.height,
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
