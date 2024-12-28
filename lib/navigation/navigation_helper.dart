import 'dart:io' show Platform;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NavigationHelper {
  final bool _isIOS = Platform.isIOS;

  Route _buildRoute(Widget targetClass) => _isIOS
      ? CupertinoPageRoute(builder: (context) => targetClass)
      : MaterialPageRoute(builder: (context) => targetClass);

  Future<dynamic> push(BuildContext context, Widget targetClass) =>
      Navigator.of(context).push(_buildRoute(targetClass));

  Future<dynamic> pushReplacement(BuildContext context, Widget targetClass) =>
      Navigator.of(context).pushReplacement(_buildRoute(targetClass));

  void pop(BuildContext context) => Navigator.pop(context);
}
