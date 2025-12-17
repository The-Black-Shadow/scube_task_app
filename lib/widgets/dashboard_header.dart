import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scube_task_app/constant/app_assert_image.dart';
import 'package:scube_task_app/constant/app_colors.dart';
import 'package:scube_task_app/constant/app_text_styles.dart';
import 'package:scube_task_app/utils/app_size.dart';

class DashboardHeader extends StatelessWidget {
  final String title;
  final VoidCallback? onBackPressed;
  final VoidCallback? onNotificationPressed;

  const DashboardHeader({
    super.key,
    required this.title,
    this.onBackPressed,
    this.onNotificationPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppSize.width(value: 20),
        vertical: AppSize.height(value: 16),
      ),
      color: AppColors.instance.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Back Button
          GestureDetector(
            onTap: onBackPressed ?? () => Get.back(),
            child: Icon(
              Icons.arrow_back,
              color: AppColors.instance.textDark,
              size: AppSize.width(value: 24),
            ),
          ),

          // Title
          Text(title, style: AppTextStyles.instance.dashboardHeaderTitle),

          // Notification Icon
          GestureDetector(
            onTap: onNotificationPressed,
            child: Stack(
              children: [
                Image.asset(
                  AppAssertImage.instance.bell,
                  width: AppSize.width(value: 20),
                  height: AppSize.width(value: 20),
                ),
                Positioned(
                  right: 0,
                  top: 0,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
