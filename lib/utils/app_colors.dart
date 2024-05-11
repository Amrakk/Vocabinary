import 'package:flutter/material.dart';

class AppColorsThemeData extends ThemeExtension<AppColorsThemeData> {
  // Specifies colors you want to use that are not in the ThemeData property (app_themes)
  final Color containerColor;
  final Color subTextColor;
  final Color blueColor;

  const AppColorsThemeData({required this.blueColor ,required this.containerColor, required this.subTextColor});

  @override
  ThemeExtension<AppColorsThemeData> copyWith() {
    return AppColorsThemeData(
      containerColor: containerColor,
      subTextColor: subTextColor,
      blueColor: blueColor,
    );
  }

  @override
  ThemeExtension<AppColorsThemeData> lerp(
    covariant ThemeExtension<AppColorsThemeData>? other,
    double t,
  ) {
    if (other is! AppColorsThemeData) {
      return this;
    }
    return AppColorsThemeData(
      containerColor: Color.lerp(containerColor, other.containerColor, t)!,
      subTextColor: Color.lerp(subTextColor, other.subTextColor, t)!,
      blueColor: Color.lerp(blueColor, other.blueColor, t)!,
    );
  }
}
