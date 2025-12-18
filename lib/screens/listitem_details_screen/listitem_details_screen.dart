import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:scube_task_app/constant/app_assert_image.dart';
import 'package:scube_task_app/constant/app_colors.dart';
import 'package:scube_task_app/constant/app_strings.dart';

import 'package:scube_task_app/screens/listitem_details_screen/listitem_details_controller.dart';
import 'package:scube_task_app/utils/app_size.dart';
import 'package:scube_task_app/widgets/custom_radio_button.dart';
import 'package:scube_task_app/widgets/dashboard_header.dart';
import 'package:scube_task_app/widgets/power_circular_chart.dart';
import 'package:scube_task_app/widgets/skeleton_widget.dart';

class ListItemDetailsScreen extends GetView<ListItemDetailsController> {
  const ListItemDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ListItemDetailsController());

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
                        color: Colors.black.withOpacity(0.05),
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
                                    : 'tk',
                                label: '',
                                max: 100,
                                startAngle: isDataView ? 135 : 0,
                                sweepAngle: isDataView ? 270 : 360,
                                trackColor: AppColors.instance.chartBlue
                                    .withOpacity(0.1),
                                precision: isDataView ? 2 : 0,
                              );
                            }),
                            SizedBox(height: AppSize.height(value: 24)),

                            Obx(
                              () => controller.isLoading.value
                                  ? _buildListSkeleton()
                                  : (controller.viewType.value == 0
                                        ? _buildDataView(context)
                                        : _buildRevenueView(context)),
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
                            color: Colors.black.withOpacity(0.05),
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

  Widget _buildDataView(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Obx(
              () => CustomRadioButton(
                label: AppStrings.instance.todayData,
                isSelected: controller.dateType.value == 0,
                onTap: () => controller.setDateType(0),
              ),
            ),
            SizedBox(width: AppSize.width(value: 20)),
            Obx(
              () => CustomRadioButton(
                label: AppStrings.instance.customDateData,
                isSelected: controller.dateType.value == 1,
                onTap: () => controller.setDateType(1),
              ),
            ),
          ],
        ),
        SizedBox(height: AppSize.height(value: 20)),

        Obx(() {
          if (controller.dateType.value == 1) {
            return Padding(
              padding: EdgeInsets.only(bottom: AppSize.height(value: 20)),
              child: Row(
                children: [
                  Expanded(
                    child: _buildDatePicker(
                      context,
                      AppStrings.instance.fromDate,
                      controller.fromDate.value,
                      onTap: () async {
                        final date = await showDatePicker(
                          context: context,
                          initialDate: controller.fromDate.value,
                          firstDate: DateTime(2000),
                          lastDate:
                              controller.toDate.value, // Constrain to End Date
                        );
                        if (date != null) {
                          controller.setFromDate(date);
                        }
                      },
                    ),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: _buildDatePicker(
                      context,
                      AppStrings.instance.toDate,
                      controller.toDate.value,
                      onTap: () async {
                        final date = await showDatePicker(
                          context: context,
                          initialDate: controller.toDate.value,
                          firstDate: controller
                              .fromDate
                              .value, // Constrain to Start Date
                          lastDate: DateTime.now(),
                        );
                        if (date != null) {
                          controller.setToDate(date);
                        }
                      },
                    ),
                  ),
                  SizedBox(width: 8),
                  Container(
                    padding: EdgeInsets.all(AppSize.width(value: 8)),
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.instance.primaryBlue),
                      borderRadius: BorderRadius.circular(8),
                      color: AppColors.instance.primaryBlue.withOpacity(0.1),
                    ),
                    child: Icon(
                      Icons.search,
                      color: AppColors.instance.primaryBlue,
                    ),
                  ),
                ],
              ),
            );
          }
          return const SizedBox.shrink();
        }),

        _buildEnergyChartCard(
          AppStrings.instance.energyChart,
          '20.05 ${AppStrings.instance.kw}',
          controller.dataItems,
        ),
        Obx(() {
          if (controller.dateType.value == 1) {
            return Column(
              children: [
                SizedBox(height: AppSize.height(value: 20)),
                _buildEnergyChartCard(
                  AppStrings.instance.energyChart,
                  '5.53 ${AppStrings.instance.kw}',
                  controller.dataItems,
                ),
              ],
            );
          }
          return const SizedBox.shrink();
        }),
      ],
    );
  }

  Widget _buildRevenueView(BuildContext context) {
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
                            .map((item) => _buildListItem(item, null))
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

  Widget _buildDatePicker(
    BuildContext context,
    String hint,
    DateTime date, {
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          border: Border.all(
            color: AppColors.instance.textGrey.withOpacity(0.5),
          ),
          borderRadius: BorderRadius.circular(8),
          color: AppColors.instance.white,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              DateFormat('dd/MM/yyyy').format(date),
              style: TextStyle(
                color: AppColors.instance.textGrey,
                fontSize: 13,
              ),
            ),
            Icon(
              Icons.calendar_today_outlined,
              size: 16,
              color: AppColors.instance.textGrey,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEnergyChartCard(
    String title,
    String value,
    List<Map<String, String>> items,
  ) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(AppSize.width(value: 12)),
      decoration: BoxDecoration(
        color: AppColors.instance.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.instance.borderGrey),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: GoogleFonts.inter(
                  fontSize: AppSize.width(value: 16),
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF1E2843),
                ),
              ),
              Text(
                value,
                style: GoogleFonts.inter(
                  fontSize: AppSize.width(value: 28),
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF1E2843),
                ),
              ),
            ],
          ),
          SizedBox(height: AppSize.height(value: 16)),
          ...items.map((item) => _buildListItem(item, null)),
        ],
      ),
    );
  }

  Widget _buildListItem(Map<String, String> item, Color? dotColor) {
    final colors = [
      Colors.blue,
      Colors.lightBlue,
      Colors.purple,
      Colors.orange,
    ];

    Color? parsedColor;
    if (item['color'] != null && item['color']!.isNotEmpty) {
      switch (item['color']!.toLowerCase()) {
        case 'blue':
          parsedColor = AppColors.instance.activeBlue;
          break;
        case 'orange':
          parsedColor = AppColors.instance.statusOrange;
          break;
        case 'red':
          parsedColor = AppColors.instance.inactiveRed;
          break;
        default:
          parsedColor = null;
      }
    }

    final color =
        dotColor ??
        parsedColor ??
        colors[controller.dataItems.indexOf(item) % colors.length];

    return Container(
      margin: EdgeInsets.only(bottom: 8),
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: AppColors.instance.borderGrey.withOpacity(0.6),
        ),
      ),
      child: Row(
        children: [
          SizedBox(
            width: AppSize.width(value: 80),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                      color: color,
                      shape: BoxShape.circle,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    item['title'] ?? '',
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                      color: const Color(0xFF1E2843),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            height: 35,
            width: 1,
            color: AppColors.instance.borderGrey.withOpacity(0.6),
            margin: EdgeInsets.symmetric(horizontal: 8),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    SizedBox(
                      width: 50,
                      child: Text(
                        AppStrings.instance.dataLabel,
                        style: TextStyle(
                          color: AppColors.instance.textGrey,
                          fontSize: 13,
                        ),
                      ),
                    ),
                    Text(
                      ' : ${item['data']}',
                      style: GoogleFonts.inter(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF1E2843),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 4),
                Row(
                  children: [
                    SizedBox(
                      width: 50,
                      child: Text(
                        AppStrings.instance.costLabel,
                        style: TextStyle(
                          color: AppColors.instance.textGrey,
                          fontSize: 13,
                        ),
                      ),
                    ),
                    Text(
                      ' : ${item['cost']}',
                      style: GoogleFonts.inter(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF1E2843),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildListSkeleton() {
    return Column(
      children: [
        SkeletonWidget(
          width: double.infinity,
          height: AppSize.height(value: 50),
          borderRadius: BorderRadius.circular(12),
        ),
        SizedBox(height: AppSize.height(value: 12)),

        ...List.generate(
          4,
          (index) => Padding(
            padding: EdgeInsets.symmetric(
              vertical: 8.0,
              horizontal: AppSize.width(value: 12),
            ),
            child: SkeletonWidget(
              width: double.infinity,
              height: AppSize.height(value: 70), // Reduced size
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ],
    );
  }
}
