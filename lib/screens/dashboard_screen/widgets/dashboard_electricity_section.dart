import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scube_task_app/constant/app_colors.dart';
import 'package:scube_task_app/constant/app_strings.dart';
import 'package:scube_task_app/constant/app_text_styles.dart';
import 'package:scube_task_app/screens/dashboard_screen/dashboard_controller.dart';
import 'package:scube_task_app/utils/app_size.dart';
import 'package:scube_task_app/widgets/custom_toggle_button.dart';
import 'package:scube_task_app/widgets/power_circular_chart.dart';
import 'package:scube_task_app/widgets/skeleton_widget.dart';

class DashboardElectricitySection extends GetView<DashboardController> {
  const DashboardElectricitySection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          AppStrings.instance.electricitySection,
          style: AppTextStyles.instance.dashboardDataLabel.copyWith(
            color: AppColors.instance.textGrey,
            fontSize: AppSize.width(value: 16),
            fontWeight: FontWeight.w600,
          ),
        ),
        Divider(color: AppColors.instance.borderGrey),
        SizedBox(height: AppSize.height(value: 8)),

        Obx(() {
          if (controller.isLoading.value) {
            return SkeletonWidget(
              width: AppSize.width(value: 150),
              height: AppSize.width(value: 150),
              borderRadius: BorderRadius.circular(AppSize.width(value: 75)),
            );
          }
          final data = controller.dashboardData.value;
          return PowerCircularChart(
            trackColor: AppColors.instance.chartBlue,
            label: AppStrings.instance.totalPower,
            value: data?.totalPower ?? 0.0,
            unit: data?.unit ?? 'kw',
          );
        }),
        SizedBox(height: AppSize.height(value: 10)),

        Obx(
          () => CustomToggleButton(
            isSourceSelected: controller.isSourceSelected.value,
            onToggle: controller.toggleSourceLoad,
          ),
        ),
      ],
    );
  }
}
