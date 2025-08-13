import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:quizy/app_theme/app_colors.dart';
import 'package:quizy/app_theme/style_helper.dart';
import 'package:quizy/screens/delete_account_Screen/delete_account_controller.dart';

class DeleteAccountScreen extends StatefulWidget {
  const DeleteAccountScreen({super.key});

  @override
  State<DeleteAccountScreen> createState() => _DeleteAccountScreenState();
}

class _DeleteAccountScreenState extends State<DeleteAccountScreen> {
  RxBool isPasswordShown = false.obs;
  DeleteAccountController deleteAccountController = Get.put(DeleteAccountController());

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
        title: Text('Delete Account', style: StyleHelper.customStyle(color: AppColors.black, size: 16.sp, family: bold)),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Password', style: StyleHelper.customStyle(color: AppColors.black, size: 14.sp, family: semiBold)),
                Obx(
                  () => GestureDetector(
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
            Obx(
              () => Container(
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
                  controller: deleteAccountController.passwordController,
                  cursorColor: AppColors.slateGray,
                  obscureText: !isPasswordShown.value,
                  obscuringCharacter: '•',
                  decoration: InputDecoration(
                    border: OutlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.circular(12.r)),
                    contentPadding: EdgeInsets.all(5.sp),
                    fillColor: AppColors.white,
                    suffixIcon:
                        deleteAccountController.isPasswordError.value ? Icon(Icons.info_outline, size: 24.sp, color: AppColors.red) : SizedBox(),
                    filled: true,
                  ),
                  validator: (value) {
                    if (value?.isEmpty ?? false) {
                      deleteAccountController.isPasswordError.value = true;
                      deleteAccountController.passwordErrorText.value = 'Please enter Password';
                    }
                    if ((value?.length ?? 0) < 6) {
                      deleteAccountController.isPasswordError.value = true;
                      deleteAccountController.passwordErrorText.value = 'Password must be at least 6 characters long.';
                    }
                    return null;
                  },
                ),
              ),
            ),
            Obx(
              () =>
                  deleteAccountController.isPasswordError.value
                      ? Text(
                        deleteAccountController.passwordErrorText.value,
                        style: StyleHelper.customStyle(color: AppColors.red, size: 12.sp, family: semiBold),
                      ).paddingOnly(top: 8.h)
                      : SizedBox(),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(),
                GestureDetector(
                  onTap: () {
                    if (deleteAccountController.isValidate()) {
                      Get.back();
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
                    decoration: BoxDecoration(color: AppColors.red, borderRadius: BorderRadius.circular(12.r)),
                    child: Text('Delete Account', style: StyleHelper.customStyle(color: AppColors.white, size: 16.sp, family: semiBold)),
                  ),
                ),
              ],
            ).paddingOnly(top: 20.h,bottom: 16.h),
            Text(
              'Note: you will have 30 days to reactive your account by logging back in.After 30 days, your account will be deleted permanently.',
              style: StyleHelper.customStyle(color: AppColors.darkGray.withOpacity(0.7), size: 14.sp, family: semiBold),
              maxLines: null,
              softWrap: true,
              textAlign: TextAlign.center,
            ),
          ],
        ).paddingSymmetric(horizontal: 16.w,vertical: 16.h),
      ),
    );
  }
}
