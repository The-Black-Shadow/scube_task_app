import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scube_task_app/constant/app_colors.dart';
import 'package:scube_task_app/utils/app_size.dart';

class AppTextStyles {
  AppTextStyles._privateConstructor();
  static final AppTextStyles _instance = AppTextStyles._privateConstructor();
  static AppTextStyles get instance => _instance;

  // App name style (large, bold, white)
  TextStyle get appNameStyle => GoogleFonts.inter(
    fontSize: AppSize.width(value: 24),
    fontWeight: FontWeight.w600,
    color: AppColors.instance.white,
  );

  // App subtitle style
  TextStyle get appSubtitleStyle => GoogleFonts.inter(
    fontSize: AppSize.width(value: 20),
    fontWeight: FontWeight.w600,
    color: AppColors.instance.white,
  );

  // Login heading style
  TextStyle get loginHeadingStyle => GoogleFonts.inter(
    fontSize: AppSize.width(value: 24),
    fontWeight: FontWeight.w700,
    color: AppColors.instance.textDark,
  );

  // Input hint style
  TextStyle get inputHintStyle => GoogleFonts.inter(
    fontSize: AppSize.width(value: 14),
    fontWeight: FontWeight.w400,
    color: AppColors.instance.textHint,
  );

  // Input text style
  TextStyle get inputTextStyle => GoogleFonts.inter(
    fontSize: AppSize.width(value: 14),
    fontWeight: FontWeight.w400,
    color: AppColors.instance.textDark,
  );

  // Link text style
  TextStyle get linkStyle => GoogleFonts.inter(
    decoration: TextDecoration.underline,
    fontSize: AppSize.width(value: 12),
    fontWeight: FontWeight.w500,
    color: AppColors.instance.linkGrey,
  );
  TextStyle get linkStyleBlue => GoogleFonts.inter(
    fontSize: AppSize.width(value: 14),
    fontWeight: FontWeight.w600,
    color: AppColors.instance.primaryBlue,
  );

  // Body text style
  TextStyle get bodyTextStyle => GoogleFonts.inter(
    fontSize: AppSize.width(value: 12),
    fontWeight: FontWeight.w500,
    color: AppColors.instance.textGrey,
  );

  // Button text style
  TextStyle get buttonTextStyle => GoogleFonts.inter(
    fontSize: AppSize.width(value: 18),
    fontWeight: FontWeight.w600,
    color: AppColors.instance.white,
  );

  // Dashboard Styles
  TextStyle get dashboardHeaderTitle => GoogleFonts.inter(
    fontSize: AppSize.width(value: 16),
    fontWeight: FontWeight.w500,
    color: AppColors.instance.textDarkBlue,
  );

  TextStyle get dashboardCardTitle => GoogleFonts.inter(
    fontSize: AppSize.width(value: 14),
    fontWeight: FontWeight.w500,
    color: AppColors.instance.textDark,
  );

  TextStyle get dashboardDataLabel => GoogleFonts.inter(
    fontSize: AppSize.width(value: 12),
    fontWeight: FontWeight.w400,
    color: AppColors.instance.textDarkBlue,
  );

  TextStyle get dashboardDataValue => GoogleFonts.inter(
    fontSize: AppSize.width(value: 12),
    fontWeight: FontWeight.w400,
    color: AppColors.instance.textDark,
  );

  TextStyle get powerValue => GoogleFonts.inter(
    fontSize: AppSize.width(value: 16),
    fontWeight: FontWeight.w600,
    color: AppColors.instance.textDark,
  );

  TextStyle get powerUnit => GoogleFonts.inter(
    fontSize: AppSize.width(value: 14),
    fontWeight: FontWeight.w600,
    color: AppColors.instance.textDark,
  );

  TextStyle get gridButtonText => GoogleFonts.inter(
    fontSize: AppSize.width(value: 14),
    fontWeight: FontWeight.w600,
    color: AppColors.instance.textGrey,
  );
}
