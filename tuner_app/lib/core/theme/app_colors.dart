import 'package:flutter/material.dart';

class AppColors {
  static const Color primaryLight = Color.fromARGB(255, 131, 83, 21);
  static const Color primaryDark = Color.fromARGB(255, 250, 186, 114);

  static const Color surfaceLight = Color.fromARGB(255, 255, 220, 186);
  static const Color surfaceDark = Color.fromARGB(255, 61, 37, 0);

  static const Color onSurfaceLight = Color.fromARGB(255, 61, 37, 0);
  static const Color onSurfaceDark = Color.fromARGB(255, 255, 220, 186);

  static const Color secondaryLight = Color.fromARGB(255, 113, 90, 65);
  static const Color secondaryDark = Color.fromARGB(255, 224, 193, 163);


  static ThemeData darkTheme(){
    return ThemeData(
      //colorSchemeSeed: Color.fromARGB(255, 255, 172, 64),
      colorScheme: ColorScheme(
        brightness: Brightness.dark,
        primary: Color.fromARGB(255, 250, 186, 114),
        onPrimary: Color.fromARGB(255, 72, 41, 0),
        secondary: Color.fromARGB(255, 224, 193, 163), 
        onSecondary: Color.fromARGB(255, 63, 45, 23), 
        error: Color.fromARGB(255, 255, 179, 171), 
        onError: Color.fromARGB(255, 105, 0, 5), 
        surface: Color.fromARGB(255, 32, 19, 0), 
        onSurface: Color.fromARGB(255, 255, 220, 186)
      )
    );
  }
}