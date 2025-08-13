import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:quizy/app_theme/app_colors.dart';
import 'package:quizy/app_theme/style_helper.dart';

class TermsOfUse extends StatefulWidget {
  const TermsOfUse({super.key});

  @override
  State<TermsOfUse> createState() => _TermsOfUseState();
}

class _TermsOfUseState extends State<TermsOfUse> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.grayBackground,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColors.grayBackground,
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: Icon(Icons.arrow_back, size: 24.sp, color: AppColors.black),
        ),
        title: Text('Terms Of Use', style: StyleHelper.customStyle(color: AppColors.black, size: 16.sp, family: bold)),
      ),
      body: Center(
        child: Text('Coming soon......'),
      ),
    );
  }
}
