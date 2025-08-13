import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:quizy/app_theme/app_colors.dart';
import 'package:quizy/app_theme/style_helper.dart';

class ThemeScreen extends StatefulWidget {
  const ThemeScreen({super.key});

  @override
  State<ThemeScreen> createState() => _ThemeScreenState();
}

class _ThemeScreenState extends State<ThemeScreen> {

  RxString selectedTheme = 'System'.obs;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.grayBackground,
      appBar:  AppBar(
        title: Text('Change Theme', style: StyleHelper.customStyle(color: AppColors.black, size: 16.sp, family: bold)),
        leading: GestureDetector(onTap: (){Get.back();},child: Icon(Icons.arrow_back, size: 24.sp, color: AppColors.black)),
        centerTitle: true,
        backgroundColor: AppColors.grayBackground,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(16.sp),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Column(
            children: [
              GestureDetector(
                onTap: (){
                  selectedTheme.value = 'System';
                },
                child: Obx(()=> Container(
                  color: Colors.transparent,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.phone_android_outlined,size: 24.sp,color: selectedTheme.value == 'System'? AppColors.green : AppColors.black,),
                            Text('System',style: StyleHelper.customStyle(color: AppColors.black,size: 16.sp,family: semiBold),).paddingOnly(left: 8.w)
                          ],
                        ),
                        selectedTheme.value == 'System' ? Icon(Icons.check,size: 18.sp,color: AppColors.black) : SizedBox()
                      ],
                    ).paddingSymmetric(horizontal: 16.w,vertical: 8.h),
                ),
                ),
              ),
              Divider(thickness: 1.w,color: AppColors.grayBackground,),
              GestureDetector(
                onTap: (){
                  selectedTheme.value = 'Light';
                },
                child: Obx(()=> Container(
                  color: Colors.transparent,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.sunny,size: 24.sp,color: selectedTheme.value == 'Light'? AppColors.green :   AppColors.black,),
                            Text('Light',style: StyleHelper.customStyle(color: AppColors.black,size: 16.sp,family: semiBold),).paddingOnly(left: 8.w)
                          ],
                        ),
                        selectedTheme.value == 'Light' ? Icon(Icons.check,size: 18.sp,color: AppColors.black,): SizedBox()
                      ],
                    ).paddingSymmetric(horizontal: 16.w,vertical: 8.h),
                ),
                ),
              ),
              Divider(thickness: 1.w,color: AppColors.grayBackground,),
              GestureDetector(
                onTap: (){
                  selectedTheme.value = 'Dark';
                },
                child: Obx(()=> Container(
                  color: Colors.transparent,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(CupertinoIcons.moon_fill,size: 24.sp,color: selectedTheme.value == 'Dark'? AppColors.green :  AppColors.black,),
                            Text('Dark',style: StyleHelper.customStyle(color: AppColors.black,size: 16.sp,family: semiBold),).paddingOnly(left: 8.w)
                          ],
                        ),
                        selectedTheme.value == 'Dark' ? Icon(Icons.check,size: 18.sp,color: AppColors.black,): SizedBox()
                      ],
                    ).paddingSymmetric(horizontal: 16.w,vertical: 8.h),
                ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
