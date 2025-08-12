import 'package:animated_loader_demo_flutter/app_theme/app_colors.dart';
import 'package:animated_loader_demo_flutter/app_theme/style_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
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
        title: Text('Setting', style: StyleHelper.customStyle(color: AppColors.black, size: 16.sp, family: bold)),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Account Type', style: StyleHelper.customStyle(color: AppColors.dimGray, size: 14.sp, family: semiBold)).paddingOnly(bottom: 8.h),
            Container(
              padding: EdgeInsets.all(16.sp),
              decoration: BoxDecoration(color: AppColors.white, borderRadius: BorderRadius.circular(12.r)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(Icons.stars, size: 26.sp, color: AppColors.gray).paddingOnly(right: 12.w),
                      Text('Free', style: StyleHelper.customStyle(color: AppColors.black, size: 18.sp, family: semiBold)),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
                    decoration: BoxDecoration(color: AppColors.blue, borderRadius: BorderRadius.circular(12.r)),
                    child: Text('Upgrade now!', style: StyleHelper.customStyle(color: AppColors.white, size: 14.sp, family: semiBold)),
                  ),
                ],
              ),
            ).paddingOnly(bottom: 18.h),
            Text('Account', style: StyleHelper.customStyle(color: AppColors.dimGray, size: 14.sp, family: semiBold)).paddingOnly(bottom: 8.h),
            Container(
              padding: EdgeInsets.symmetric(vertical: 16.h),
              decoration: BoxDecoration(color: AppColors.white, borderRadius: BorderRadius.circular(12.r)),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.person_outline_outlined, color: AppColors.black, size: 24.sp).paddingOnly(right: 16.w),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Name', style: StyleHelper.customStyle(color: AppColors.black, size: 16.sp, family: medium)),
                              Text('Hemaxi Akabari', style: StyleHelper.customStyle(color: AppColors.gray, size: 12.sp, family: medium)),
                            ],
                          ),
                        ],
                      ),
                      Icon(Icons.arrow_forward_ios_outlined, size: 24.sp, color: AppColors.black),
                    ],
                  ).paddingSymmetric(horizontal: 16.w),
                  Divider(thickness: 1.w, color: AppColors.lightGray).paddingSymmetric(vertical: 8.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 4,
                        child: Row(
                          children: [
                            Icon(Icons.email_outlined, color: AppColors.black, size: 24.sp).paddingOnly(right: 16.w),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Email', style: StyleHelper.customStyle(color: AppColors.black, size: 16.sp, family: medium)),
                                  Text(
                                    'hemaxipatel768@gmail.com',
                                    textAlign: TextAlign.start,
                                    maxLines: null,
                                    style: StyleHelper.customStyle(color: AppColors.gray, size: 12.sp, family: medium),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ).paddingSymmetric(horizontal: 16.w),
                      ),
                      Expanded(flex: 1, child: Icon(Icons.arrow_forward_ios_outlined, size: 24.sp, color: AppColors.black)),
                    ],
                  ),
                  Divider(thickness: 1.w, color: AppColors.lightGray).paddingSymmetric(vertical: 8.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.lock_outline, color: AppColors.black, size: 24.sp).paddingOnly(right: 16.w),
                          Text('Password', style: StyleHelper.customStyle(color: AppColors.black, size: 16.sp, family: medium)),
                        ],
                      ),
                      Icon(Icons.arrow_forward_ios_outlined, size: 24.sp, color: AppColors.black),
                    ],
                  ).paddingOnly(bottom: 5.h, left: 16.w, right: 16.w),
                ],
              ),
            ).paddingOnly(bottom: 18.h),
            Text('General', style: StyleHelper.customStyle(color: AppColors.dimGray, size: 14.sp, family: semiBold)).paddingOnly(bottom: 8.h),
            Container(
              padding: EdgeInsets.symmetric(vertical: 16.h),
              decoration: BoxDecoration(color: AppColors.white, borderRadius: BorderRadius.circular(12.r)),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.color_lens_outlined, color: AppColors.black, size: 24.sp).paddingOnly(right: 16.w),
                          Text('Theme', style: StyleHelper.customStyle(color: AppColors.black, size: 16.sp, family: medium)),
                        ],
                      ),
                      Icon(Icons.arrow_forward_ios_outlined, size: 24.sp, color: AppColors.black),
                    ],
                  ).paddingSymmetric(horizontal: 16.w),
                  Divider(thickness: 1.w, color: AppColors.lightGray).paddingSymmetric(vertical: 8.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.notifications_none, color: AppColors.black, size: 24.sp).paddingOnly(right: 16.w),
                          Text('Notification', style: StyleHelper.customStyle(color: AppColors.black, size: 16.sp, family: medium)),
                        ],
                      ),
                      Icon(Icons.arrow_forward_ios_outlined, size: 24.sp, color: AppColors.black),
                    ],
                  ).paddingSymmetric(horizontal: 16.w),
                  Divider(thickness: 1.w, color: AppColors.lightGray).paddingSymmetric(vertical: 8.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.feedback_outlined, color: AppColors.black, size: 24.sp).paddingOnly(right: 16.w),
                          Text('Feedback', style: StyleHelper.customStyle(color: AppColors.black, size: 16.sp, family: medium)),
                        ],
                      ),
                      Icon(Icons.arrow_forward_ios_outlined, size: 24.sp, color: AppColors.black),
                    ],
                  ).paddingSymmetric(horizontal: 16.w),
                  Divider(thickness: 1.w, color: AppColors.lightGray).paddingSymmetric(vertical: 8.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.star_border, color: AppColors.black, size: 24.sp).paddingOnly(right: 16.w),
                          Text('Rate us', style: StyleHelper.customStyle(color: AppColors.black, size: 16.sp, family: medium)),
                        ],
                      ),
                      Icon(Icons.arrow_forward_ios_outlined, size: 24.sp, color: AppColors.black),
                    ],
                  ).paddingOnly(bottom: 5.h, left: 16.w, right: 16.w),
                ],
              ),
            ).paddingOnly(bottom: 18.h),
            Text('Subscription', style: StyleHelper.customStyle(color: AppColors.dimGray, size: 14.sp, family: semiBold)).paddingOnly(bottom: 8.h),
            Container(
              padding: EdgeInsets.all(16.sp),
              decoration: BoxDecoration(color: AppColors.white, borderRadius: BorderRadius.circular(12.r)),
              child: Row(
                children: [
                  Icon(Icons.currency_exchange, size: 26.sp, color: AppColors.black).paddingOnly(right: 12.w),
                  Text('Restore purchase', style: StyleHelper.customStyle(color: AppColors.black, size: 18.sp, family: semiBold)),
                ],
              ),
            ).paddingOnly(bottom: 18.h),
            Text('Legal', style: StyleHelper.customStyle(color: AppColors.dimGray, size: 14.sp, family: semiBold)).paddingOnly(bottom: 8.h),
            Container(
              padding: EdgeInsets.symmetric(vertical: 16.h),
              decoration: BoxDecoration(color: AppColors.white, borderRadius: BorderRadius.circular(12.r)),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.privacy_tip, color: AppColors.black, size: 24.sp).paddingOnly(right: 16.w),
                          Text('Privacy Policy', style: StyleHelper.customStyle(color: AppColors.black, size: 16.sp, family: medium)),
                        ],
                      ),
                      Icon(Icons.arrow_forward_ios_outlined, size: 24.sp, color: AppColors.black),
                    ],
                  ).paddingSymmetric(horizontal: 16.w),
                  Divider(thickness: 1.w, color: AppColors.lightGray).paddingSymmetric(vertical: 8.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.article_outlined, color: AppColors.black, size: 24.sp).paddingOnly(right: 16.w),
                          Text('Terms of Use', style: StyleHelper.customStyle(color: AppColors.black, size: 16.sp, family: medium)),
                        ],
                      ),
                      Icon(Icons.arrow_forward_ios_outlined, size: 24.sp, color: AppColors.black),
                    ],
                  ).paddingOnly(bottom: 5.h, left: 16.w, right: 16.w),
                ],
              ),
            ).paddingOnly(bottom: 18.h),
            Text('Log Out', style: StyleHelper.customStyle(color: AppColors.dimGray, size: 14.sp, family: semiBold)).paddingOnly(bottom: 8.h),
            Container(
              padding: EdgeInsets.all(16.sp),
              decoration: BoxDecoration(color: AppColors.white, borderRadius: BorderRadius.circular(12.r)),
              child: Row(
                children: [
                  Icon(Icons.logout, size: 26.sp, color: AppColors.amberYellow).paddingOnly(right: 12.w),
                  Text('Log Out', style: StyleHelper.customStyle(color: AppColors.amberYellow, size: 18.sp, family: semiBold)),
                ],
              ),
            ).paddingOnly(bottom: 18.h),
            Text('Reset & Delete', style: StyleHelper.customStyle(color: AppColors.dimGray, size: 14.sp, family: semiBold)).paddingOnly(bottom: 8.h),
            Container(
              padding: EdgeInsets.symmetric(vertical: 16.h),
              decoration: BoxDecoration(color: AppColors.white, borderRadius: BorderRadius.circular(12.r)),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.remove_circle_outline, color: AppColors.red, size: 24.sp).paddingOnly(right: 16.w),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Reset Attempts', style: StyleHelper.customStyle(color: AppColors.red, size: 16.sp, family: medium)),
                              Text(
                                'Reset attempts for this course',
                                style: StyleHelper.customStyle(color: AppColors.gray, size: 12.sp, family: medium),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Icon(Icons.arrow_forward_ios_outlined, size: 24.sp, color: AppColors.red),
                    ],
                  ).paddingSymmetric(horizontal: 16.w),
                  Divider(thickness: 1.w, color: AppColors.lightGray).paddingSymmetric(vertical: 8.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.cancel_outlined, color: AppColors.red, size: 24.sp).paddingOnly(right: 16.w),
                          Text('Delete Account', style: StyleHelper.customStyle(color: AppColors.red, size: 16.sp, family: medium)),
                        ],
                      ),
                      Icon(Icons.arrow_forward_ios_outlined, size: 24.sp, color: AppColors.red),
                    ],
                  ).paddingOnly(bottom: 5.h, left: 16.w, right: 16.w),
                ],
              ),
            ).paddingOnly(bottom: 18.h),
          ],
        ).paddingSymmetric(horizontal: 16.w),
      ),
    );
  }
}
