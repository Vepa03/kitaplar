import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
  colorScheme: ColorScheme.light(
    brightness: Brightness.light,
    primary: Colors.white70,
    onPrimary: Colors.white,
    secondary: Colors.blue,
  )
); 
ThemeData darkMode = ThemeData(
  colorScheme: ColorScheme.dark(
    brightness: Brightness.dark,
    primary: Colors.white30,
    onPrimary: Colors.black54,
    secondary: Colors.purple,
  )
);