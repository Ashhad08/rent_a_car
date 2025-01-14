import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';
import '../../constants/extensions.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.height,
    this.width,
  });

  final VoidCallback? onPressed;
  final String text;
  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: height ?? 54,
        width: width ?? double.infinity,
        decoration: BoxDecoration(
          color: getIt<AppColors>().kPrimaryColor,
          boxShadow: [
            BoxShadow(
              color: getIt<AppColors>().kPrimaryColor,
              blurRadius: 4,
              spreadRadius: 1,
              offset: Offset(0, 0),
            ),
          ],
          borderRadius: BorderRadius.circular(14),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: context.colorScheme.onSecondary,
            ),
          ),
        ),
      ),
    );
  }
}
