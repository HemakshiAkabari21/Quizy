import 'package:quizy/app_theme/app_colors.dart';
import 'package:quizy/app_theme/style_helper.dart';
import 'package:quizy/model/histroy_model.dart';
import 'package:quizy/screens/filter_screen/filter_screen.dart';
import 'package:quizy/utils/const_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  final ScrollController controller = ScrollController();
  bool isScrolled = false;
  RxString selectedSort = 'Date (Latest First)'.obs;

  List<HistoryModel> history = [
    HistoryModel(
      dayTime: 'Mon, 11 Aug 2025',
      topic: 'Introduction',
      percentage: 40,
      correctAnswer: 4,
      skippedAnswer: 0,
      wrongAnswer: 6,
      timeTaken: '00:46',
    ),
    HistoryModel(
      dayTime: 'Mon, 11 Aug 2025',
      topic: 'Introduction',
      percentage: 30,
      correctAnswer: 3,
      skippedAnswer: 0,
      wrongAnswer: 7,
      timeTaken: '04:52',
    ),
    HistoryModel(
      dayTime: 'Fri, 08 Aug 2025',
      topic: 'Introduction',
      percentage: 20,
      correctAnswer: 2,
      skippedAnswer: 0,
      wrongAnswer: 8,
      timeTaken: '05:00',
    ),
    HistoryModel(
      dayTime: 'Mon, 04 Aug 2025',
      topic: 'Applications of Computers',
      percentage: 80,
      correctAnswer: 8,
      skippedAnswer: 0,
      wrongAnswer: 2,
      timeTaken: '04:36',
    ),
    HistoryModel(
      dayTime: 'Fri, 01 Aug 2025',
      topic: 'Introduction',
      percentage: 20,
      correctAnswer: 2,
      skippedAnswer: 8,
      wrongAnswer: 0,
      timeTaken: '00:46',
    ),
    HistoryModel(
      dayTime: 'Fri, 01 Aug 2025',
      topic: 'Introduction',
      percentage: 40,
      correctAnswer: 4,
      skippedAnswer: 0,
      wrongAnswer: 6,
      timeTaken: '00:53',
    ),
  ];

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
    return Scaffold(
      backgroundColor: AppColors.grayBackground,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              color: AppColors.grayBackground,
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
          ).paddingOnly(bottom: 8.h),
          Expanded(
            child: SingleChildScrollView(
              controller: controller,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Previous Attempts',
                    style: StyleHelper.customStyle(color: AppColors.blackText, size: 20.sp, family: semiBold),
                  ).paddingOnly(bottom: 10.h),
                  Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: (){
                            Get.bottomSheet(shortCard(),isScrollControlled: true);
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 10.h),
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(12.r), color: AppColors.white),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.arrow_downward),
                                Icon(Icons.sort),
                                SizedBox(width: 4.w),
                                Text('Sort', style: StyleHelper.customStyle(color: AppColors.blackText, size: 16.sp, family: semiBold)),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 8.w),
                      Expanded(
                        child: GestureDetector(
                          onTap: (){
                            Get.to(()=>FilterScreen(),transition: Transition.downToUp);
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 10.h),
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(12.r), color: AppColors.white),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.filter_alt_outlined),
                                SizedBox(width: 8.w),
                                Text('Filter', style: StyleHelper.customStyle(color: AppColors.blackText, size: 16.sp, family: semiBold)),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ).paddingOnly(bottom: 16.h),
                  ListView.builder(
                    shrinkWrap: true,
                    padding: EdgeInsets.only(bottom: 16.h),
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: history.length,
                    itemBuilder: (context, index) {
                      final historyData = history[index];
                      return historyCard(historyData: historyData);
                    },
                  ),
                ],
              ).paddingSymmetric(horizontal: 16.w),
            ),
          ),
        ],
      ),
    );
  }

  Widget historyCard({required HistoryModel historyData}) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(12.r),
            border: Border(left: BorderSide(color: AppColors.red, width: 5.w)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Attempted on:', style: StyleHelper.customStyle(color: AppColors.darkGray, size: 14.sp, family: medium)),
                  Text(historyData.dayTime, style: StyleHelper.customStyle(color: AppColors.darkGray, size: 14.sp, family: medium)),
                ],
              ).paddingOnly(bottom: 4.h),
              Divider(thickness: (1.5).w, color: AppColors.black),
              Text(historyData.topic, style: StyleHelper.customStyle(color: AppColors.black, size: 16.sp, family: semiBold)),
              Text('${historyData.percentage}', style: StyleHelper.customStyle(color: AppColors.red, size: 40.sp, family: semiBold)),
              Row(
                children: [
                  Expanded(
                    flex: historyData.correctAnswer,
                    child: Container(
                      height: 8,
                      decoration: BoxDecoration(
                        color: AppColors.green,
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(8.r), bottomLeft: Radius.circular(8.r)),
                      ),
                    ),
                  ),
                  Expanded(flex: (historyData.skippedAnswer + 1), child: Container(height: 8, color: AppColors.yellow)),
                  Expanded(
                    flex: historyData.wrongAnswer,
                    child: Container(
                      height: 8,
                      decoration: BoxDecoration(
                        color: AppColors.red,
                        borderRadius: BorderRadius.only(topRight: Radius.circular(8.r), bottomRight: Radius.circular(8.r)),
                      ),
                    ),
                  ),
                ],
              ).paddingOnly(bottom: 8.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Time Taken:', style: StyleHelper.customStyle(color: AppColors.darkGray, size: 14.sp, family: semiBold)),
                  Text(historyData.timeTaken, style: StyleHelper.customStyle(color: AppColors.green, size: 14.sp, family: semiBold)),
                ],
              ),
            ],
          ).paddingAll(16.sp),
        ),
        SizedBox(height: 16.h,)
      ],
    );
  }

  Widget shortCard() {
    List<String> sortList = [
      'Date (Latest First)',
      'Date (Oldest First)',
      'Score (Highest First)',
      'Score (Lowest First)',
      'Time Taken(Shortest First)',
      'Time Taken(Longest First)'
    ];

    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(16.sp),
        decoration: BoxDecoration(
          color: AppColors.grayBackground,
          border: Border.all(color: AppColors.gray, width: 1.w),
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(24.r),
            topLeft: Radius.circular(24.r),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Sort', style: StyleHelper.customStyle(color: AppColors.black, size: 24.sp, family: semiBold)),
                GestureDetector(
                  onTap: (){
                    Get.back();
                  },
                    child: Icon(Icons.close, size: 24.sp, color: AppColors.black)),
              ],
            ),
            Divider(thickness: 1.w, color: AppColors.black),
            ListView.builder(
              itemCount: sortList.length,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    selectedSort.value = sortList[index];
                    Get.back();
                  },
                  child: Container(
                    width: Get.width,
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(vertical: 8.h,horizontal: 16.w),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Row(
                      children: [
                        if (selectedSort.value == sortList[index])
                          Icon(Icons.check_circle, color: AppColors.green, size: 24.sp),
                        if (selectedSort.value == sortList[index])
                          SizedBox(width: 8.w), // spacing between icon and text
                        Expanded(
                          child: Text(
                            sortList[index],
                            style: StyleHelper.customStyle(
                              color: AppColors.black,
                              size: 14.sp,
                              family: medium,
                            ),
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ).paddingOnly(bottom: 8.h),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

}
