import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scube_task_app/constant/app_assert_image.dart';
import 'package:scube_task_app/constant/app_strings.dart';
import 'package:scube_task_app/routes/app_routes.dart';
import 'package:scube_task_app/utils/app_size.dart';
import 'package:scube_task_app/widgets/dashboard_grid_item.dart';

class DashboardBottomGrid extends StatelessWidget {
  const DashboardBottomGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      childAspectRatio: 4.0,
      crossAxisSpacing: AppSize.width(value: 12),
      mainAxisSpacing: AppSize.height(value: 8),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        DashboardGridItem(
          iconPath: AppAssertImage.instance.analysisPro,
          label: AppStrings.instance.analysisPro,
          onTap: () => Get.toNamed(AppRoutes.instance.gridDetailsScreen),
        ),
        DashboardGridItem(
          iconPath: AppAssertImage.instance.gGenerator,
          label: AppStrings.instance.gGenerator,
          onTap: () => Get.toNamed(AppRoutes.instance.gridDetailsScreen),
        ),
        DashboardGridItem(
          iconPath: AppAssertImage.instance.charge,
          label: AppStrings.instance.plantSummary,
          onTap: () => Get.toNamed(AppRoutes.instance.gridDetailsScreen),
        ),
        DashboardGridItem(
          iconPath: AppAssertImage.instance.naturalGas,
          label: AppStrings.instance.naturalGas,
          onTap: () => Get.toNamed(AppRoutes.instance.gridDetailsScreen),
        ),
        DashboardGridItem(
          iconPath: AppAssertImage.instance.dGenerator,
          label: AppStrings.instance.dGenerator,
          onTap: () => Get.toNamed(AppRoutes.instance.gridDetailsScreen),
        ),
        DashboardGridItem(
          iconPath: AppAssertImage.instance.waterProcess,
          label: AppStrings.instance.waterProcess,
          onTap: () => Get.toNamed(AppRoutes.instance.gridDetailsScreen),
        ),
      ],
    );
  }
}
