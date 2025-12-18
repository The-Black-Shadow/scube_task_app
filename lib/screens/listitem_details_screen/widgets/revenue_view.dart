import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scube_task_app/constant/app_assert_image.dart';
import 'package:scube_task_app/constant/app_colors.dart';
import 'package:scube_task_app/constant/app_strings.dart';
import 'package:scube_task_app/screens/listitem_details_screen/listitem_details_controller.dart';
import 'package:scube_task_app/utils/app_size.dart';
import 'package:scube_task_app/screens/listitem_details_screen/widgets/revenue_info_item.dart';

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
        crossAxisAlignment: CrossAxisAlignment.stretch,
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
                        fontSize: AppSize.width(value: 12),
                        fontWeight: FontWeight.w600,
                        color: AppColors.instance.textDarkBlue,
                      ),
                    ),
                  ],
                ),
                Obx(
                  () => GestureDetector(
                    onTap: controller.toggleRevenueExpanded,
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.instance.primaryBlue,
                        shape: BoxShape.circle,
                      ),
                      child: AnimatedRotation(
                        turns: controller.isRevenueExpanded.value ? 0 : -0.5,
                        duration: const Duration(milliseconds: 300),
                        child: Image.asset(
                          AppAssertImage.instance.chevronsUp,
                          width: AppSize.width(value: 20),
                          height: AppSize.height(value: 20),
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Obx(
            () => controller.isRevenueExpanded.value
                ? Divider(color: AppColors.instance.borderGrey, height: 1)
                : const SizedBox.shrink(),
          ),
          Obx(
            () => AnimatedSize(
              duration: const Duration(milliseconds: 300),
              child: controller.isRevenueExpanded.value
                  ? Padding(
                      padding: EdgeInsets.all(AppSize.width(value: 12)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: controller.revenueItems
                            .asMap()
                            .entries
                            .map(
                              (e) =>
                                  RevenueInfoItem(item: e.value, index: e.key),
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
