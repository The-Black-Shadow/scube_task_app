import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:scube_task_app/constant/app_colors.dart';
import 'package:scube_task_app/constant/app_text_styles.dart';
import 'package:scube_task_app/utils/app_size.dart';

class PowerCircularChart extends StatelessWidget {
  final double value;
  final String unit;
  final String? label;
  final double max;
  final double startAngle;
  final double sweepAngle;
  final Color? color;
  final Color? trackColor;
  final int precision;
  final double? strokeWidth;
  final bool unitOnNewLine;

  const PowerCircularChart({
    super.key,
    required this.value,
    required this.unit,
    this.label,
    this.max = 100.0,
    this.startAngle = 0,
    this.sweepAngle = 360,
    this.color,
    this.trackColor,
    this.precision = 2,
    this.strokeWidth,
    this.unitOnNewLine = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: AppSize.width(value: 180),
      height: AppSize.width(value: 180),
      child: Stack(
        alignment: Alignment.center,
        children: [
          CustomPaint(
            size: Size(AppSize.width(value: 120), AppSize.width(value: 120)),
            painter: _PowerCircularChartPainter(
              value: value,
              max: max,
              startAngle: startAngle,
              sweepAngle: sweepAngle,
              color: color ?? AppColors.instance.chartBlue,
              trackColor: trackColor ?? AppColors.instance.white,
              strokeWidth: strokeWidth ?? AppSize.width(value: 20),
            ),
          ),
          // Center Text
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (label != null) // Only show if label is provided
                Text(label!, style: AppTextStyles.instance.dashboardDataLabel),
              if (unitOnNewLine)
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      value.toStringAsFixed(precision),
                      style: AppTextStyles.instance.powerValue,
                    ),
                    Text(unit, style: AppTextStyles.instance.powerUnit),
                  ],
                )
              else
                Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    Text(
                      value.toStringAsFixed(precision),
                      style: AppTextStyles.instance.powerValue,
                    ),
                    const SizedBox(width: 2),
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

class _PowerCircularChartPainter extends CustomPainter {
  final double value;
  final double max;
  final double startAngle;
  final double sweepAngle;
  final Color color;
  final Color trackColor;
  final double strokeWidth;

  _PowerCircularChartPainter({
    required this.value,
    required this.max,
    required this.startAngle,
    required this.sweepAngle,
    required this.color,
    required this.trackColor,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width / 2);

    // Stroke width
    final strokeWidth = this.strokeWidth;

    final trackPaint = Paint()
      ..color = trackColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    final valuePaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    // Convert degrees to radians
    final startRad = startAngle * (math.pi / 180);
    final sweepRad = sweepAngle * (math.pi / 180);

    // Draw Track (Background)
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startRad,
      sweepRad,
      false,
      trackPaint,
    );

    // Calculate value sweep
    final clampedValue = value.clamp(0.0, max);
    final valueSweepRad = (clampedValue / max) * sweepRad;

    // Draw Value (Foreground)
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startRad,
      valueSweepRad,
      false,
      valuePaint,
    );
  }

  @override
  bool shouldRepaint(covariant _PowerCircularChartPainter oldDelegate) {
    return oldDelegate.value != value ||
        oldDelegate.max != max ||
        oldDelegate.startAngle != startAngle ||
        oldDelegate.sweepAngle != sweepAngle ||
        oldDelegate.color != color ||
        oldDelegate.trackColor != trackColor ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
