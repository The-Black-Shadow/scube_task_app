import 'package:flutter/material.dart';
import 'package:scube_task_app/constant/app_colors.dart';

class AppTheme {
  AppTheme._privateConstructor();
  static final AppTheme _instance = AppTheme._privateConstructor();
  static AppTheme get instance => _instance;

  ThemeData get lightTheme => ThemeData(
    useMaterial3: true,
    primaryColor: AppColors.instance.primaryBlue,
    scaffoldBackgroundColor: AppColors.instance.backgroundColor,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.instance.primaryBlue,
      primary: AppColors.instance.primaryBlue,
      surface: AppColors.instance.white,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.instance.primaryBlue,
      foregroundColor: AppColors.instance.white,
      elevation: 0,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.instance.primaryBlue,
        foregroundColor: AppColors.instance.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.instance.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: AppColors.instance.borderGrey),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: AppColors.instance.borderGrey),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: AppColors.instance.primaryBlue, width: 2),
      ),
    ),
  );
}
