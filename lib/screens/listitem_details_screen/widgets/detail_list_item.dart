import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scube_task_app/constant/app_colors.dart';
import 'package:scube_task_app/constant/app_strings.dart';
import 'package:scube_task_app/utils/app_size.dart';

class DetailListItem extends StatelessWidget {
  final Map<String, String> item;
  final int index;
  final Color? dotColor;

  const DetailListItem({
    super.key,
    required this.item,
    required this.index,
    this.dotColor,
  });

  @override
  Widget build(BuildContext context) {
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

    final color = dotColor ?? parsedColor ?? colors[index % colors.length];

    return Container(
      margin: EdgeInsets.only(bottom: 8),
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: AppColors.instance.borderGrey.withValues(alpha: 0.6),
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
            color: AppColors.instance.borderGrey.withValues(alpha: 0.6),
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
