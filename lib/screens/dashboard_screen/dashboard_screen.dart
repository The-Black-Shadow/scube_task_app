import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scube_task_app/constant/app_colors.dart';
import 'package:scube_task_app/constant/app_strings.dart';
import 'package:scube_task_app/screens/dashboard_screen/dashboard_controller.dart';
import 'package:scube_task_app/utils/app_size.dart';
import 'package:scube_task_app/widgets/dashboard_header.dart';
import 'package:scube_task_app/screens/dashboard_screen/widgets/dashboard_tab_bar.dart';
import 'package:scube_task_app/screens/dashboard_screen/widgets/dashboard_electricity_section.dart';
import 'package:scube_task_app/screens/dashboard_screen/widgets/dashboard_list_section.dart';
import 'package:scube_task_app/screens/dashboard_screen/widgets/dashboard_bottom_grid.dart';

class DashboardScreen extends GetView<DashboardController> {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                              color: Colors.black.withValues(alpha: 0.05),
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
                                  const DashboardTabBar(),
                                  SizedBox(height: AppSize.height(value: 10)),
                                  const DashboardElectricitySection(),
                                ],
                              ),
                            ),
                            const DashboardListSection(),
                          ],
                        ),
                      ),

                      const DashboardBottomGrid(),
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
}
