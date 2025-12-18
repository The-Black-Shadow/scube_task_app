import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scube_task_app/constant/app_colors.dart';

import 'package:scube_task_app/utils/app_size.dart';

class RevenueInfoItem extends StatelessWidget {
  final Map<String, String> item;
  final int index;

  const RevenueInfoItem({super.key, required this.item, required this.index});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: AppSize.height(value: 16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildRow(label: '${item['title']} : ', value: item['data'] ?? ''),
          SizedBox(height: AppSize.height(value: 4)),
          _buildRow(
            label: 'Cost ${index + 1} : ',
            value: item['cost'] ?? '',
            isCost: true,
          ),
        ],
      ),
    );
  }

  Widget _buildRow({
    required String label,
    required String value,
    bool isCost = false,
  }) {
    return RichText(
      text: TextSpan(
        style: GoogleFonts.inter(
          fontSize: AppSize.width(value: 12),
          color: AppColors.instance.textGrey,
          fontWeight: FontWeight.w400,
        ),
        children: [
          TextSpan(text: label),
          TextSpan(
            text: value,
            style: GoogleFonts.inter(
              fontSize: AppSize.width(value: 12),
              color: AppColors.instance.textDarkBlue,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
