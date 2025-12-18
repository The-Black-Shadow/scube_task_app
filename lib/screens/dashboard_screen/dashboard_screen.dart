import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scube_task_app/constant/app_assert_image.dart';
import 'package:scube_task_app/constant/app_colors.dart';
import 'package:scube_task_app/constant/app_strings.dart';
import 'package:scube_task_app/constant/app_text_styles.dart';
import 'package:scube_task_app/routes/app_routes.dart';
import 'package:scube_task_app/screens/dashboard_screen/dashboard_controller.dart';
import 'package:scube_task_app/utils/app_size.dart';
import 'package:scube_task_app/widgets/custom_toggle_button.dart';
import 'package:scube_task_app/widgets/dashboard_grid_item.dart';
import 'package:scube_task_app/widgets/dashboard_header.dart';
import 'package:scube_task_app/widgets/dashboard_list_card.dart';
import 'package:scube_task_app/widgets/power_circular_chart.dart';
import 'package:scube_task_app/widgets/skeleton_widget.dart';

class DashboardScreen extends GetView<DashboardController> {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => DashboardController());

    return Scaffold(
      backgroundColor: AppColors.instance.backgroundColor,
      body: Column(
        children: [
          DashboardHeader(title: AppStrings.instance.scmTitle),
          SizedBox(height: AppSize.height(value: 15)),

          Expanded(
            child: RefreshIndicator(
              onRefresh: controller.fetchData,
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppSize.width(value: 20),
                  ),
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: AppColors.instance.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 10,
                              spreadRadius: 2,
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.all(AppSize.width(value: 12)),
                              child: Column(
                                children: [
                                  _buildTabBar(),
                                  SizedBox(height: AppSize.height(value: 10)),

                                  Text(
                                    AppStrings.instance.electricitySection,
                                    style: AppTextStyles
                                        .instance
                                        .dashboardDataLabel
                                        .copyWith(
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
                                        borderRadius: BorderRadius.circular(
                                          AppSize.width(value: 75),
                                        ),
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
                                      isSourceSelected:
                                          controller.isSourceSelected.value,
                                      onToggle: controller.toggleSourceLoad,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: AppSize.width(value: 12),
                              ),
                              child: Divider(
                                color: AppColors.instance.borderGrey,
                                height: 1,
                              ),
                            ),

                            Obx(() {
                              if (controller.isLoading.value) {
                                return Padding(
                                  padding: EdgeInsets.all(
                                    AppSize.width(value: 12),
                                  ),
                                  child: Column(
                                    children: List.generate(
                                      3,
                                      (index) => Padding(
                                        padding: EdgeInsets.only(
                                          bottom: AppSize.height(value: 10),
                                        ),
                                        child: SkeletonWidget(
                                          width: double.infinity,
                                          height: AppSize.height(value: 70),
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }
                              final list =
                                  controller.dashboardData.value?.dataList ??
                                  [];
                              return SizedBox(
                                height: AppSize.height(value: 300),
                                child: ListView.separated(
                                  padding: EdgeInsets.all(
                                    AppSize.width(value: 12),
                                  ),
                                  itemCount: list.length,
                                  separatorBuilder: (_, __) => SizedBox(
                                    height: AppSize.height(value: 4),
                                  ),
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                      onTap: () => Get.toNamed(
                                        AppRoutes
                                            .instance
                                            .listItemDetailsScreen,
                                      ),
                                      child: DashboardExpandedList(
                                        item: list[index],
                                      ),
                                    );
                                  },
                                ),
                              );
                            }),
                          ],
                        ),
                      ),
                      SizedBox(height: AppSize.height(value: 24)),

                      _buildBottomGrid(),
                      SizedBox(height: AppSize.height(value: 30)),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabBar() {
    return Container(
      height: AppSize.height(value: 40),
      decoration: BoxDecoration(
        color: AppColors.instance.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
        border: Border.all(color: AppColors.instance.borderGrey),
      ),
      child: Obx(
        () => Row(
          children: [
            _buildTabItem(AppStrings.instance.tabSummary, 0),
            _buildTabItem(AppStrings.instance.tabSld, 1),
            _buildTabItem(AppStrings.instance.tabData, 2),
          ],
        ),
      ),
    );
  }

  Widget _buildTabItem(String label, int index) {
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
              fontWeight: FontWeight.w400,
              color: isSelected
                  ? AppColors.instance.white
                  : AppColors.instance.textTab,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBottomGrid() {
    return GridView.count(
      crossAxisCount: 2,
      childAspectRatio: 3.0,
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
