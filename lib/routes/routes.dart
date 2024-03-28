import 'package:flutter/material.dart';
import 'package:vocabinary/views/home_view.dart';

class AppRoutes {
  AppRoutes._();

  static const String home = '/';

  static final routes = <String, WidgetBuilder>{
    home: (BuildContext context) => const HomePage(),
  };
}
