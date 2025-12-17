import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scube_task_app/constant/app_colors.dart';

import 'package:scube_task_app/constant/app_strings.dart';
import 'package:scube_task_app/utils/app_size.dart';

class CustomToggleButton extends StatelessWidget {
  final bool isSourceSelected;
  final Function(bool) onToggle;

  const CustomToggleButton({
    super.key,
    required this.isSourceSelected,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: AppSize.height(value: 38),
      decoration: BoxDecoration(
        color: AppColors.instance.dashboardBg,
        borderRadius: BorderRadius.circular(AppSize.width(value: 25)),
      ),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () => onToggle(true),
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: isSourceSelected
                      ? AppColors.instance.primaryBlue
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(AppSize.width(value: 25)),
                ),
                child: Text(
                  AppStrings.instance.toggleSource,
                  style: GoogleFonts.inter(
                    fontSize: AppSize.width(value: 16),
                    fontWeight: FontWeight.w600,
                    color: isSourceSelected
                        ? AppColors.instance.white
                        : AppColors.instance.textGrey,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () => onToggle(false),
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: !isSourceSelected
                      ? AppColors.instance.primaryBlue
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(AppSize.width(value: 25)),
                ),
                child: Text(
                  AppStrings.instance.toggleLoad,
                  style: GoogleFonts.inter(
                    fontSize: AppSize.width(value: 16),
                    fontWeight: FontWeight.w600,
                    color: !isSourceSelected
                        ? AppColors.instance.white
                        : AppColors.instance.textGrey,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
