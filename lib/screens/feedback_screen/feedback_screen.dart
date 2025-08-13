import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:quizy/app_theme/app_colors.dart';
import 'package:quizy/app_theme/style_helper.dart';
import 'package:quizy/screens/feedback_screen/feedback_controller.dart';

class FeedbackScreen extends StatefulWidget {
  const FeedbackScreen({super.key});

  @override
  State<FeedbackScreen> createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {

  FeedbackController feedbackController = Get.put(FeedbackController());

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
        title: Text('Feedback', style: StyleHelper.customStyle(color: AppColors.black, size: 18.sp, family: semiBold)),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.star_border,size: 30.sp,color: AppColors.gray).paddingOnly(right: 8.w),
                  Expanded(child: Text('Your feedback is valuable to us. If you find an error, want to request a new feature or anything that you think might help you in this app.we\'re just a submission away.',
                    style: StyleHelper.customStyle(color: AppColors.darkGray,size: 12.sp,family: semiBold),maxLines: null,softWrap: true,)),
                ],
              ).paddingOnly(bottom: 16.h),
            Text('Title',style: StyleHelper.customStyle(color: AppColors.black,size: 16.sp,family: semiBold)).paddingOnly(bottom: 8.h),
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
                controller: feedbackController.titleController,
                cursorColor: AppColors.slateGray,
                validator: (value) {
                  if (value?.isEmpty ?? false) {
                    feedbackController.isTitleError.value = true;
                    feedbackController.titleErrorText.value = 'Please enter title of feedback';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.circular(12.r)),
                  contentPadding: EdgeInsets.all(5.sp),
                  fillColor: AppColors.white,
                  suffixIcon:feedbackController.isTitleError.value ? Icon(Icons.info_outline,color: AppColors.red,size: 24.sp,) : SizedBox() ,
                  filled: true,
                ),
              ),
            ).paddingOnly(bottom: feedbackController.isTitleError.value ? 0.h : 12.h),),
            Obx(()=>feedbackController.isTitleError.value?Text(
              feedbackController.titleErrorText.value,
              style: StyleHelper.customStyle(color: AppColors.red, size: 12.sp,family: semiBold),
            ).paddingOnly(bottom: 12.h,top: 8.h):SizedBox()),
            Text('Details',style: StyleHelper.customStyle(color: AppColors.black,size: 16.sp,family: semiBold)).paddingOnly(bottom: 8.h),
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
                controller: feedbackController.detailsController,
                cursorColor: AppColors.slateGray,
                maxLines: 6,
                validator: (value) {
                  if (value?.isEmpty ?? false) {
                    feedbackController.isDetailsError.value = true;
                    feedbackController.detailErrorText.value = 'Please enter details of feedback';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.circular(12.r)),
                  contentPadding: EdgeInsets.all(5.sp),
                  fillColor: AppColors.white,
                  suffixIcon:feedbackController.isDetailsError.value ? Icon(Icons.info_outline,color: AppColors.red,size: 24.sp,) : SizedBox() ,
                  filled: true,
                ),
              ),
            ).paddingOnly(bottom: feedbackController.isTitleError.value ? 0.h : 12.h),),
            Obx(()=>feedbackController.isDetailsError.value?Text(
              feedbackController.detailErrorText.value,
              style: StyleHelper.customStyle(color: AppColors.red, size: 12.sp,family: semiBold),
            ).paddingOnly(bottom: 12.h,top: 8.h):SizedBox()),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(),
                GestureDetector(
                  onTap: () {
                    if (feedbackController.isValidate()) {
                      Get.back();
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
                    margin: EdgeInsets.only(bottom: 16.h),
                    decoration: BoxDecoration(color: AppColors.blue, borderRadius: BorderRadius.circular(12.r)),
                    child: Text('Submit Feedback', style: StyleHelper.customStyle(color: AppColors.white, size: 16.sp, family: semiBold)),
                  ),
                ),
              ],
            ).paddingOnly(top: 16.h),
          ],
        ).paddingSymmetric(horizontal: 16.w),
      ),
    );
  }
}
