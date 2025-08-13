import 'package:quizy/app_theme/app_colors.dart';
import 'package:quizy/app_theme/style_helper.dart';
import 'package:quizy/model/result_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_utils/get_utils.dart';

class QuestionResultWidget extends StatelessWidget {
  final List<QuestionStatus> questionResults;

  const QuestionResultWidget({
    super.key,
    required this.questionResults,
  });

  Color _getColor(QuestionStatus status) {
    switch (status) {
      case QuestionStatus.correct:
        return AppColors.green;
      case QuestionStatus.wrong:
        return AppColors.red;
      case QuestionStatus.skipped:
        return AppColors.amberYellow;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(questionResults.length, (index) {
          final color = _getColor(questionResults[index]);

          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (index != 0)
                Container(
                  width: 6.w,
                  height: 3.h,
                  color: color,
                ).paddingOnly(top: 7.h),
              Column(
                children: [
                  Container(
                    width: 16.w,
                    height: 16.h,
                    decoration: BoxDecoration(
                      color: color,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${index + 1}',
                    style: StyleHelper.customStyle(
                        color: color,
                        family: bold,
                        size: 14.sp
                    ),
                  ),
                ],
              ),
              if (index != questionResults.length - 1)
                Container(
                  width: 6.w,
                  height: 3.h,
                  color: color,
                ).paddingOnly(top: 7.h),
            ],
          );
        }),
      ),
    );
  }
}