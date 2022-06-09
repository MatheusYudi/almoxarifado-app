import 'package:flutter/material.dart';

class AppTheme{
  static ThemeData defaultTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: const Color(0xFF43a047),
    scaffoldBackgroundColor: const Color(0xFF37474f),
    cardColor: const Color(0xFFD9DEE0),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF43a047),
    ),
    canvasColor: const Color(0xFF37474f),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(const Color(0xFF43a047)),
      ),
    ),
    colorScheme: const ColorScheme.light().copyWith(
      background: const Color(0xFF37474f),
      primary: const Color(0xFF2E7D32),
    ),
    fontFamily: 'Roboto',
    textTheme: const TextTheme(
      displaySmall: TextStyle(
        color: Color(0xFF000000),
      ),
      titleLarge: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}