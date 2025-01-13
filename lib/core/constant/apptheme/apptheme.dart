import 'package:flutter/material.dart';


class AppTheme {
  static ThemeData arabicTheme = ThemeData(
    fontFamily: "Cairo",
    textTheme: TextTheme(
      headlineLarge: TextStyle(
          fontWeight: FontWeight.bold, fontSize: 28, color: Colors.white),
      headlineMedium: TextStyle(
          fontWeight: FontWeight.bold, fontSize: 24, color: Colors.white),
      bodyMedium: TextStyle(
          height: 2,
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 14),
    ));
}
