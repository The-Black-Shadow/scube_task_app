import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scube_task_app/constant/app_colors.dart';
import 'package:scube_task_app/utils/app_size.dart';
import 'package:scube_task_app/screens/listitem_details_screen/widgets/detail_list_item.dart';

class EnergyChartCard extends StatelessWidget {
  final String title;
  final String value;
  final List<Map<String, String>> items;

  const EnergyChartCard({
    super.key,
    required this.title,
    required this.value,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
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
          ...items.asMap().entries.map(
            (e) => DetailListItem(item: e.value, index: e.key),
          ),
        ],
      ),
    );
  }
}
