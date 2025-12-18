import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scube_task_app/constant/app_assert_image.dart';
import 'package:scube_task_app/constant/app_colors.dart';
import 'package:scube_task_app/constant/app_strings.dart';
import 'package:scube_task_app/screens/listitem_details_screen/listitem_details_controller.dart';
import 'package:scube_task_app/utils/app_size.dart';
import 'package:scube_task_app/screens/listitem_details_screen/widgets/detail_list_item.dart';

class RevenueView extends GetView<ListItemDetailsController> {
  const RevenueView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.instance.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.instance.borderGrey),
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(AppSize.width(value: 12)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.bar_chart, color: AppColors.instance.textGrey),
                    SizedBox(width: 8),
                    Text(
                      AppStrings.instance.dataAndCostInfo,
                      style: GoogleFonts.inter(
                        fontSize: AppSize.width(value: 16),
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF1E2843),
                      ),
                    ),
                  ],
                ),
                Obx(
                  () => GestureDetector(
                    onTap: controller.toggleRevenueExpanded,
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: AppColors.instance.primaryBlue,
                        shape: BoxShape.circle,
                      ),
                      child: AnimatedRotation(
                        turns: controller.isRevenueExpanded.value ? 0 : 0.5,
                        duration: const Duration(milliseconds: 300),
                        child: Image.asset(
                          AppAssertImage.instance.chevronsUp,
                          width: 20,
                          height: 20,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Divider(color: AppColors.instance.borderGrey, height: 1),
          Obx(
            () => AnimatedSize(
              duration: const Duration(milliseconds: 300),
              child: controller.isRevenueExpanded.value
                  ? Padding(
                      padding: EdgeInsets.all(AppSize.width(value: 12)),
                      child: Column(
                        children: controller.revenueItems
                            .asMap()
                            .entries
                            .map(
                              (e) =>
                                  DetailListItem(item: e.value, index: e.key),
                            )
                            .toList(),
                      ),
                    )
                  : const SizedBox.shrink(),
            ),
          ),
        ],
      ),
    );
  }
}
