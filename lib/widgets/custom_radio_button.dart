import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scube_task_app/constant/app_colors.dart';
import 'package:scube_task_app/utils/app_size.dart';

class CustomRadioButton extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const CustomRadioButton({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: AppSize.width(value: 16),
            height: AppSize.width(value: 16),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: isSelected
                    ? AppColors.instance.primaryBlue
                    : AppColors.instance.textGrey,
                width: 1.5,
              ),
            ),
            child: isSelected
                ? Center(
                    child: Container(
                      width: AppSize.width(value: 8),
                      height: AppSize.width(value: 8),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.instance.primaryBlue,
                      ),
                    ),
                  )
                : null,
          ),
          SizedBox(width: AppSize.width(value: 8)),
          Text(
            label,
            style: GoogleFonts.inter(
              fontSize: AppSize.width(value: 16),
              fontWeight: FontWeight.w500,
              color: isSelected
                  ? AppColors.instance.primaryBlue
                  : AppColors.instance.textGrey,
            ),
          ),
        ],
      ),
    );
  }
}
