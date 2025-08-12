import 'package:animated_loader_demo_flutter/app_theme/style_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:percent_indicator/percent_indicator.dart';

class CircularProgressExample extends StatelessWidget {
  final String? text;
  final Color? textColor;
  final Color? backgroundColor;
  final double? percent;

  const CircularProgressExample({super.key, required this.text,required this.textColor,required this.backgroundColor,required this.percent});


  @override
  Widget build(BuildContext context) {
    return CircularPercentIndicator(
      radius: 60.0, // Circle size
      lineWidth: 10.0, // Stroke width
      percent: percent ?? 0.1, // 10% progress
      animation: true,
      animationDuration: 1000,
      center: Text(text ?? '',
        style: StyleHelper.customStyle(
          size: 36.0.sp,
          family: bold,
          color: textColor,
        ),
      ),
      progressColor: textColor, // Active arc color
      backgroundColor: backgroundColor ?? Colors.transparent, // Inactive circle color
      circularStrokeCap: CircularStrokeCap.round, // Rounded arc ends
    );
  }
}
