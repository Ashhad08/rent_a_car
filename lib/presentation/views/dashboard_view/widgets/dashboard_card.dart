import 'package:flutter/material.dart';

import '../../../../constants/app_colors.dart';
import '../../../../constants/extensions.dart';
import '../../../../navigation/navigation_helper.dart';

class DashboardCard extends StatelessWidget {
  const DashboardCard(
      {super.key,
      required this.title,
      required this.data,
      required this.icon,
      required this.nextScreen});

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
            color: getIt<AppColors>().kCardColor,
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
                        color: context.colorScheme.surface,
                        borderRadius: BorderRadius.circular(100)),
                    child: ImageIcon(
                      AssetImage(icon),
                      color: getIt<AppColors>().kPrimaryColor,
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
                foregroundColor: context.colorScheme.onSecondary,
                backgroundColor: getIt<AppColors>().kPrimaryColor,
                padding: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100))),
            child: Icon(
              Icons.arrow_forward,
              color: context.colorScheme.onSecondary,
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
// import 'dart:ui' as ui;
//
// //Add this CustomPaint widget to the Widget Tree
// CustomPaint(
// size: Size(169, 124),
// painter: RPSCustomPainter(),
// )
//
// //Copy this CustomPainter code to the Bottom of the File
// class RPSCustomPainter extends CustomPainter {
// @override
// void paint(Canvas canvas, Size size) {
//
// Path path_0 = Path();
// path_0.moveTo(3.51472,3.51472);
// path_0.cubicTo(0,7.02944,0,12.6863,0,24);
// path_0.lineTo(0,100);
// path_0.cubicTo(0,111.314,0,116.971,3.51472,120.485);
// path_0.cubicTo(7.02944,124,12.6863,124,24,124);
// path_0.lineTo(107.175,124);
// path_0.cubicTo(114.626,120.61,114.626,112.24,114.626,112.24);
// path_0.lineTo(114.626,102.24);
// path_0.cubicTo(114.626,87.8806,126.266,76.24,140.626,76.24);
// path_0.lineTo(160.126,76.24);
// path_0.cubicTo(160.126,76.24,167.626,76.24,168.626,68.24);
// path_0.cubicTo(168.751,67.237,168.877,66.6113,169,66.284);
// path_0.lineTo(169,24);
// path_0.cubicTo(169,12.6863,169,7.02944,165.485,3.51472);
// path_0.cubicTo(161.971,0,156.314,0,145,0);
// path_0.lineTo(24,0);
// path_0.cubicTo(12.6863,0,7.02944,0,3.51472,3.51472);
// path_0.close();
//
// Paint paint_0_fill = Paint()..style=PaintingStyle.fill;
// paint_0_fill.color = Color(0xff2D466E).withOpacity(1.0);
// canvas.drawPath(path_0,paint_0_fill);
//
// }
//
// @override
// bool shouldRepaint(covariant CustomPainter oldDelegate) {
// return true;
// }
// }
