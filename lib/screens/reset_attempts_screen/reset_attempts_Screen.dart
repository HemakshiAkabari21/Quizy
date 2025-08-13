import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:quizy/app_theme/app_colors.dart';
import 'package:quizy/app_theme/style_helper.dart';
import 'package:quizy/screens/reset_attempts_screen/reset_attempts_controller.dart';

class ResetAttemptsScreen extends StatefulWidget {
  const ResetAttemptsScreen({super.key});

  @override
  State<ResetAttemptsScreen> createState() => _ResetAttemptsScreenState();
}

class _ResetAttemptsScreenState extends State<ResetAttemptsScreen> {
  RxBool isPasswordShown = false.obs;
  ResetAttemptsController resetAttemptsController = Get.put(ResetAttemptsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.grayBackground,
      appBar:AppBar(
        centerTitle: true,
        backgroundColor: AppColors.grayBackground,
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: Icon(Icons.arrow_back, size: 24.sp, color: AppColors.black),
        ),
        title: Text('Reset Attempts', style: StyleHelper.customStyle(color: AppColors.black, size: 18.sp, family: semiBold)),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Password', style: StyleHelper.customStyle(color: AppColors.black, size: 14.sp, family: semiBold)),
                Obx(() => GestureDetector(
                  onTap: () {
                    isPasswordShown.toggle();
                  },
                  child: Row(
                    children: [
                      Container(
                        height: 20.h,
                        width: 20.w,
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(4.r),
                          border: Border.all(color: AppColors.lightGray),
                          boxShadow: [BoxShadow(color: AppColors.lightGray, blurRadius: 4, offset: Offset(0, 2))],
                        ),
                        child: isPasswordShown.value ? Icon(Icons.check, color: AppColors.blue, size: 20.sp) : SizedBox(),
                      ).paddingOnly(right: 5.w),
                      Text('Show Password', style: StyleHelper.customStyle(color: AppColors.darkGray, size: 12.sp, family: semiBold)),
                    ],
                  ),
                ),
                ),
              ],
            ).paddingOnly(bottom: 8.h),
            Obx(() => Container(
              width: Get.width,
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(8.r),
                border: Border.all(color: AppColors.lightGray),
                boxShadow: [
                  BoxShadow(color: AppColors.lightGray, blurRadius: 4, offset: Offset(0, 2)),
                  BoxShadow(color: AppColors.lightGray, blurRadius: 4, offset: Offset(0, -1)),
                ],
              ),
              child: TextFormField(
                controller: resetAttemptsController.passwordController,
                cursorColor: AppColors.slateGray,
                obscureText: !isPasswordShown.value,
                obscuringCharacter: '•',
                decoration: InputDecoration(
                  border: OutlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.circular(12.r)),
                  contentPadding: EdgeInsets.all(5.sp),
                  fillColor: AppColors.white,
                  suffixIcon: resetAttemptsController.isPasswordError.value ? Icon(Icons.info_outline,size: 24.sp,color: AppColors.red,) :SizedBox() ,
                  filled: true,
                ),
                validator: (value) {
                  if (value?.isEmpty ?? false) {
                    resetAttemptsController.isPasswordError.value = true;
                    resetAttemptsController.passwordErrorText.value = 'Please enter Password';
                  }
                  if ((value?.length ?? 0) < 6) {
                    resetAttemptsController.isPasswordError.value = true;
                    resetAttemptsController.passwordErrorText.value = 'Password must be at least 6 characters long.';
                  }
                  return null;
                },
              ),
            )),
            Obx(()=>resetAttemptsController.isPasswordError.value ?Text(resetAttemptsController.passwordErrorText.value, style: StyleHelper.customStyle(color: AppColors.red, size: 12.sp,family: semiBold)).paddingOnly(top: 8.h) :SizedBox()),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(),
                GestureDetector(
                  onTap: (){
                    if(resetAttemptsController.isValidate()){
                      Get.back();
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 8.h,horizontal: 16.w),
                    decoration: BoxDecoration(
                      color: AppColors.red,
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Text('Reset Attempts',style: StyleHelper.customStyle(color: AppColors.white,size: 16.sp,family: semiBold),),
                  ),
                )
              ],
            ).paddingSymmetric(vertical: 20.h)
          ],
        ).paddingSymmetric(horizontal: 16.w),
      ),
    );
  }
}
