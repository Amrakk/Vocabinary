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
  static double height12(BuildContext context) =>
      screenHeight(context) / getRatio(context, 12);
  static double height16(BuildContext context) =>
      screenHeight(context) / getRatio(context, 16);

  static double height20(BuildContext context) =>
      screenHeight(context) / getRatio(context, 20);
  static double height22(BuildContext context) =>
      screenHeight(context) / getRatio(context, 22);
  static double height30(BuildContext context) =>
      screenHeight(context) / getRatio(context, 30);

  // Width
  static double width(BuildContext context, double size) =>
      screenHeight(context) / getRatio(context, size);
  static double width10(BuildContext context) =>
      screenHeight(context) / getRatio(context, 10);
  static double width12(BuildContext context) =>
      screenHeight(context) / getRatio(context, 12);
  static double width16(BuildContext context) =>
      screenHeight(context) / getRatio(context, 16);
  static double width20(BuildContext context) =>
      screenHeight(context) / getRatio(context, 20);
  static double width22(BuildContext context) =>
      screenHeight(context) / getRatio(context, 22);
  static double width30(BuildContext context) =>
      screenHeight(context) / getRatio(context, 30);

  // Padding
  static double padding(BuildContext context, double size) =>
      screenHeight(context) / getRatio(context, size);
  static double padding10(BuildContext context) =>
      screenHeight(context) / getRatio(context, 10);
  static double padding12(BuildContext context) =>
      screenHeight(context) / getRatio(context, 12);
  static double padding16(BuildContext context) =>
      screenHeight(context) / getRatio(context, 16);
  static double padding20(BuildContext context) =>
      screenHeight(context) / getRatio(context, 20);
  static double padding22(BuildContext context) =>
      screenHeight(context) / getRatio(context, 22);
  static double padding30(BuildContext context) =>
      screenHeight(context) / getRatio(context, 30);

  // Font Size
  static double fontSize(BuildContext context, double size) =>
      screenHeight(context) / getRatio(context, size);
  static double fontSize10(BuildContext context) =>
      screenHeight(context) / getRatio(context, 10);
  static double fontSize12(BuildContext context) =>
      screenHeight(context) / getRatio(context, 12);
  static double fontSize16(BuildContext context) =>
      screenHeight(context) / getRatio(context, 16);
  static double fontSize18(BuildContext context) =>
      screenHeight(context) / getRatio(context, 18);
  static double fontSize20(BuildContext context) =>
      screenHeight(context) / getRatio(context, 20);
  static double fontSize22(BuildContext context) =>
      screenHeight(context) / getRatio(context, 22);
  static double fontSize30(BuildContext context) =>
      screenHeight(context) / getRatio(context, 30);

  // Radius
  static double radius(BuildContext context, double size) =>
      screenHeight(context) / getRatio(context, size);
  static double radius10(BuildContext context) =>
      screenHeight(context) / getRatio(context, 10);
  static double radius12(BuildContext context) =>
      screenHeight(context) / getRatio(context, 12);
  static double radius16(BuildContext context) =>
      screenHeight(context) / getRatio(context, 16);
  static double radius20(BuildContext context) =>
      screenHeight(context) / getRatio(context, 20);
  static double radius22(BuildContext context) =>
      screenHeight(context) / getRatio(context, 22);
  static double radius30(BuildContext context) =>
      screenHeight(context) / getRatio(context, 30);

  // Icon Size
  static double iconSize(BuildContext context, double size) =>
      screenHeight(context) / getRatio(context, size);
  static double iconSize10(BuildContext context) =>
      screenHeight(context) / getRatio(context, 10);
  static double iconSize12(BuildContext context) =>
      screenHeight(context) / getRatio(context, 12);
  static double iconSize16(BuildContext context) =>
      screenHeight(context) / getRatio(context, 16);
  static double iconSize20(BuildContext context) =>
      screenHeight(context) / getRatio(context, 20);
  static double iconSize22(BuildContext context) =>
      screenHeight(context) / getRatio(context, 22);
  static double iconSize30(BuildContext context) =>
      screenHeight(context) / getRatio(context, 30);
}
