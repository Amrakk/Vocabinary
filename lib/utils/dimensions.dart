import 'package:flutter/material.dart';
import 'package:vocabinary/utils/enums.dart';

class Dimensions {
  static double screenHeight(BuildContext context) =>
      MediaQuery.of(context).size.height;
  static double screenWidth(BuildContext context) =>
      MediaQuery.of(context).size.width;

  static ScreenType screenType(BuildContext context) {
    return (screenWidth(context) <= 414)
        ? ScreenType.Small
        : (screenWidth(context) <= 768)
            ? ScreenType.Medium
            : ScreenType.Large;
  }

  static double getRatio(BuildContext context, double size) {
    switch (screenType(context)) {
      case ScreenType.Small:
        return 896 / size;
      case ScreenType.Medium:
        return 1024 / size;
      case ScreenType.Large:
        return 1080 / size;
    }
  }

  // Height
  static double height(BuildContext context, double size) =>
      screenHeight(context) / getRatio(context, size);
  static double height10(BuildContext context) =>
      screenHeight(context) / getRatio(context, 10);
  static double height20(BuildContext context) =>
      screenHeight(context) / getRatio(context, 20);

  // Width
  static double width(BuildContext context, double size) =>
      screenHeight(context) / getRatio(context, size);
  static double width10(BuildContext context) =>
      screenHeight(context) / getRatio(context, 10);

  // Font Size
  static double fontSize(BuildContext context, double size) =>
      screenHeight(context) / getRatio(context, size);
  static double fontSize10(BuildContext context) =>
      screenHeight(context) / getRatio(context, 10);
  static double fontSize20(BuildContext context) =>
      screenHeight(context) / getRatio(context, 20);

  // Radius
  static double radius(BuildContext context, double size) =>
      screenHeight(context) / getRatio(context, size);
  static double radius10(BuildContext context) =>
      screenHeight(context) / getRatio(context, 10);

  // Icon Size
  static double iconSize(BuildContext context, double size) =>
      screenHeight(context) / getRatio(context, size);
  static double iconSize10(BuildContext context) =>
      screenHeight(context) / getRatio(context, 10);
}
