import 'package:flutter/material.dart';
import 'package:scube_task_app/constant/app_assert_image.dart';
import 'package:scube_task_app/constant/app_colors.dart';
import 'package:scube_task_app/constant/app_strings.dart';
import 'package:scube_task_app/constant/app_text_styles.dart';
import 'package:scube_task_app/utils/app_size.dart';
import 'package:scube_task_app/widgets/dashboard_header.dart';

class GridDetailsScreen extends StatelessWidget {
  const GridDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.instance.backgroundColor,
      body: Column(
        children: [
          // Reusing DashboardHeader
          DashboardHeader(title: AppStrings.instance.scmTitle),
          SizedBox(height: AppSize.height(value: 20)),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: AppSize.width(value: 20),
              ),
              child: Container(
                width: double.infinity,
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      AppAssertImage.instance.noData,
                      width: AppSize.width(value: 259),
                      height: AppSize.width(value: 193),
                    ),
                    SizedBox(height: AppSize.height(value: 10)),
                    Text(
                      AppStrings.instance.noDataMessage,
                      textAlign: TextAlign.center,
                      style: AppTextStyles.instance.dashboardDataLabel.copyWith(
                        fontWeight: FontWeight.w400,
                        fontSize: AppSize.width(value: 14),
                        color: AppColors.instance.textGrey,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: AppSize.height(value: 30)),
        ],
      ),
    );
  }
}
