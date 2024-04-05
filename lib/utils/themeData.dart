
import 'package:flutter/material.dart';

class MyThemeData {
  static ThemeData dark() {
    return ThemeData.dark().copyWith(
      primaryColor: const Color(0xFF000000),
      scaffoldBackgroundColor: const Color(0xFF343A40),
      appBarTheme: const AppBarTheme().copyWith(
        backgroundColor: const Color(0xFF343A40),
      ),
      iconTheme: const IconThemeData().copyWith(
        color: const Color(0xFF000000),
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
        fillColor: Colors.black
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData().copyWith(
        backgroundColor: const Color(0xFF0645BB),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData().copyWith(
        backgroundColor: const Color(0xFF121417),
        selectedItemColor: const Color(0xFF0248C2),
        unselectedItemColor: Colors.grey,
      ),
      tabBarTheme: const TabBarTheme().copyWith(
        labelColor: const Color(0xFF0061FF),
        unselectedLabelColor: Colors.grey,
      ),
    );
  }
}