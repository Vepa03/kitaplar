import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
  colorScheme: ColorScheme.light(
    brightness: Brightness.light,
    primary: Colors.white70,
    background: Colors.white,
    
    onPrimary: Colors.white,
    secondary: Colors.blue,
  )
); 
ThemeData darkMode = ThemeData(
  colorScheme: ColorScheme.dark(
    brightness: Brightness.dark,
    primary: Colors.white30,
    background: Colors.black26,
    onPrimary: Colors.black54,
    secondary: Colors.purple,
  )
);