import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  AppTheme._();
  static ThemeData getApplicationTheme({required bool isDarkMode}) {
    return ThemeData(
      colorScheme: isDarkMode
          ? const ColorScheme.dark(
              primary: Color(0xFFD8021F),
              secondary: Color(0xFFB71C1C),
            )
          : const ColorScheme.light(
              primary: Color(0xFFD8021F),
              secondary: Color(0xFFB71C1C),
            ),
      textTheme: GoogleFonts.lexendTextTheme(
        TextTheme(
          headlineLarge: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: isDarkMode ? Colors.white : Colors.black,
          ),
          headlineMedium: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.w600,
            color: isDarkMode ? Colors.white : Colors.black,
          ),
          bodyLarge: TextStyle(
            fontSize: 17,
            color: isDarkMode ? Colors.white : Colors.black,
          ),
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFD8021F),
          foregroundColor: Colors.white,
        ),
      ),
      brightness: isDarkMode ? Brightness.dark : Brightness.light,
    );
  }
}
