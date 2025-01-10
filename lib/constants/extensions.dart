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
  Color withOp(double opacity) => withAlpha((opacity * 255).round());
}

extension StringNullExtensions on String? {
  String? get nullIfEmpty {
    if (this != null) {
      if (this is String && (this as String).isEmpty) {
        return null;
      } else {
        return this;
      }
    } else {
      return null;
    }
  }
}

extension StringExtensions on String {
  bool get isEmail {
    return RegExp(
            r"^((([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+(\.([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+)*)|((\x22)((((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(([\x01-\x08\x0b\x0c\x0e-\x1f\x7f]|\x21|[\x23-\x5b]|[\x5d-\x7e]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(\\([\x01-\x09\x0b\x0c\x0d-\x7f]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]))))*(((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(\x22)))@((([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.)+(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))$")
        .hasMatch(toLowerCase());
  }

  bool get isDecimalPositiveNumber {
    RegExp priceRegex = RegExp(r'^(?:[1-9]\d*|0)?(?:\.\d+)?$');
    return priceRegex.hasMatch(this);
  }

  bool get isPercentage {
    RegExp priceRegex = RegExp(r'^(?:100(?:\.0+)?|[0-9]?\d(?:\.\d+)?)%?$');
    return priceRegex.hasMatch(this);
  }

  bool get isPositiveNumber {
    RegExp priceRegex = RegExp(r'^[1-9]\d*$');
    return priceRegex.hasMatch(this);
  }

  bool get isMobileNumber {
    RegExp priceRegex = RegExp(r'^(\+?[1-9]\d{1,3}[-\s.]?)?0?\d{10}$');
    return priceRegex.hasMatch(this);
  }

  bool get isURL {
    String? str = this;
    if (str.isEmpty || str.length > 2083 || str.indexOf('mailto:') == 0) {
      return false;
    }

    final options = {
      'protocols': ['http', 'https', 'ftp'],
      'require_tld': true,
      'require_protocol': false,
      'allow_underscores': false,
    };

    // check protocol
    var split = str.split('://');
    if (split.length > 1) {
      final protocol = shift(split);
      final protocols = options['protocols'] as List<String>;
      if (!protocols.contains(protocol)) {
        return false;
      }
    } else if (options['require_protocol'] == true) {
      return false;
    }
    str = split.join('://');

    // check hash
    split = str.split('#');
    str = shift(split);
    final hash = split.join('#');
    if (hash.isNotEmpty && RegExp(r'\s').hasMatch(hash)) {
      return false;
    }

    // check query params
    split = str?.split('?') ?? [];
    str = shift(split);
    final query = split.join('?');
    if (query != "" && RegExp(r'\s').hasMatch(query)) {
      return false;
    }

    // check path
    split = str?.split('/') ?? [];
    str = shift(split);
    final path = split.join('/');
    if (path != "" && RegExp(r'\s').hasMatch(path)) {
      return false;
    }

    // check auth type urls
    split = str?.split('@') ?? [];
    if (split.length > 1) {
      final auth = shift(split);
      if (auth != null && auth.contains(':')) {
        // final auth = auth.split(':');
        final parts = auth.split(':');
        final user = shift(parts);
        if (user == null || !RegExp(r'^\S+$').hasMatch(user)) {
          return false;
        }
        final pass = parts.join(':');
        if (!RegExp(r'^\S*$').hasMatch(pass)) {
          return false;
        }
      }
    }

    // check hostname
    final hostname = split.join('@');
    split = hostname.split(':');
    if (split.isNotEmpty) {
      final portStr = split.join(':');
      final port = int.tryParse(portStr, radix: 10);
      if (!RegExp(r'^[0-9]+$').hasMatch(portStr) ||
          port == null ||
          port <= 0 ||
          port > 65535) {
        return false;
      }
    }

    return true;
  }

  String get capitalizeFirst {
    if (isEmpty) return this;
    return this[0].toUpperCase() + substring(1);
  }
}

String? shift(List<String> elements) {
  if (elements.isEmpty) return null;
  return elements.removeAt(0);
}

final getIt = GetIt.instance;
