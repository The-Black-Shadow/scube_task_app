import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scube_task_app/constant/app_assert_image.dart';
import 'package:scube_task_app/constant/app_colors.dart';
import 'package:scube_task_app/constant/app_strings.dart';
import 'package:scube_task_app/constant/app_text_styles.dart';
import 'package:scube_task_app/screens/dashboard_screen/dashboard_controller.dart';
import 'package:scube_task_app/utils/app_size.dart';
import 'package:scube_task_app/widgets/custom_toggle_button.dart';
import 'package:scube_task_app/widgets/dashboard_grid_item.dart';
import 'package:scube_task_app/widgets/dashboard_header.dart';
import 'package:scube_task_app/widgets/dashboard_list_card.dart';
import 'package:scube_task_app/widgets/power_circular_chart.dart';

class DashboardScreen extends GetView<DashboardController> {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Inject controller if not already
    Get.lazyPut(() => DashboardController());

    return Scaffold(
      backgroundColor: AppColors.instance.backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            DashboardHeader(title: AppStrings.instance.scmTitle),
            SizedBox(height: AppSize.height(value: 15)),
            // Body
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
                                padding: EdgeInsets.all(
                                  AppSize.width(value: 12),
                                ),
                                child: Column(
                                  children: [
                                    // Custom Tab Bar (Summary, SLD, Data)
                                    _buildTabBar(),
                                    SizedBox(height: AppSize.height(value: 10)),
                                    // Section Title
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
                                    Divider(
                                      color: AppColors.instance.borderGrey,
                                    ),
                                    SizedBox(height: AppSize.height(value: 8)),
                                    // Circular Chart
                                    Obx(() {
                                      if (controller.isLoading.value) {
                                        return const CircularProgressIndicator();
                                      }
                                      final data =
                                          controller.dashboardData.value;
                                      return PowerCircularChart(
                                        value: data?.totalPower ?? 0.0,
                                        unit: data?.unit ?? 'kw',
                                      );
                                    }),
                                    SizedBox(height: AppSize.height(value: 10)),
                                    // Toggle Button
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

                              // Separator
                              Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: AppSize.width(value: 12),
                                ),
                                child: Divider(
                                  color: AppColors.instance.borderGrey,
                                  height: 1,
                                ),
                              ),

                              // Scrollable List Items
                              Obx(() {
                                if (controller.isLoading.value) {
                                  return const SizedBox.shrink();
                                }
                                final list =
                                    controller.dashboardData.value?.dataList ??
                                    [];
                                return SizedBox(
                                  height: AppSize.height(
                                    value: 300,
                                  ), // Fixed height for scrolling
                                  child: ListView.separated(
                                    padding: EdgeInsets.all(
                                      AppSize.width(value: 12),
                                    ),
                                    itemCount: list.length,
                                    separatorBuilder: (_, __) => SizedBox(
                                      height: AppSize.height(value: 4),
                                    ),
                                    itemBuilder: (context, index) {
                                      return DashboardExpandedList(
                                        item: list[index],
                                      );
                                    },
                                  ),
                                );
                              }),
                            ],
                          ),
                        ),
                        SizedBox(height: AppSize.height(value: 24)),
                        // Bottom Grid Menu
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
          onTap: () {},
        ),
        DashboardGridItem(
          iconPath: AppAssertImage.instance.gGenerator,
          label: AppStrings.instance.gGenerator,
          onTap: () {},
        ),
        DashboardGridItem(
          iconPath: AppAssertImage.instance.plantSummary,
          label: AppStrings.instance.plantSummary,
          onTap: () {},
        ),
        DashboardGridItem(
          iconPath: AppAssertImage.instance.naturalGas,
          label: AppStrings.instance.naturalGas,
          onTap: () {},
        ),
        DashboardGridItem(
          iconPath: AppAssertImage.instance.dGenerator,
          label: AppStrings.instance.dGenerator,
          onTap: () {},
        ),
        DashboardGridItem(
          iconPath: AppAssertImage.instance.waterProcess,
          label: AppStrings.instance.waterProcess,
          onTap: () {},
        ),
      ],
    );
  }
}
