import 'package:flutter/material.dart';

class AppColors {
  // define all the colors used in the app
  static const Color primary = Color(0xFF023E8A);

  static const lineChartGradient = [Color(0xff5efce8), Color(0xff2196f3)];
  static const lineChartInnerGradient = [Color(0xff3c8ce7), Color(0xff000000)];
  static const animatedLayerGradient = [Color(0xff003566), Color(0xff006FD6)];
  static const primaryButtonGradient = [Color(0xFF023E8A), Color(0xFF003270)];

  static const mainRed = Color(0xFFFF1700);
  static const mainGreen = Color(0xFF06FF00);
  static const mainYellow = Color(0xFFEDC531);

  static const correctColor = Color(0xFF0049A5);
  static const wrongColor = Color(0xFF9A0000);

  static const pieChartIndicator = {
    'Easy': Color(0xff0293ee),
    'Normal': Color(0xfff8b250),
    'Hard': Color(0xff845bef),
    'Ultimate': Color(0xff13d38e),
  };

  static MaterialColor getMaterialColor(Color color) {
    final int red = color.red;
    final int green = color.green;
    final int blue = color.blue;

    final Map<int, Color> shades = {
      50: Color.fromRGBO(red, green, blue, .1),
      100: Color.fromRGBO(red, green, blue, .2),
      200: Color.fromRGBO(red, green, blue, .3),
      300: Color.fromRGBO(red, green, blue, .4),
      400: Color.fromRGBO(red, green, blue, .5),
      500: Color.fromRGBO(red, green, blue, .6),
      600: Color.fromRGBO(red, green, blue, .7),
      700: Color.fromRGBO(red, green, blue, .8),
      800: Color.fromRGBO(red, green, blue, .9),
      900: Color.fromRGBO(red, green, blue, 1),
    };

    return MaterialColor(color.value, shades);
  }
}
