import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import '../constants/extensions.dart';
import '../navigation/navigation_helper.dart';

class Utils {
  IconButton popIcon(BuildContext context) => IconButton(
        style: IconButton.styleFrom(
          iconSize: 22,
          backgroundColor: Color(0xff1A211D),
        ),
        onPressed: () {
          getIt<NavigationHelper>().pop(context);
        },
        icon: Icon(Icons.adaptive.arrow_back),
      );

  showSuccessFlushBar(
    BuildContext context, {
    required String message,
  }) {
    return Flushbar(
      flushbarPosition: FlushbarPosition.TOP,
      flushbarStyle: FlushbarStyle.FLOATING,
      backgroundColor: getIt<AppColors>().kPrimaryColor,
      message: message,
      messageColor: context.colorScheme.onPrimary,
      messageSize: 14,
      duration: const Duration(seconds: 3),
    )..show(context);
  }

  showErrorFlushBar(
    BuildContext context, {
    required String message,
  }) {
    return Flushbar(
      flushbarPosition: FlushbarPosition.TOP,
      flushbarStyle: FlushbarStyle.FLOATING,
      backgroundColor: CupertinoColors.destructiveRed,
      message: message,
      messageColor: context.colorScheme.onPrimary,
      messageSize: 14,
      duration: const Duration(seconds: 3),
    )..show(context);
  }
}
