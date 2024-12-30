import 'package:flutter/material.dart';

import '../../../../constants/extensions.dart';
import '../../../../navigation/navigation_helper.dart';

class DashboardCard extends StatelessWidget {
  const DashboardCard(
      {super.key,
      required this.color,
      required this.title,
      required this.data,
      required this.icon,
      required this.nextScreen});

  final Color color;
  final String title;
  final String data;
  final String icon;
  final Widget nextScreen;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipPath(
          clipper: CustomClipperForInwardBottomRight(),
          child: Container(
            padding: EdgeInsets.all(14),
            color: color,
            height: 130,
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    color: context.colorScheme.onPrimary,
                  ),
                ),
                2.height,
                Text(
                  data,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 21,
                    color: context.colorScheme.onPrimary,
                  ),
                ),
                Spacer(),
                Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 2),
                    decoration: BoxDecoration(
                        color: context.colorScheme.onPrimary,
                        borderRadius: BorderRadius.circular(100)),
                    child: ImageIcon(
                      AssetImage(icon),
                      color: color,
                      size: 27,
                    ))
              ],
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: ElevatedButton(
            onPressed: () {
              getIt<NavigationHelper>().push(context, nextScreen);
            },
            style: ElevatedButton.styleFrom(
                foregroundColor: context.colorScheme.onPrimary,
                backgroundColor: color,
                padding: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100))),
            child: Icon(
              Icons.arrow_forward,
              color: context.colorScheme.onPrimary,
              size: 26,
            ),
          ).space(height: 50, width: 50),
        )
      ],
    ).space(height: 130);
  }
}

class CustomClipperForInwardBottomRight extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();

    // Top-left corner rounded
    path.moveTo(0, 25);
    path.quadraticBezierTo(0, 0, 25, 0);

    // Top-right corner rounded
    path.lineTo(size.width - 25, 0);
    path.quadraticBezierTo(size.width, 0, size.width, 25);

    // Bottom-right corner inward rounded
    path.lineTo(size.width, size.height - 50);
    path.arcToPoint(
      Offset(size.width - 50, size.height),
      radius: Radius.circular(25),
      clockwise: false,
    );

    // Bottom-left corner rounded
    path.lineTo(25, size.height);
    path.quadraticBezierTo(0, size.height, 0, size.height - 25);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
