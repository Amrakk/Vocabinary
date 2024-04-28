import 'package:flutter/material.dart';
import 'package:vocabinary/utils/app_colors.dart';

class AppThemes {
  static ThemeData darkTheme() {
    return ThemeData.dark().copyWith(
      extensions: [
        const AppColorsThemeData(
          containerColor: Color(0xFF46494C),
          subTextColor: Color(0x99FFFFFF),
        ),
      ],

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5)
            ),

        )
      ),
      dialogTheme: const DialogTheme().copyWith(
        backgroundColor: const Color(0xFF222222),
      ),
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
        fillColor: const Color(0xFF616161),
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
      sliderTheme: const SliderThemeData().copyWith(
        activeTrackColor: const Color(0xFF0061FF),
        inactiveTrackColor: Colors.grey,
        trackHeight: 7.0,

        thumbColor: const Color(0xFFFFFFFF),
        overlayColor: const Color(0xFF0061FF).withOpacity(0.2),
      ),
    );
  }

  // TODO: Implement light themedata
  static ThemeData lightTheme() {
    return ThemeData.light().copyWith();
  }
}
