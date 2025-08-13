import 'package:quizy/app_theme/app_colors.dart';
import 'package:quizy/app_theme/style_helper.dart';
import 'package:quizy/screens/change_name_screeen/change_name_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ChangeNameScreen extends StatefulWidget {
  const ChangeNameScreen({super.key});

  @override
  State<ChangeNameScreen> createState() => _ChangeNameScreenState();
}

class _ChangeNameScreenState extends State<ChangeNameScreen> {
  ChangeNameController changeNameController = Get.put(ChangeNameController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.grayBackground,
      appBar: AppBar(
        title: Text('Change Name', style: StyleHelper.customStyle(color: AppColors.black, size: 16.sp, family: bold)),
        leading: GestureDetector(onTap: (){Get.back();},child: Icon(Icons.arrow_back, size: 24.sp, color: AppColors.black)),
        centerTitle: true,
        backgroundColor: AppColors.grayBackground,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('First Name', style: StyleHelper.customStyle(color: AppColors.black, size: 16.sp, family: semiBold)).paddingSymmetric(vertical: 8.h),
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
                  controller: changeNameController.firstNameController,
                  cursorColor: AppColors.slateGray,
                  validator: (value) {
                    if (value?.isEmpty ?? false) {
                      changeNameController.isFirstNameError.value = true;
                      changeNameController.firstNameErrorText.value = 'Please enter first name';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.circular(12.r)),
                    contentPadding: EdgeInsets.all(5.sp),
                    fillColor: AppColors.white,
                    suffixIcon:changeNameController.isFirstNameError.value ? Icon(Icons.info_outline,color: AppColors.red,size: 24.sp,) : SizedBox() ,
                    filled: true,
                  ),
                ),
              ).paddingOnly(bottom: changeNameController.isFirstNameError.value ? 0.h : 12.h),),
            Obx(()=>changeNameController.isFirstNameError.value?Text(
              changeNameController.firstNameErrorText.value,
              style: StyleHelper.customStyle(color: AppColors.red, size: 12.sp,family: semiBold),
            ).paddingOnly(bottom: 12.h,top: 8.h):SizedBox()),

            Text('Last Name', style: StyleHelper.customStyle(color: AppColors.black, size: 14.sp, family: semiBold)).paddingOnly(bottom: 8.h),
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
                  controller: changeNameController.lastNameController,
                  cursorColor: AppColors.slateGray,
                  validator: (value) {
                    if (value?.isEmpty ?? false) {
                      changeNameController.isLastNameError.value = true;
                      changeNameController.lastNameErrorText.value = 'Please enter last name';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.circular(12.r)),
                    contentPadding: EdgeInsets.all(5.sp),
                    fillColor: AppColors.white,
                    suffixIcon: changeNameController.isLastNameError.value ? Icon(Icons.info_outline,color: AppColors.red,size: 24.sp,) : SizedBox() ,
                    filled: true,
                  ),
                ),
              ).paddingOnly(bottom: changeNameController.isLastNameError.value ? 0.h : 12.h),),
            Obx(()=>changeNameController.isLastNameError.value? Text(
                changeNameController.lastNameErrorText.value,
                style: StyleHelper.customStyle(color: AppColors.errorColor, size: 12.sp,family: semiBold),
              ).paddingOnly(bottom: 12.h,top: 8.h):SizedBox()),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(),
                GestureDetector(
                  onTap: () {
                    if (changeNameController.isValidate()) {
                      Get.back();
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
                    margin: EdgeInsets.only(bottom: 16.h),
                    decoration: BoxDecoration(color: AppColors.blue, borderRadius: BorderRadius.circular(12.r)),
                    child: Text('Change Name', style: StyleHelper.customStyle(color: AppColors.white, size: 16.sp, family: semiBold)),
                  ),
                ),
              ],
            ),
            Text(
              'Tip: You can type in any one (or both) of the fields and change the particular part(s)',
              style: StyleHelper.customStyle(color: AppColors.darkGray, size: 12.sp, family: semiBold),
              textAlign: TextAlign.center,
              maxLines: null,
            ).paddingSymmetric(horizontal: 16.w),
          ],
        ).paddingSymmetric(horizontal: 16.w),
      ),
    );
  }
}
