import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:quizy/app_theme/app_colors.dart';
import 'package:quizy/app_theme/style_helper.dart';
import 'package:quizy/screens/change_password_screen/change_password_controller.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {

  RxBool isPasswordShown = false.obs;
  RxBool isNewPasswordShown = false.obs;
  ChangePasswordController changePasswordController = Get.put(ChangePasswordController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.grayBackground,
      appBar:AppBar(
        title: Text('Change Password', style: StyleHelper.customStyle(color: AppColors.black, size: 16.sp, family: bold)),
        leading: GestureDetector(onTap: (){Get.back();},child: Icon(Icons.arrow_back, size: 24.sp, color: AppColors.black)),
        centerTitle: true,
        backgroundColor: AppColors.grayBackground,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Old Password', style: StyleHelper.customStyle(color: AppColors.black, size: 14.sp, family: semiBold)),
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
                      Text('Show Password', style: StyleHelper.customStyle(color: AppColors.darkGray, size: 14.sp, family: semiBold)),
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
                controller: changePasswordController.oldPasswordController,
                cursorColor: AppColors.slateGray,
                obscureText: !isPasswordShown.value,
                obscuringCharacter: '•',
                decoration: InputDecoration(
                  border: OutlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.circular(12.r)),
                  contentPadding: EdgeInsets.all(5.sp),
                  fillColor: AppColors.white,
                  suffixIcon: changePasswordController.isOldPasswordError.value ? Icon(Icons.info_outline,size: 24.sp,color: AppColors.red,) :SizedBox() ,
                  filled: true,
                ),
                validator: (value) {
                  if (value?.isEmpty ?? false) {
                    changePasswordController.isOldPasswordError.value = true;
                    changePasswordController.oldPassWordErrorText.value = 'Please enter Password';
                  }
                  if ((value?.length ?? 0) < 6) {
                    changePasswordController.isOldPasswordError.value = true;
                    changePasswordController.oldPassWordErrorText.value = 'Password must be at least 6 characters long.';
                  }
                  return null;
                },
              ),
            )),
            Obx(()=>changePasswordController.isOldPasswordError.value
                ?Text(changePasswordController.oldPassWordErrorText.value, style: StyleHelper.customStyle(color: AppColors.red, size: 12.sp,family: semiBold)).paddingOnly(top: 8.h)
                :SizedBox()),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('New Password', style: StyleHelper.customStyle(color: AppColors.black, size: 14.sp, family: semiBold)),
                Obx(() => GestureDetector(
                  onTap: () {
                    isNewPasswordShown.toggle();
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
                        child: isNewPasswordShown.value ? Icon(Icons.check, color: AppColors.blue, size: 20.sp) : SizedBox(),
                      ).paddingOnly(right: 5.w),
                      Text('Show Password', style: StyleHelper.customStyle(color: AppColors.darkGray, size: 14.sp, family: semiBold)),
                    ],
                  ),
                ),
                ),
              ],
            ).paddingOnly(bottom: 8.h,top: 16.h,),
            Obx(() => Container(
              width: Get.width,
              padding: EdgeInsets.symmetric(horizontal: 16.w),
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
                controller: changePasswordController.newPasswordController,
                cursorColor: AppColors.slateGray,
                obscureText: !isNewPasswordShown.value,
                obscuringCharacter: '•',
                decoration: InputDecoration(
                  border: OutlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.circular(12.r)),
                  contentPadding: EdgeInsets.all(5.sp),
                  fillColor: AppColors.white,
                  hintText: 'New Password',
                  hintStyle: StyleHelper.customStyle(color: AppColors.darkGray,size: 14.sp,family: semiBold),
                  suffixIcon: changePasswordController.isNewPasswordError.value ? Icon(Icons.info_outline,size: 24.sp,color: AppColors.red,) :SizedBox() ,
                  filled: true,
                ),
                validator: (value) {
                  if (value?.isEmpty ?? false) {
                    changePasswordController.isNewPasswordError.value = true;
                    changePasswordController.newPassWordErrorText.value = 'Please enter New Password';
                  }
                  if ((value?.length ?? 0) < 6) {
                    changePasswordController.isNewPasswordError.value = true;
                    changePasswordController.newPassWordErrorText.value = 'New Password must be at least 6 characters long.';
                  }
                  return null;
                },
              ),
            )),
            Obx(()=>changePasswordController.isNewPasswordError.value
                ?Text(changePasswordController.newPassWordErrorText.value, style: StyleHelper.customStyle(color: AppColors.red, size: 12.sp,family: semiBold)).paddingOnly(top: 8.h)
                :SizedBox()),
            Obx(() => Container(
              width: Get.width,
              padding: EdgeInsets.symmetric(horizontal: 16.w),
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
                controller: changePasswordController.confirmPasswordController,
                cursorColor: AppColors.slateGray,
                obscureText: !isNewPasswordShown.value,
                obscuringCharacter: '•',
                decoration: InputDecoration(
                  border: OutlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.circular(12.r)),
                  contentPadding: EdgeInsets.all(5.sp),
                  fillColor: AppColors.white,
                  hintText: 'Confirm Password',
                  hintStyle: StyleHelper.customStyle(color: AppColors.darkGray,size: 14.sp,family: semiBold),
                  suffixIcon: changePasswordController.isNewPasswordError.value ? Icon(Icons.info_outline,size: 24.sp,color: AppColors.red,) :SizedBox() ,
                  filled: true,
                ),
                validator: (value) {
                  if (value?.isEmpty ?? false) {
                    changePasswordController.isConfirmPasswordError.value = true;
                    changePasswordController.confirmPassWordErrorText.value = 'Please enter Confirm Password';
                  }
                  if ((value?.length ?? 0) < 6) {
                    changePasswordController.isConfirmPasswordError.value = true;
                    changePasswordController.confirmPassWordErrorText.value = 'Confirm Password must be at least 6 characters long.';
                  }
                  if(changePasswordController.newPasswordController.text.trim() != value){
                    changePasswordController.isConfirmPasswordError.value = true;
                    changePasswordController.isNewPasswordError.value = true;
                    changePasswordController.newPassWordErrorText.value = 'New Password and Confirm password dose not match';
                    changePasswordController.confirmPassWordErrorText.value = 'New Password and Confirm password dose not match';
                  }
                  return null;
                },
              ),
            )).paddingOnly(top: 16.h),
            Obx(()=>changePasswordController.isConfirmPasswordError.value
                ?Text(changePasswordController.confirmPassWordErrorText.value, style: StyleHelper.customStyle(color: AppColors.red, size: 12.sp,family: semiBold)).paddingOnly(top: 8.h)
                :SizedBox()),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(),
                GestureDetector(
                  onTap: (){
                    if(changePasswordController.isValidate()){
                      Get.back();
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16.w,vertical: 8.h),
                    decoration: BoxDecoration(
                        color: AppColors.blue,
                        borderRadius: BorderRadius.circular(12.r)
                    ),
                    child: Text('Change Password',style: StyleHelper.customStyle(color: AppColors.white,size: 16.sp,family: semiBold),),
                  ),
                ),
              ],
            ).paddingOnly(bottom: 16.h,top: 20.h),
          ],
        ).paddingSymmetric(horizontal: 16.w,vertical: 16.h),
      ),
    );
  }
}
