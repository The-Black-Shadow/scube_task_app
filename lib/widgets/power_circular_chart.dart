import 'package:flutter/material.dart';
import 'package:scube_task_app/constant/app_colors.dart';
import 'package:scube_task_app/constant/app_strings.dart';
import 'package:scube_task_app/constant/app_text_styles.dart';
import 'package:scube_task_app/utils/app_size.dart';

class PowerCircularChart extends StatelessWidget {
  final double value;
  final String unit;

  const PowerCircularChart({
    super.key,
    required this.value,
    required this.unit,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: AppSize.width(value: 180),
      height: AppSize.width(value: 180),
      // Use CustomPaint for drawing the circular chart or simple Stack with CircularProgressIndicator
      // Here using a simple Stack with a thick CircularProgressIndicator for simplicity as per requirement
      // to "look exactly like image" which is a single color ring.
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Background Circle used for border/shadow if needed - using simple white container behind
          Container(
            width: AppSize.width(value: 160),
            height: AppSize.width(value: 160),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.instance.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  spreadRadius: 2,
                ),
              ],
            ),
          ),
          // The Blue Ring
          SizedBox(
            width: AppSize.width(value: 140),
            height: AppSize.width(value: 140),
            child: CircularProgressIndicator(
              value: 1.0, // Full circle
              strokeWidth: AppSize.width(value: 20),
              valueColor: AlwaysStoppedAnimation<Color>(
                AppColors.instance.chartBlue,
              ),
            ),
          ),
          // Center Text
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                AppStrings.instance.totalPower,
                style: AppTextStyles.instance.dashboardDataLabel,
              ),
              SizedBox(height: 4),
              Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Text("$value", style: AppTextStyles.instance.powerValue),
                  SizedBox(width: 2),
                  Text(unit, style: AppTextStyles.instance.powerUnit),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
