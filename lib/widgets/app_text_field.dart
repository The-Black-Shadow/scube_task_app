import 'package:flutter/material.dart';
import 'package:scube_task_app/constant/app_colors.dart';
import 'package:scube_task_app/constant/app_text_styles.dart';
import 'package:scube_task_app/utils/app_size.dart';

class AppTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController? controller;
  final bool obscureText;
  final Widget? suffixIcon;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;

  const AppTextField({
    super.key,
    required this.hintText,
    this.controller,
    this.obscureText = false,
    this.suffixIcon,
    this.keyboardType,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      validator: validator,
      style: AppTextStyles.instance.inputTextStyle,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: AppTextStyles.instance.inputHintStyle,
        suffixIcon: suffixIcon,
        contentPadding: EdgeInsets.symmetric(
          horizontal: AppSize.width(value: 16),
          vertical: AppSize.height(value: 14),
        ),
        filled: true,
        fillColor: AppColors.instance.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSize.width(value: 8)),
          borderSide: BorderSide(color: AppColors.instance.borderGrey),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSize.width(value: 8)),
          borderSide: BorderSide(color: AppColors.instance.borderGrey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSize.width(value: 8)),
          borderSide: BorderSide(
            color: AppColors.instance.primaryBlue,
            width: 2,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSize.width(value: 8)),
          borderSide: const BorderSide(color: Colors.red),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSize.width(value: 8)),
          borderSide: const BorderSide(color: Colors.red, width: 2),
        ),
      ),
    );
  }
}
