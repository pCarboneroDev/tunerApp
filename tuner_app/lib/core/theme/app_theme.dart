import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tuner_app/core/theme/app_colors.dart';

class AppTheme {
  static Future<ThemeData?> getTheme(bool isDark) async {

    return ThemeData(
      colorScheme: ColorScheme(
        brightness: isDark ? Brightness.dark : Brightness.light, 
        primary: isDark ? AppColors.primaryDark : AppColors.primaryLight, 
        onPrimary: isDark ? AppColors.onSurfaceDark : AppColors.onSurfaceLight, 
        secondary: isDark ? AppColors.secondaryDark : AppColors.secondaryDark,
        onSecondary: isDark ? AppColors.onSurfaceDark : AppColors.onSurfaceLight,
        error: Colors.red, 
        onError: Colors.white, 
        surface: isDark ? AppColors.surfaceDark : AppColors.surfaceLight, 
        onSurface: isDark ? AppColors.onSurfaceDark : AppColors.onSurfaceLight
      )
    );
  }
}