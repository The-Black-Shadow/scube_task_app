import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scube_task_app/constant/app_colors.dart';
import 'package:scube_task_app/routes/app_routes.dart';
import 'package:scube_task_app/screens/dashboard_screen/dashboard_controller.dart';
import 'package:scube_task_app/utils/app_size.dart';
import 'package:scube_task_app/widgets/dashboard_list_card.dart';
import 'package:scube_task_app/widgets/skeleton_widget.dart';

class DashboardListSection extends GetView<DashboardController> {
  const DashboardListSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: AppSize.width(value: 12)),
          child: Divider(color: AppColors.instance.borderGrey, height: 1),
        ),

        Obx(() {
          if (controller.isLoading.value) {
            return Padding(
              padding: EdgeInsets.all(AppSize.width(value: 12)),
              child: Column(
                children: List.generate(
                  3,
                  (index) => Padding(
                    padding: EdgeInsets.only(bottom: AppSize.height(value: 10)),
                    child: SkeletonWidget(
                      width: double.infinity,
                      height: AppSize.height(value: 70),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
            );
          }
          final list = controller.dashboardData.value?.dataList ?? [];
          return SizedBox(
            height: AppSize.height(value: 300),
            child: ListView.separated(
              padding: EdgeInsets.all(AppSize.width(value: 12)),
              itemCount: list.length,
              separatorBuilder: (_, __) =>
                  SizedBox(height: AppSize.height(value: 4)),
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () =>
                      Get.toNamed(AppRoutes.instance.listItemDetailsScreen),
                  child: DashboardExpandedList(item: list[index]),
                );
              },
            ),
          );
        }),
      ],
    );
  }
}
