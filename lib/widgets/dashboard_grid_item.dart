import 'package:flutter/material.dart';
import 'package:scube_task_app/constant/app_colors.dart';
import 'package:scube_task_app/constant/app_text_styles.dart';
import 'package:scube_task_app/utils/app_size.dart';

class DashboardGridItem extends StatelessWidget {
  final String iconPath;
  final String label;
  final VoidCallback onTap;

  const DashboardGridItem({
    super.key,
    required this.iconPath,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.instance.white,
          borderRadius: BorderRadius.circular(AppSize.width(value: 12)),
          border: Border.all(
            color: AppColors.instance.borderGrey.withOpacity(0.5),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              iconPath,
              width: AppSize.width(value: 24),
              height: AppSize.width(value: 24),
              fit: BoxFit.contain,
            ),
            SizedBox(width: AppSize.width(value: 8)),
            Flexible(
              child: Text(
                label,
                style: AppTextStyles.instance.gridButtonText,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
