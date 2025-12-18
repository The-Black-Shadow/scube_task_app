import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scube_task_app/constant/app_colors.dart';
import 'package:scube_task_app/constant/app_strings.dart';
import 'package:scube_task_app/screens/listitem_details_screen/listitem_details_controller.dart';
import 'package:scube_task_app/utils/app_size.dart';
import 'package:scube_task_app/widgets/custom_radio_button.dart';
import 'package:scube_task_app/widgets/dashboard_header.dart';
import 'package:scube_task_app/widgets/power_circular_chart.dart';
import 'package:scube_task_app/widgets/skeleton_widget.dart';
import 'package:scube_task_app/screens/listitem_details_screen/widgets/data_view.dart';
import 'package:scube_task_app/screens/listitem_details_screen/widgets/revenue_view.dart';
import 'package:scube_task_app/screens/listitem_details_screen/widgets/list_view_skeleton.dart';

class ListItemDetailsScreen extends GetView<ListItemDetailsController> {
  const ListItemDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.instance.backgroundColor,
      body: Column(
        children: [
          DashboardHeader(title: AppStrings.instance.scmTitle),
          SizedBox(height: AppSize.height(value: 20)),
          Expanded(
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  margin: EdgeInsets.only(top: AppSize.height(value: 25)),
                  decoration: BoxDecoration(
                    color: AppColors.instance.white,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.05),
                        blurRadius: 10,
                        offset: const Offset(0, -5),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                    child: RefreshIndicator(
                      onRefresh: controller.fetchData,
                      child: SingleChildScrollView(
                        physics: const AlwaysScrollableScrollPhysics(),
                        padding: EdgeInsets.all(AppSize.width(value: 20)),
                        child: Column(
                          children: [
                            SizedBox(height: AppSize.height(value: 35)),
                            Obx(() {
                              if (controller.isLoading.value) {
                                return SkeletonWidget(
                                  width: AppSize.width(value: 150),
                                  height: AppSize.width(value: 150),
                                  borderRadius: BorderRadius.circular(
                                    AppSize.width(value: 75),
                                  ),
                                );
                              }

                              final isDataView = controller.viewType.value == 0;
                              return PowerCircularChart(
                                value: isDataView ? 55.00 : 8897455,
                                unit: isDataView
                                    ? AppStrings.instance.kwhSqft
                                    : AppStrings.instance.tk,
                                label: '',
                                max: 100,
                                startAngle: isDataView ? 135 : 0,
                                sweepAngle: isDataView ? 270 : 360,
                                trackColor: AppColors.instance.chartBlue
                                    .withValues(alpha: 0.1),
                                precision: isDataView ? 2 : 0,
                                strokeWidth: AppSize.width(value: 12),
                                color: AppColors.instance.primaryBlue,
                                unitOnNewLine: true,
                              );
                            }),
                            SizedBox(height: AppSize.height(value: 24)),

                            Obx(
                              () => controller.isLoading.value
                                  ? const ListViewSkeleton()
                                  : (controller.viewType.value == 0
                                        ? const DataView()
                                        : const RevenueView()),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.9,
                      padding: EdgeInsets.symmetric(
                        vertical: AppSize.height(value: 12),
                        horizontal: AppSize.width(value: 16),
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.instance.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: AppColors.instance.borderGrey,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.05),
                            blurRadius: 5,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Obx(
                        () => Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            CustomRadioButton(
                              label: AppStrings.instance.dataView,
                              isSelected: controller.viewType.value == 0,
                              onTap: () => controller.setViewType(0),
                            ),
                            CustomRadioButton(
                              label: AppStrings.instance.revenueView,
                              isSelected: controller.viewType.value == 1,
                              onTap: () => controller.setViewType(1),
                            ),
                          ],
                        ),
                      ),
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
