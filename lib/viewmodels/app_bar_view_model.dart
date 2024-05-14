import 'package:flutter/material.dart';

class AppBarViewModel  extends ChangeNotifier {
  bool isEnable = true;
  void setOff() {
    isEnable = false;
    notifyListeners();
  }
  void setOn() {
    isEnable = true;
    notifyListeners();
  }
}