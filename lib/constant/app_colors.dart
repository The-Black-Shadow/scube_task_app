import 'package:flutter/material.dart';

class AppColors {
  AppColors._privateConstructor();
  static final AppColors _instance = AppColors._privateConstructor();
  static AppColors get instance => _instance;

  // Primary colors
  final Color primaryBlue = const Color(0xFF0096FC);
  final Color primaryBlueDark = const Color(0xFF1976D2);

  // Background colors
  final Color backgroundColor = const Color(0xFFF2F9FF);
  final Color white = const Color(0xFFFFFFFF);
  final Color cardBackground = const Color(0xFFFFFFFF);

  // Text colors
  final Color textDark = const Color(0xFF082438);
  final Color textGrey = const Color(0xFF666666);
  final Color textHint = const Color(0xFF5E5E5E);

  // Border colors
  final Color borderGrey = const Color(0xFFB9C6D6);

  // Link colors
  final Color linkGrey = const Color(0xFF5E5E5E);
}
