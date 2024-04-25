import 'package:flutter/material.dart';

class AppColorsThemeData extends ThemeExtension<AppColorsThemeData> {
  // Specifies colors you want to use that are not in the ThemeData property (app_themes)
  final Color containerColor;

  const AppColorsThemeData({required this.containerColor});

  @override
  ThemeExtension<AppColorsThemeData> copyWith() {
    return AppColorsThemeData(
      containerColor: containerColor,
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
    );
  }
}
