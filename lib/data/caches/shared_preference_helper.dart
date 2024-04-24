// ignore_for_file: constant_identifier_names

import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceHelper {
  Future<SharedPreferences>? _sharedPreference;

  static const String is_dark_mode = "is_dark_mode";
  static const String auth_token = "auth_token";

  SharedPreferenceHelper() {
    _sharedPreference = SharedPreferences.getInstance();
  }

  // Theme mode
  Future<bool> changeTheme(bool value) {
    return _sharedPreference!
        .then((prefs) => prefs.setBool(is_dark_mode, value));
  }

  Future<bool> get isDarkMode {
    return _sharedPreference!
        .then((prefs) => prefs.getBool(is_dark_mode) ?? false);
  }

  // Auth token
  Future<String?> get authToken async {
    return _sharedPreference!.then((prefs) => prefs.getString(auth_token));
  }

  Future<bool> saveAuthToken(String authToken) async {
    return _sharedPreference!
        .then((prefs) => prefs.setString(auth_token, authToken));
  }

  Future<bool> removeAuthToken() async {
    return _sharedPreference!.then((prefs) => prefs.remove(auth_token));
  }
}
