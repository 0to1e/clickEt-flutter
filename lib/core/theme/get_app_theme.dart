import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  AppTheme._();

  static getApplicationTheme({required bool isDarkMode}) {
    return ThemeData(
      colorScheme: const ColorScheme.light(
        primary: Color(0xFFD8021F),
        secondary: Color(0xFFB71C1C),
      ),
      textTheme: GoogleFonts.lexendTextTheme(
        const TextTheme(
          headlineLarge: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
          bodyLarge: TextStyle(
            fontSize: 17,
            color: Colors.black,
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
