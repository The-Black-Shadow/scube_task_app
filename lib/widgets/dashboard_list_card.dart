import 'package:flutter/material.dart';
import 'package:scube_task_app/constant/app_assert_image.dart';
import 'package:scube_task_app/constant/app_colors.dart';
import 'package:scube_task_app/constant/app_text_styles.dart';
import 'package:scube_task_app/models/dashboard_model.dart';
import 'package:scube_task_app/utils/app_size.dart';

class DashboardExpandedList extends StatelessWidget {
  final DashboardItemModel item;

  const DashboardExpandedList({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    Color statusDotColor;
    final colorKey = item.statusColor?.toLowerCase() ?? '';

    switch (colorKey) {
      case 'blue':
        statusDotColor = AppColors.instance.activeBlue;
        break;
      case 'orange':
        statusDotColor = AppColors.instance.statusOrange;
        break;
      case 'red':
        statusDotColor = AppColors.instance.inactiveRed;
        break;
      default:
        statusDotColor = AppColors.instance.inactiveRed;
    }

    Color statusTextColor;
    if (item.status == 'Active') {
      statusTextColor = AppColors.instance.activeBlue;
    } else {
      statusTextColor = AppColors.instance.inactiveRed;
    }

    return Container(
      margin: EdgeInsets.only(bottom: AppSize.height(value: 2)),
      decoration: BoxDecoration(
        color: AppColors.instance.listBackground, // Default white bg
        borderRadius: BorderRadius.circular(AppSize.width(value: 8)),
        border: Border.all(color: AppColors.instance.borderGrey),
      ),
      child: Column(
        children: [
          // Header
          Padding(
            padding: EdgeInsets.all(AppSize.width(value: 12)),
            child: Row(
              children: [
                Image.asset(
                  _getIconPath(item.icon),
                  width: AppSize.width(value: 32),
                  height: AppSize.width(value: 32),
                ),
                SizedBox(width: AppSize.width(value: 12)),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 12,
                            height: 12,
                            decoration: BoxDecoration(
                              color: statusDotColor,
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                          SizedBox(width: 8),
                          Text(
                            item.title ?? '',
                            style: AppTextStyles.instance.dashboardCardTitle,
                          ),
                          SizedBox(width: 8),
                          Text(
                            "(${item.status})",
                            style: AppTextStyles.instance.dashboardDataLabel
                                .copyWith(
                                  fontWeight: FontWeight.w500,
                                  color: statusTextColor,
                                  fontSize: AppSize.width(value: 10),
                                ),
                          ),
                        ],
                      ),
                      SizedBox(height: AppSize.height(value: 4)),
                      // Data Row 1
                      Row(
                        children: [
                          SizedBox(
                            width: AppSize.width(value: 75),
                            child: Text(
                              item.data1Label ?? '',
                              style: AppTextStyles.instance.dashboardDataLabel,
                            ),
                          ),
                          Text(
                            ': ',
                            style: AppTextStyles.instance.dashboardDataLabel,
                          ),
                          Text(
                            item.data1Value ?? '',
                            style: AppTextStyles.instance.dashboardDataValue,
                          ),
                        ],
                      ),
                      // Data Row 2
                      Row(
                        children: [
                          SizedBox(
                            width: AppSize.width(value: 75),
                            child: Text(
                              item.data2Label ?? '',
                              style: AppTextStyles.instance.dashboardDataLabel,
                            ),
                          ),
                          Text(
                            ': ',
                            style: AppTextStyles.instance.dashboardDataLabel,
                          ),
                          Text(
                            item.data2Value ?? '',
                            style: AppTextStyles.instance.dashboardDataValue,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  size: AppSize.width(value: 18),
                  color: AppColors.instance.textGrey,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _getIconPath(String? iconName) {
    if (iconName == null) return AppAssertImage.instance.noData;
    // Basic mapping, in real app might be direct path
    return "assets/$iconName";
  }
}
