import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

extension MediaQueryExtension on BuildContext {
  double get screenWidth => MediaQuery.sizeOf(this).width;

  double get screenHeight => MediaQuery.sizeOf(this).height;

  Orientation get orientation => MediaQuery.orientationOf(this);

  TextTheme get textTheme => Theme.of(this).textTheme;

  ThemeData get theme => Theme.of(this);

  ColorScheme get colorScheme => Theme.of(this).colorScheme;
}

extension WrapSpace on Widget {
  Widget space({double? height, double? width}) => SizedBox(
        height: height,
        width: width,
        child: this,
      );
}

extension Space on num {
  SizedBox get height => SizedBox(height: toDouble());

  SizedBox get width => SizedBox(width: toDouble());
}

extension OpacityExt on Color {
  Color withOp(double opacity) => withValues(alpha: (opacity * 255));
}

final getIt = GetIt.instance;
