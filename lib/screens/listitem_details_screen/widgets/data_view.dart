import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scube_task_app/constant/app_colors.dart';
import 'package:scube_task_app/constant/app_strings.dart';
import 'package:scube_task_app/screens/listitem_details_screen/listitem_details_controller.dart';
import 'package:scube_task_app/utils/app_size.dart';
import 'package:scube_task_app/widgets/custom_radio_button.dart';
import 'package:scube_task_app/screens/listitem_details_screen/widgets/date_picker_field.dart';
import 'package:scube_task_app/screens/listitem_details_screen/widgets/energy_chart_card.dart';

class DataView extends GetView<ListItemDetailsController> {
  const DataView({super.key});

  @override
  Widget build(BuildContext context) {
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
                    child: DatePickerField(
                      hint: AppStrings.instance.fromDate,
                      date: controller.fromDate.value,
                      onTap: () async {
                        final date = await showDatePicker(
                          context: context,
                          initialDate:
                              controller.fromDate.value ?? DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: controller.toDate.value ?? DateTime.now(),
                        );
                        if (date != null) {
                          controller.setFromDate(date);
                        }
                      },
                    ),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: DatePickerField(
                      hint: AppStrings.instance.toDate,
                      date: controller.toDate.value,
                      onTap: () async {
                        final date = await showDatePicker(
                          context: context,
                          initialDate:
                              controller.toDate.value ?? DateTime.now(),
                          firstDate:
                              controller.fromDate.value ?? DateTime(2000),
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
        EnergyChartCard(
          title: AppStrings.instance.energyChart,
          value: '20.05 ${AppStrings.instance.kw}',
          items: controller.dataItems,
        ),
        Obx(() {
          if (controller.dateType.value == 1) {
            return Column(
              children: [
                SizedBox(height: AppSize.height(value: 20)),
                EnergyChartCard(
                  title: AppStrings.instance.energyChart,
                  value: '5.53 ${AppStrings.instance.kw}',
                  items: controller.dataItems,
                ),
              ],
            );
          }
          return const SizedBox.shrink();
        }),
      ],
    );
  }
}
