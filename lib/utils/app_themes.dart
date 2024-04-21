import 'package:flutter/material.dart';

class AppThemes {
  static ThemeData darkTheme() {
    return ThemeData.dark().copyWith(
      primaryColor: Colors.black,
      scaffoldBackgroundColor: const Color(0xFF222222),
      appBarTheme: const AppBarTheme().copyWith(
        backgroundColor: const Color(0xFF222222),
      ),
      iconTheme: const IconThemeData().copyWith(
        color: Colors.black,
      ),
      inputDecorationTheme: const InputDecorationTheme().copyWith(
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey, width: 2.0),
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        filled: true,
        fillColor: Colors.black,
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData().copyWith(
        backgroundColor: const Color(0xFF0645BB),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData().copyWith(
        unselectedItemColor: Colors.grey,
        backgroundColor: const Color(0xFF121417),
        selectedItemColor: const Color(0xFF0248C2),
      ),
      tabBarTheme: const TabBarTheme().copyWith(
        labelColor: const Color(0xFF0061FF),
        unselectedLabelColor: Colors.grey,
      ),
    );
  }

  // TODO: Implement light themedata
  static ThemeData lightTheme() {
    return ThemeData.light().copyWith();
  }
}
