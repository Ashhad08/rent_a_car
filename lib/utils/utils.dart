import 'package:flutter/material.dart';

import '../constants/extensions.dart';
import '../navigation/navigation_helper.dart';

class Utils {
  IconButton popIcon(BuildContext context) => IconButton(
        style: IconButton.styleFrom(
          iconSize: 22,
          backgroundColor: context.colorScheme.onPrimary,
        ),
        onPressed: () {
          getIt<NavigationHelper>().pop(context);
        },
        icon: Icon(Icons.adaptive.arrow_back),
      );
}
