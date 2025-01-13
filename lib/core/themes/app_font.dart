import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_ecom_app/core/themes/app-color.dart';

/// **FontSizes**: Centralized font size management.
class FontSizes {
  FontSizes._();

  static const double small = 12.0;
  static const double medium = 14.0;
  static const double large = 16.0;
  static const double extraLarge = 22.0;
  static const double title = 30.0;
}

/// **AppFont**: A utility class for managing font styles in the application.
class AppFont {
  AppFont._();

  // App Title Text Style
  static TextStyle appTitle({
    double? fontSize,
    Color? color,
  }) {
    return GoogleFonts.rowdies(
      fontWeight: FontWeight.bold,
      fontSize: fontSize ?? FontSizes.title,
      color: color ?? AppColor.white,
    );
  }

  // Normal Text Style
  static TextStyle normalText({
    double? fontSize,
    Color? color,
  }) {
    return GoogleFonts.poppins(
      fontWeight: FontWeight.normal,
      fontSize: fontSize ?? FontSizes.medium,
      color: color ?? AppColor.principle,
    );
  }

  // Widget Title Text Style
  static TextStyle widgetTitle({
    double? fontSize,
    Color? color,
  }) {
    return GoogleFonts.poppins(
      fontWeight: FontWeight.bold,
      fontSize: fontSize ?? FontSizes.large,
      color: color ?? AppColor.blue,
    );
  }
}

/// **AppFontSize Extension**: Provides size and color modifiers for text styles.
extension AppFontSize on TextStyle {
  TextStyle small({double? fontSize, Color? color}) =>
      copyWith(fontSize: fontSize ?? FontSizes.small, color: color);

  TextStyle medium({double? fontSize, Color? color}) =>
      copyWith(fontSize: fontSize ?? FontSizes.medium, color: color);

  TextStyle large({double? fontSize, Color? color}) =>
      copyWith(fontSize: fontSize ?? FontSizes.large, color: color);

  TextStyle extraLarge({double? fontSize, Color? color}) =>
      copyWith(fontSize: fontSize ?? FontSizes.extraLarge, color: color);
}
