import 'package:ClickEt/core/sys_theme_data.dart';
import 'package:ClickEt/views/splash_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Movie Ticketing App',
      theme: getThemeData(),
      darkTheme: getDarkThemeData(),
      themeMode: ThemeMode.light,
      home: const SplashScreen(),
    );
  }
}
