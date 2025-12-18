import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:scube_task_app/constant/app_colors.dart';
import 'package:scube_task_app/constant/app_strings.dart';

import 'package:scube_task_app/screens/listitem_details_screen/listitem_details_controller.dart';
import 'package:scube_task_app/utils/app_size.dart';
import 'package:scube_task_app/widgets/custom_radio_button.dart';
import 'package:scube_task_app/widgets/dashboard_header.dart';
import 'package:scube_task_app/widgets/power_circular_chart.dart';

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
          DashboardHeader(title: AppStrings.instance.scmTitle),
          Expanded(
            child: RefreshIndicator(
              onRefresh: controller.fetchData,
              child: SingleChildScrollView(
                physics:
                    const AlwaysScrollableScrollPhysics(), // Ensure scroll even if content is short
                padding: EdgeInsets.all(AppSize.width(value: 20)),
                child: Column(
                  children: [
                    // Top View Toggle
                    Container(
                      width: double.infinity,
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
                    SizedBox(height: AppSize.height(value: 24)),

                    // Circular Chart
                    Obx(() {
                      final isDataView = controller.viewType.value == 0;
                      return PowerCircularChart(
                        value: isDataView ? 55.00 : 8897455,
                        unit: isDataView ? AppStrings.instance.kwhSqft : 'tk',
                        label: '',
                        max:
                            100, // Assuming 100 is max for percentage or similar scaling
                        startAngle: isDataView ? 135 : 0,
                        sweepAngle: isDataView ? 270 : 360,
                        trackColor: AppColors.instance.chartBlue.withOpacity(
                          0.1,
                        ),
                        precision: isDataView ? 2 : 0,
                      );
                    }),
                    SizedBox(height: AppSize.height(value: 24)),

                    Obx(
                      () => controller.viewType.value == 0
                          ? _buildDataView(context)
                          : _buildRevenueView(context),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDataView(BuildContext context) {
    return Column(
      children: [
        // Date Toggle
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
                    ),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: _buildDatePicker(
                      context,
                      AppStrings.instance.toDate,
                      controller.toDate.value,
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

        // Data Card
        Container(
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
                    AppStrings.instance.energyChart,
                    style: GoogleFonts.inter(
                      fontSize: AppSize.width(value: 16),
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF1E2843),
                    ),
                  ),
                  Text(
                    '5.53 ${AppStrings.instance.kw}',
                    style: GoogleFonts.inter(
                      fontSize: AppSize.width(value: 28),
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF1E2843),
                    ),
                  ),
                ],
              ),
              SizedBox(height: AppSize.height(value: 16)),
              ...controller.dataItems.map(
                (item) => _buildListItem(item, Colors.blue),
              ),
            ],
          ),
        ),
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
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.instance.primaryBlue,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.keyboard_arrow_up,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ],
            ),
          ),
          Divider(color: AppColors.instance.borderGrey, height: 1),
          Padding(
            padding: EdgeInsets.all(AppSize.width(value: 12)),
            child: Column(
              children: controller.revenueItems
                  .map((item) => _buildListItem(item, null))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDatePicker(BuildContext context, String hint, DateTime date) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.instance.textGrey.withOpacity(0.5)),
        borderRadius: BorderRadius.circular(8),
        color: AppColors.instance.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            hint,
            style: TextStyle(color: AppColors.instance.textGrey, fontSize: 13),
          ),
          Icon(
            Icons.calendar_today_outlined,
            size: 16,
            color: AppColors.instance.textGrey,
          ),
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
    final color =
        dotColor ?? colors[controller.dataItems.indexOf(item) % colors.length];

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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                    color: const Color(0xFF1E2843),
                  ),
                ),
              ],
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
}
