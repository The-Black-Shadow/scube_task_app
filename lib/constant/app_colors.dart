import 'package:flutter/material.dart';

class AppColors {
  AppColors._privateConstructor();
  static final AppColors _instance = AppColors._privateConstructor();
  static AppColors get instance => _instance;

  // Primary colors
  final Color primaryBlue = const Color(0xFF0096FC);
  final Color primaryBlueDark = const Color(0xFF1976D2);

  // Background colors
  final Color backgroundColor = const Color(0xFFd9e4f1);
  final Color white = const Color(0xFFFFFFFF);
  final Color cardBackground = const Color(0xFFFFFFFF);

  // Dashboard specific
  final Color dashboardBg = const Color(
    0xFFE8F0F8,
  ); // Light blueish grey from image
  final Color chartBlue = const Color(0xFF398FC9); // Circular chart color
  final Color activeBlue = const Color(0xFF64B5F6); // Active status dot
  final Color statusOrange = const Color(0xFFFB902E);
  final Color inactiveRed = const Color(0xFFDF2222); // Inactive status dot
  final Color listBackground = const Color(0xFFE5F4FE); // List item background

  // Tab Bar
  final Color tabSelected = const Color(0xFF0096FC);
  final Color tabUnselected = const Color(0xFFFFFFFF);

  // Text colors
  final Color textDark = const Color(0xFF082438);
  final Color textDarkBlue = const Color(0xFF04063E);
  final Color textGrey = const Color(0xFF666666);
  final Color textTab = const Color(0xFF646984);
  final Color textHint = const Color(0xFF5E5E5E);
  final Color textTitle = const Color(0xFF082438);

  // Border colors
  final Color borderGrey = const Color(0xFFB9C6D6);

  // Link colors
  final Color linkGrey = const Color(0xFF5E5E5E);
}
