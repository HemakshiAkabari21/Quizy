import 'package:flutter_svg/svg.dart';
import 'package:quizy/app_theme/app_colors.dart';
import 'package:quizy/app_theme/style_helper.dart';
import 'package:quizy/screens/settings_screen/settings_screen.dart';
import 'package:quizy/utils/const_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isScrolled = false;
  final ScrollController controller = ScrollController();
  //String formattedDate = DateFormat('MMMM yyyy').format(DateTime(2025, 8));

  DateTime focusedDay = DateTime(2025, 8, 1);
  DateTime? selectedDay;

  final Set<DateTime> streakDays = {DateTime(2025, 8, 1), DateTime(2025, 8, 3), DateTime(2025, 8, 10), DateTime(2025, 8, 15)};

  final Set<DateTime> thisWeekDays = {
    DateTime(2025, 8, 10),
    DateTime(2025, 8, 11),
    DateTime(2025, 8, 12),
    DateTime(2025, 8, 13),
    DateTime(2025, 8, 14),
    DateTime(2025, 8, 15),
    DateTime(2025, 8, 16),
  };

  bool isSameDayCustom(DateTime a, DateTime b) => a.year == b.year && a.month == b.month && a.day == b.day;

  DateTime getWeekStart(DateTime date) => date.subtract(Duration(days: 1 + date.weekday % 7));
  DateTime getWeekEnd(DateTime date) => date.add(Duration(days: 6 - (date.weekday % 7)));

  @override
  void initState() {
    // TODO: implement initState
    controller.addListener(scrollListener);
    super.initState();
  }

  void scrollListener() {
    if (controller.offset > 0 && !isScrolled) {
      setState(() {
        isScrolled = true;
      });
    } else if (controller.offset <= 0 && isScrolled) {
      setState(() {
        isScrolled = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    DateTime today = DateTime.now();
    DateTime weekStart = getWeekStart(today);
    DateTime weekEnd = getWeekEnd(today);

    return Scaffold(
      backgroundColor: AppColors.grayBackground,
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: AppColors.white,
              boxShadow: isScrolled ? [BoxShadow(color: AppColors.lightGray, blurRadius: 1, offset: const Offset(0, 2))] : null,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                  decoration: BoxDecoration(color: AppColors.orange, borderRadius: BorderRadius.circular(12.r)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Computer Basics', style: StyleHelper.customStyle(color: AppColors.white, size: 16.sp, family: 'semiBold')),
                      Text('COMPUTER SCIENCE(BSCS)', style: StyleHelper.customStyle(color: AppColors.white.withOpacity(0.7), size: 12.sp)),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Image.asset(AppImages.bee, height: 24.h, width: 36.w, fit: BoxFit.cover),
                    Text('MCQsLearn', style: StyleHelper.customStyle(color: AppColors.black, size: 16.sp, family: 'medium')),
                  ],
                ),
              ],
            ).paddingOnly(top: 40.h, right: 16.w, left: 16.w, bottom: 10.h),
          ),
          if (isScrolled == false) Container(color: AppColors.lightGray, height: 1.h),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: Get.width,
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      boxShadow: [BoxShadow(color: AppColors.gray.withOpacity(0.5), blurRadius: 4, offset: const Offset(0, 2))],
                    ),
                    padding: EdgeInsets.all(16.sp),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Text(
                            'Hemaxi Akabari',
                            textAlign: TextAlign.center,
                            style: StyleHelper.customStyle(color: AppColors.black, size: 24.sp, family: semiBold),
                          ),
                        ).paddingOnly(bottom: 8.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Icon(Icons.email_outlined, size: 24.sp, color: AppColors.gray).paddingOnly(right: 6.w),
                                    Text(
                                      'hemaxipatel768@gmail.com',
                                      style: StyleHelper.customStyle(color: AppColors.gray, size: 12.sp, family: medium),
                                    ),
                                  ],
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      height: 24.h,
                                      width: 24.w,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12.r),
                                        image: DecorationImage(image: AssetImage(AppImages.indFlag)),
                                      ),
                                    ).paddingOnly(right: 6.w),
                                    Text('India', style: StyleHelper.customStyle(color: AppColors.gray, size: 12.sp, family: medium)),
                                  ],
                                ),
                              ],
                            ),
                            GestureDetector(onTap: (){
                              Get.to(()=>SettingsScreen(),transition: Transition.leftToRight,duration: Duration(milliseconds: 1000));

                            }, child: Icon(Icons.settings, size: 30.sp, color: AppColors.blue).paddingOnly(right: 8.w)),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Streaks', style: StyleHelper.customStyle(color: AppColors.black, size: 20.sp, family: semiBold)),
                      Text('This month', style: StyleHelper.customStyle(color: AppColors.gray, size: 14.sp, family: medium)),
                    ],
                  ).paddingOnly(top: 16.h, left: 16.w, right: 16.w, bottom: 16.h),
                  Container(
                    width:Get.width,
                    margin:  EdgeInsets.symmetric(horizontal: 16.w),
                    padding: EdgeInsets.symmetric(horizontal: 16.w,vertical: 8.h),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(24.r),
                    ),
                    child: Column(
                      children: [
                        Text(DateFormat('MMMM yyyy').format(focusedDay), style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),).paddingOnly(bottom: 16.h),
                        TableCalendar(
                          firstDay: DateTime.utc(2020, 1, 1),
                          lastDay: DateTime.utc(2030, 12, 31),
                          focusedDay: focusedDay,
                          selectedDayPredicate: (day) => isSameDayCustom(selectedDay ?? DateTime.now(), day),
                          onDaySelected: (selectDay, focusDay) {
                            setState(() {
                              selectedDay = selectDay;
                              focusedDay = focusDay;
                            });
                          },
                          onPageChanged: (focusDay) {
                            setState(() {
                              focusedDay = focusDay;
                            });
                          },
                          calendarFormat: CalendarFormat.month,
                          headerVisible: false,
                          rowHeight: 35.h,
                          sixWeekMonthsEnforced: false,

                          daysOfWeekStyle: DaysOfWeekStyle(
                            weekdayStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.sp, color: AppColors.darkGray),
                            weekendStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.sp, color: AppColors.darkGray),
                          ),

                          calendarBuilders: CalendarBuilders(
                            defaultBuilder: (context, day, focusedDay) {
                              bool isStreak = streakDays.any((d) => isSameDayCustom(d, day));
                              bool isCurrentWeek = !day.isBefore(weekStart) && !day.isAfter(weekEnd);
                              BorderRadius? radius;
                              if (isCurrentWeek) {
                                if (day.weekday == DateTime.sunday) {
                                  radius = BorderRadius.only(topLeft: Radius.circular(24.r), bottomLeft: Radius.circular(24.r));
                                } else if (day.weekday == DateTime.saturday) {
                                  radius = BorderRadius.only(topRight: Radius.circular(24.r), bottomRight: Radius.circular(24.r));
                                }
                              }
                              return Container(
                                margin: EdgeInsets.zero,
                                padding: EdgeInsets.zero,
                                decoration: BoxDecoration(
                                    color: isCurrentWeek ? AppColors.disableButton : null,
                                    borderRadius: radius
                                ),
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      if (isStreak)
                                        SvgPicture.asset(AppImages.fireIcon, height: 20.h, width: 20.w)
                                      else
                                        Text(
                                          '${day.day}',
                                          style: StyleHelper.customStyle(
                                            color: isCurrentWeek ? AppColors.blue : AppColors.black,
                                            size: 14.sp,
                                            family: bold,
                                            height: 1.0,
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                              );
                            },
                            todayBuilder: (context, day, focusedDay) {
                              return Container(
                                  margin: EdgeInsets.zero,
                                  padding: EdgeInsets.zero,
                                  decoration: BoxDecoration(color: AppColors.lightGray),
                                  child: Center(
                                      child: Text(
                                        '${day.day}',
                                        style: TextStyle(height: 1.0),
                                      )
                                  )
                              );
                            },
                            selectedBuilder: (context, day, focusedDay) {
                              return Container(
                                margin: EdgeInsets.zero,
                                padding: EdgeInsets.zero,
                                decoration: BoxDecoration(color: AppColors.lightGray),
                                child: Center(
                                    child: Text(
                                        '${day.day}',
                                        style: TextStyle(
                                          color: AppColors.blue,
                                          fontWeight: FontWeight.bold,
                                          height: 1.0,
                                        )
                                    )
                                ),
                              );
                            },
                          ),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              height: 50.h,
                              width: 50.w,
                              padding: EdgeInsets.all(8.sp),
                              decoration: BoxDecoration(shape: BoxShape.circle, color: AppColors.disableButton),
                              child:  SvgPicture.asset(AppImages.fireIcon, height: 30.h, width: 30.w),
                            ),
                            Expanded(
                              child: Container(
                                height: 4.h,
                                decoration: BoxDecoration(
                                  color: AppColors.disableButton,
                                  borderRadius: BorderRadius.only(bottomRight: Radius.circular(12.r), topLeft: Radius.circular(12.r)),
                                ),
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text('1',
                                  style: TextStyle(
                                    color: AppColors.red,
                                    fontSize: 40.sp,
                                    fontFamily: bold,
                                    shadows: <Shadow>[Shadow(blurRadius: 12.r, color: AppColors.red.withOpacity(0.5), offset: Offset(-2.0, 2.0))],
                                  ),
                                ).paddingSymmetric(horizontal: 8.w),
                                Text(
                                  'Current\n Streak',
                                  style: TextStyle(color: AppColors.gray, fontSize: 12.sp, fontFamily: semiBold, height: 1.h),
                                  maxLines: null,
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                            Expanded(
                              child: Container(
                                height: 4.h,
                                decoration: BoxDecoration(color: AppColors.amberOrange, borderRadius: BorderRadius.circular(12.r)),
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text('1', style: TextStyle(color: AppColors.black, fontSize: 40.sp, fontFamily: bold),).paddingSymmetric(horizontal: 8.w),
                                Text('Longest\n Streak',
                                  style: TextStyle(color: AppColors.gray, fontSize: 12.sp, fontFamily: semiBold, height: 1.h),
                                  maxLines: null,
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ).paddingOnly(bottom: 8.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Statistics',style: StyleHelper.customStyle(color: AppColors.black,size: 18.sp,family: bold)),
                      Text('This month',style: StyleHelper.customStyle(color: AppColors.gray,size: 14.sp,family: semiBold),)
                    ],
                  ).paddingSymmetric(horizontal: 16.w,vertical: 8.h),
                  Container(
                    padding: EdgeInsets.all(16.sp),
                    margin: EdgeInsets.symmetric(horizontal: 16.w),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(color: AppColors.lightGray)
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                       Row(
                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                         children: [
                           Text('Highest Score',style: StyleHelper.customStyle(color: AppColors.black,size: 14.sp,family: semiBold)),
                           Text('Mon, 04 Aug 2025',style: StyleHelper.customStyle(color: AppColors.darkGray,size: 12.sp,family: semiBold)),
                         ],
                       ),
                       Divider(thickness: (0.5).w,color: AppColors.black).paddingSymmetric(vertical: 4.h),
                       Text('Application of Computers',style: StyleHelper.customStyle(color: AppColors.black,size: 14.sp,family: semiBold)).paddingOnly(bottom: 10.h),
                       Row(
                         children: [
                           Text('80',style: StyleHelper.customStyle(color: AppColors.green,size: 20.sp,family: bold)),
                           Text(' out of 100',style: StyleHelper.customStyle(color: AppColors.gray,size: 12.sp,family: semiBold),)
                         ],
                       ).paddingOnly(bottom: 8.h),
                       Row(
                         children: [
                           Expanded(
                             flex: 8,
                             child: Container(
                               height: 4.h,
                               decoration: BoxDecoration(
                                 color: AppColors.green,
                                 borderRadius: BorderRadius.only(topLeft: Radius.circular(8.r), bottomLeft: Radius.circular(8.r)),
                               ),
                             ),
                           ),
                           Expanded(flex: (0 + 1), child: Container(height:  4.h, color: AppColors.yellow)),
                           Expanded(
                             flex: 2,
                             child: Container(
                               height:  4.h,
                               decoration: BoxDecoration(
                                 color: AppColors.red,
                                 borderRadius: BorderRadius.only(topRight: Radius.circular(8.r), bottomRight: Radius.circular(8.r)),
                               ),
                             ),
                           ),
                         ],
                       ).paddingOnly(bottom: 10.h),
                       Container(
                         padding: EdgeInsets.all(16.sp),
                         decoration: BoxDecoration(
                           borderRadius: BorderRadius.circular(12.r),
                           color: AppColors.disableButton,
                         ),
                         child: Row(
                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                           children: [
                             Row(
                               children: [
                                 Icon(Icons.access_time_outlined,size: 24.sp,color: AppColors.darkGray).paddingOnly(right: 8.w),
                                 Text('Time Taken:',style: StyleHelper.customStyle(color: AppColors.darkGray,size: 14.sp,family: medium),)
                               ],
                             ),
                             Text('04:36',style: StyleHelper.customStyle(color: AppColors.red,size: 20.sp,family: semiBold),)
                           ],
                         ),
                       ),

                     ],
                    ),
                  ),
                  Text('Go Premium',style: StyleHelper.customStyle(color: AppColors.black,size: 18.sp,family: semiBold)).paddingSymmetric(vertical: 8.h,horizontal: 16.w),
                  Container(
                    padding: EdgeInsets.all(16.sp),
                    margin: EdgeInsets.symmetric(horizontal: 16.w),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(color: AppColors.lightGray,width: 1.w),
                      color: AppColors.white
                    ),
                    child: Column(
                      children: [
                        Text('MCQsLearn+',style: StyleHelper.customStyle(color: AppColors.green,size: 18.sp,family: semiBold)).paddingOnly(bottom: 10.h),
                        Text('Try ad-free premium version with unlimited coins today!',style: StyleHelper.customStyle(color: AppColors.black,size: 14.sp,family: medium),textAlign: TextAlign.center,maxLines: null,).paddingOnly(bottom: 10.h),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 16.w,vertical: 8.h),
                          decoration: BoxDecoration(
                            color: AppColors.blue,
                            borderRadius: BorderRadius.circular(12.r)
                          ),
                          child: Text('Go Premium!',style: StyleHelper.customStyle(color: AppColors.white,size: 14.sp,family: semiBold),),
                        )
                      ],
                    ),
                  ).paddingOnly(bottom: 16.h),
                  Text('E-Book',style: StyleHelper.customStyle(color: AppColors.black,size: 18.sp,family: semiBold)).paddingSymmetric(vertical: 8.h,horizontal: 16.w),
                  Container(
                    padding: EdgeInsets.all(16.sp),
                    margin: EdgeInsets.symmetric(horizontal: 16.w),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(color: AppColors.lightGray,width: 1.w)
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Are you a bookworm?',style: StyleHelper.customStyle(color: AppColors.gray,size: 12.sp,family: semiBold)),
                              Text('We got a great solution for you!',
                                  maxLines: null,
                                  textAlign: TextAlign.start,
                                  style: StyleHelper.customStyle(color: AppColors.black,size: 14.sp,family: semiBold)),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 16.w,vertical: 8.h),
                          decoration: BoxDecoration(
                            color: AppColors.amberYellow,
                            borderRadius: BorderRadius.circular(12.r)
                          ),
                          child: Text('Try books',style: StyleHelper.customStyle(color: AppColors.black,size: 14.sp,family: semiBold),),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 50.h),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
