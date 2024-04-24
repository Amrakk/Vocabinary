import 'package:flutter/material.dart';
import 'package:vocabinary/data/caches/shared_preference_helper.dart';

class ThemeViewModel extends ChangeNotifier {
  late SharedPreferenceHelper _sharedPrefsHelper;

  bool _isDarkModeOn = true;

  ThemeViewModel() {
    _sharedPrefsHelper = SharedPreferenceHelper();
  }

  bool get isDarkModeOn {
    _sharedPrefsHelper.isDarkMode.then((statusValue) {
      _isDarkModeOn = statusValue;
    });

    return _isDarkModeOn;
  }

  void updateTheme(bool isDarkModeOn) async {
    _sharedPrefsHelper.changeTheme(isDarkModeOn);
    _sharedPrefsHelper.isDarkMode.then((darkModeStatus) {
      _isDarkModeOn = darkModeStatus;
    });
    notifyListeners();
  }
}
