import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
  colorScheme: ColorScheme.light(
    brightness: Brightness.light,
    
  ),


  textTheme: TextTheme(
    titleMedium: TextStyle(color: Colors.black),
    titleLarge: TextStyle(color: Colors.black)
  ),


  iconTheme: IconThemeData(color: Colors.black)
  
  
); 
ThemeData darkMode = ThemeData(
  colorScheme: ColorScheme.dark(
    brightness: Brightness.dark,
  ),


  textTheme: TextTheme(
    titleMedium: TextStyle(color: Colors.white),
    titleLarge: TextStyle(color: Colors.white)
  ),

  iconTheme: IconThemeData(color: Colors.white)
  
);