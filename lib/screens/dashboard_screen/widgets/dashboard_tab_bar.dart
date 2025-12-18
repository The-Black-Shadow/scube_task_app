import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scube_task_app/constant/app_colors.dart';
import 'package:scube_task_app/constant/app_strings.dart';
import 'package:scube_task_app/screens/dashboard_screen/dashboard_controller.dart';
import 'package:scube_task_app/utils/app_size.dart';

class DashboardTabBar extends GetView<DashboardController> {
  const DashboardTabBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppSize.height(value: 39),
      decoration: BoxDecoration(
        color: AppColors.instance.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
        border: Border.all(color: AppColors.instance.borderGrey),
      ),
      child: Row(
        children: [
          _buildTabItem(AppStrings.instance.tabSummary, 0),
          _buildTabItem(AppStrings.instance.tabSld, 1),
          _buildTabItem(AppStrings.instance.tabData, 2),
        ],
      ),
    );
  }

  Widget _buildTabItem(String label, int index) {
    return Obx(() {
      final bool isSelected = controller.selectedTabIndex.value == index;
      return Expanded(
        child: GestureDetector(
          onTap: () => controller.changeTab(index),
          child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: isSelected
                  ? AppColors.instance.tabSelected
                  : AppColors.instance.tabUnselected,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
            ),
            child: Text(
              label,
              style: GoogleFonts.inter(
                fontSize: AppSize.width(value: 14),
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                color: isSelected
                    ? AppColors.instance.white
                    : AppColors.instance.textTab,
              ),
            ),
          ),
        ),
      );
    });
  }
}
