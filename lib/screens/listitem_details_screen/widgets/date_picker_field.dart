import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:scube_task_app/constant/app_colors.dart';

class DatePickerField extends StatelessWidget {
  final String hint;
  final DateTime? date;
  final VoidCallback onTap;

  const DatePickerField({
    super.key,
    required this.hint,
    required this.date,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          border: Border.all(
            color: AppColors.instance.textGrey.withValues(alpha: 0.5),
          ),
          borderRadius: BorderRadius.circular(8),
          color: AppColors.instance.white,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              date != null ? DateFormat('dd/MM/yyyy').format(date!) : hint,
              style: TextStyle(
                color: date != null
                    ? const Color(0xFF1E2843)
                    : AppColors.instance.textGrey,
                fontSize: 13,
                fontWeight: date != null ? FontWeight.w600 : FontWeight.normal,
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
}
