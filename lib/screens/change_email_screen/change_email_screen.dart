import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:quizy/app_theme/app_colors.dart';
import 'package:quizy/app_theme/style_helper.dart';
import 'package:quizy/screens/change_email_screen/change_email_controller.dart';

class ChangeEmailScreen extends StatefulWidget {
  const ChangeEmailScreen({super.key});

  @override
  State<ChangeEmailScreen> createState() => _ChangeEmailScreenState();
}

class _ChangeEmailScreenState extends State<ChangeEmailScreen> {
  RxBool isPasswordShown = false.obs;
  ChangeEmailController changeEmailController = Get.put(ChangeEmailController());


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
        title: Text('Change Email', style: StyleHelper.customStyle(color: AppColors.black, size: 16.sp, family: bold)),
        leading: GestureDetector(onTap: (){Get.back();},child: Icon(Icons.arrow_back, size: 24.sp, color: AppColors.black)),
        centerTitle: true,
        backgroundColor: AppColors.grayBackground,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Email Address', style: StyleHelper.customStyle(color: AppColors.black, size: 14.sp, family: semiBold)).paddingOnly(bottom: 8.h),
            Obx(()=> Container(
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
                  controller: changeEmailController.emailAddressController,
                  cursorColor: AppColors.slateGray,
                  validator: (value) {
                    if (value?.isEmpty ?? false) {
                      changeEmailController.isEmailError.value = true;
                      changeEmailController.emailErrorText.value = 'Please enter email address';
                    }
                    if (RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$').hasMatch(value ?? '')) {
                      changeEmailController.isEmailError.value = true;
                      changeEmailController.emailErrorText.value = 'Please enter valid email address';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.circular(12.r)),
                    contentPadding: EdgeInsets.all(5.sp),
                    suffixIcon: changeEmailController.isEmailError.value ? Icon(Icons.info_outline,size: 24.sp,color: AppColors.red) : SizedBox(),
                    fillColor: AppColors.white,
                    filled: true,
                  ),
                ),
              ).paddingOnly(bottom: changeEmailController.isEmailError.value ? 0.h : 12.h),
            ),
            Obx(()=>changeEmailController.isEmailError.value?Text(
              changeEmailController.emailErrorText.value,
              style: StyleHelper.customStyle(color: AppColors.red, size: 12.sp,family: semiBold),
            ).paddingOnly(bottom: 12.h,top: 8.h):SizedBox()),
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
                controller: changeEmailController.passwordController,
                cursorColor: AppColors.slateGray,
                obscureText: !isPasswordShown.value,
                obscuringCharacter: '•',
                decoration: InputDecoration(
                  border: OutlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.circular(12.r)),
                  contentPadding: EdgeInsets.all(5.sp),
                  fillColor: AppColors.white,
                  suffixIcon: changeEmailController.isPassError.value ? Icon(Icons.info_outline,size: 24.sp,color: AppColors.red,) :SizedBox() ,
                  filled: true,
                ),
                validator: (value) {
                  if (value?.isEmpty ?? false) {
                    changeEmailController.isPassError.value = true;
                    changeEmailController.passErrorText.value = 'Please enter Password';
                  }
                  if ((value?.length ?? 0) < 6) {
                    changeEmailController.isPassError.value = true;
                    changeEmailController.passErrorText.value = 'Password must be at least 6 characters long.';
                  }
                  return null;
                },
              ),
            )),
            Obx(()=>changeEmailController.isPassError.value ?Text(changeEmailController.passErrorText.value, style: StyleHelper.customStyle(color: AppColors.red, size: 12.sp,family: semiBold)).paddingOnly(top: 8.h) :SizedBox()),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(),
                GestureDetector(
                  onTap: (){
                    if(changeEmailController.isValidate()){
                      Get.back();
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16.w,vertical: 8.h),
                    decoration: BoxDecoration(
                      color: AppColors.blue,
                      borderRadius: BorderRadius.circular(12.r)
                    ),
                    child: Text('Change Email',style: StyleHelper.customStyle(color: AppColors.white,size: 16.sp,family: semiBold),),
                  ),
                ),
              ],
            ).paddingOnly(bottom: 16.h,top: 16.h),
            Text('We need your password in order to confirm that it is really you trying to change the email address',
              style: StyleHelper.customStyle(color: AppColors.darkGray,size: 10.sp,family: semiBold),
              maxLines: null,
              softWrap: true,
              textAlign: TextAlign.center,
            ).paddingSymmetric(horizontal: 16.w)
          ],
        ).paddingSymmetric(horizontal: 16.w),
      ),
    );
  }
}
