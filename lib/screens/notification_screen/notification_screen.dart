import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:quizy/app_theme/app_colors.dart';
import 'package:quizy/app_theme/style_helper.dart';
import 'package:quizy/utils/const_images.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  RxBool isNotificationOn = true.obs;

  @override
  Widget build(BuildContext context) {
    final opacity = isNotificationOn.value ? 1.0 : 0.5;
    return Scaffold(
      backgroundColor: AppColors.grayBackground,
      appBar: AppBar(
        title: Text('Notification', style: StyleHelper.customStyle(color: AppColors.black, size: 16.sp, family: bold)),
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: Icon(Icons.arrow_back, size: 24.sp, color: AppColors.black),
        ),
        centerTitle: true,
        backgroundColor: AppColors.grayBackground,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(12.r), color: AppColors.white),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.notifications_none, size: 24.sp, color: AppColors.black).paddingOnly(right: 16.w),
                            Text('Notifactions', style: StyleHelper.customStyle(color: AppColors.black, size: 14.sp, family: semiBold)),
                          ],
                        ),
                        Transform.scale(
                          scale: 1.0,
                          child: Switch(
                            trackOutlineWidth: WidgetStateProperty.all(2.w),
                            trackOutlineColor: WidgetStateProperty.resolveWith<Color?>((states) {
                              if (!states.contains(WidgetState.selected)) {
                                return AppColors.black;
                              }
                              return Colors.transparent;
                            }),
                            activeTrackColor: AppColors.white,
                            activeColor: AppColors.black,
                            inactiveTrackColor: AppColors.white,
                            inactiveThumbColor: AppColors.black,
                            focusColor: AppColors.black,
                            hoverColor: AppColors.black,
                            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            value: isNotificationOn.value,
                            onChanged: (value) {
                              isNotificationOn.toggle();
                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    ),
                  ).paddingOnly(bottom: 16.h),
                  Text(
                    'Reminders',
                    style: StyleHelper.customStyle(color: AppColors.darkGray, size: 14.sp, family: semiBold),
                  ).paddingOnly(bottom: 10.h),
                  Opacity(
                    opacity: opacity,
                    child: Container(
                      decoration: BoxDecoration(color: AppColors.white, borderRadius: BorderRadius.circular(12.r)),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Image.asset(AppImages.chestCoin, height: 54.h, width: 54.w),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('Chest Coins', style: StyleHelper.customStyle(color: AppColors.black, size: 14.sp, family: bold)),
                                      Text(
                                        'When chest of coins is available',
                                        style: StyleHelper.customStyle(color: AppColors.darkGray, size: 10.sp, family: semiBold),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Icon(
                                isNotificationOn.value == false ? Icons.check_box_outline_blank : Icons.check_box,
                                color: isNotificationOn.value == false ? AppColors.lightGray : AppColors.blue,
                                size: 24.sp,
                              ),
                            ],
                          ).paddingOnly(right: 16.w),
                          Divider(thickness: 2.w, color: AppColors.grayBackground).paddingOnly(bottom: 8.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  SvgPicture.asset(AppImages.starIcon, height: 24.h, width: 24.w).paddingOnly(right: 16.w, left: 16.w),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('New Coins', style: StyleHelper.customStyle(color: AppColors.black, size: 14.sp, family: bold)),
                                      Text(
                                        'When you receive 100 coins',
                                        style: StyleHelper.customStyle(color: AppColors.darkGray, size: 10.sp, family: semiBold),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Icon(
                                isNotificationOn.value == false ? Icons.check_box_outline_blank : Icons.check_box,
                                color: isNotificationOn.value == false ? AppColors.lightGray : AppColors.blue,
                                size: 24.sp,
                              ),
                            ],
                          ).paddingOnly(right: 16.w),
                          Divider(thickness: 2.w, color: AppColors.grayBackground).paddingOnly(bottom: 8.h, top: 8.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  SvgPicture.asset(AppImages.fireIcon, height: 24.h, width: 24.w).paddingOnly(right: 16.w, left: 16.w),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('Streak at stake', style: StyleHelper.customStyle(color: AppColors.black, size: 14.sp, family: bold)),
                                      Text(
                                        'When your streak is about to break',
                                        style: StyleHelper.customStyle(color: AppColors.darkGray, size: 10.sp, family: semiBold),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Icon(
                                isNotificationOn.value == false ? Icons.check_box_outline_blank : Icons.check_box,
                                color: isNotificationOn.value == false ? AppColors.lightGray : AppColors.blue,
                                size: 24.sp,
                              ),
                            ],
                          ).paddingOnly(right: 16.w),
                          Divider(thickness: 2.w, color: AppColors.grayBackground).paddingOnly(top: 8.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Image.asset(AppImages.sadEmoji, height: 54.h, width: 54.w),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('Missing you!', style: StyleHelper.customStyle(color: AppColors.black, size: 14.sp, family: bold)),
                                      Text(
                                        'When you haven\'t practiced in a while',
                                        style: StyleHelper.customStyle(color: AppColors.darkGray, size: 10.sp, family: semiBold),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Icon(
                                isNotificationOn.value == false ? Icons.check_box_outline_blank : Icons.check_box,
                                color: isNotificationOn.value == false ? AppColors.lightGray : AppColors.blue,
                                size: 24.sp,
                              ),
                            ],
                          ).paddingOnly(right: 16.w),
                        ],
                      ),
                    ),
                  ),
                  /* Stack(
                    children: [
                      ,
                    ],
                  ),*/
                ],
              ).paddingAll(16.sp),
            ),
          ],
        ),
      ),
    );
  }
}
