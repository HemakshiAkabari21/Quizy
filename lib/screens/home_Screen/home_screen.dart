import 'dart:convert';

import 'package:animated_loader_demo_flutter/app_theme/app_colors.dart';
import 'package:animated_loader_demo_flutter/app_theme/style_helper.dart';
import 'package:animated_loader_demo_flutter/model/quiz_type_model.dart';
import 'package:animated_loader_demo_flutter/model/week_model.dart';
import 'package:animated_loader_demo_flutter/screens/quiz_screen/quiz_screen.dart';
import 'package:animated_loader_demo_flutter/utils/const_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  final Function(int)? onTabChange;
  const HomeScreen({super.key, required this.onTabChange});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController controller = ScrollController();
  final searchController = TextEditingController();
  bool isScrolled = false;

  List<WeekModel> streakData = [
    WeekModel(weekDaysName: 'Mon', value: 'Not Attempt'),
    WeekModel(weekDaysName: 'Tue', value: 'Not Attempt'),
    WeekModel(weekDaysName: 'Wed', value: 'Not Attempt'),
    WeekModel(weekDaysName: 'Thu', value: 'Not Attempt'),
    WeekModel(weekDaysName: 'Fri', value: 'Attempt'),
    WeekModel(weekDaysName: 'Sat', value: 'Remaining'),
    WeekModel(weekDaysName: 'Sun', value: 'Remaining'),
  ];

  List<QuizModel> topicList = [
    QuizModel(quizTopic: 'Introduction', accuracy: 30, attempts: 2),
    QuizModel(quizTopic: 'Application of Computers', accuracy: 80, attempts: 1),
    QuizModel(quizTopic: 'Interacting with Computer', accuracy: 75, attempts: 1),
    QuizModel(quizTopic: 'Basics of Information Technology', accuracy: 40, attempts: 1),
    QuizModel(quizTopic: 'Computer Architecture', accuracy: 68, attempts: 1),
    QuizModel(quizTopic: 'Data Storage', accuracy: 0, attempts: 0),
    QuizModel(quizTopic: 'Processing Data', accuracy: 0, attempts: 0),
    QuizModel(quizTopic: 'Displaying & Printing Data', accuracy: 0, attempts: 0),
    QuizModel(quizTopic: 'Windows Operating System', accuracy: 0, attempts: 0),
    QuizModel(quizTopic: 'Application Software', accuracy: 0, attempts: 0),
    QuizModel(quizTopic: 'Word Processing', accuracy: 0, attempts: 0),
    QuizModel(quizTopic: 'Spreadsheet Programs', accuracy: 0, attempts: 0),
    QuizModel(quizTopic: 'Internet Fundamentals', accuracy: 0, attempts: 0),
    QuizModel(quizTopic: 'Computer Networks', accuracy: 0, attempts: 0),
    QuizModel(quizTopic: 'Data Communication', accuracy: 0, attempts: 0),
    QuizModel(quizTopic: 'Internet Technology', accuracy: 0, attempts: 0),
    QuizModel(quizTopic: 'Data Protection & Copyrights', accuracy: 0, attempts: 0),
  ];

  RxList<QuizModel> filterList = <QuizModel>[].obs;

  @override
  void initState() {
    super.initState();
    controller.addListener(scrollListener);
    filterList.assignAll(topicList);
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

  void searchQuery(String value) {
    final query = value.toLowerCase();
    if (query.isEmpty) {
      filterList.assignAll(topicList);
    } else {
      filterList.value =
          topicList.where((store) {
            return store.quizTopic.toString().toLowerCase().contains(query);
          }).toList();
    }
    print('filter stored list: ${jsonEncode(filterList)}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.grayBackground,
      body: Column(
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
          ),
          Expanded(
            child: SingleChildScrollView(
              controller: controller,
              child: Column(
                children: [
                  dailyStack().paddingOnly(bottom: 16.h),
                  chooseATopic(),

                  SizedBox(height: 10.h,)
                ],
              ),
            ).paddingSymmetric(horizontal: 16.w),
          ),
        ],
      ),
    );
  }

  Widget dailyStack() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Daily Streak', style: StyleHelper.customStyle(color: AppColors.black, size: 18.sp, family: semiBold)),
            Text('This Week', style: StyleHelper.customStyle(color: AppColors.gray, size: 12.sp, family: semiBold)),
          ],
        ),
        Container(
          margin: EdgeInsets.only(top: 10.h),
          padding: EdgeInsets.all(16.sp),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: AppColors.lightGray, width: 1.w),
            color: AppColors.white,
          ),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 6.h, horizontal: 8.w),
                decoration: BoxDecoration(color: AppColors.lightGray.withOpacity(0.5), borderRadius: BorderRadius.circular(12.r)),
                child: SizedBox(
                  height: 28.h,
                  child: ListView.builder(
                    itemCount: streakData.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return streakData[index].value == 'Not Attempt'
                          ? SvgPicture.asset(AppImages.crossIcon, height: 16.h, width: 16.w, color: AppColors.red).paddingSymmetric(horizontal: 12.w)
                          : streakData[index].value == 'Attempt'
                          ? SvgPicture.asset(AppImages.fireIcon, height: 28.h, width: 28.w).paddingSymmetric(horizontal: 8.w)
                          : SizedBox.shrink();
                    },
                  ),
                ),
              ),
              SizedBox(height: 8.h),
              SizedBox(
                height: 24.h,
                child: ListView.builder(
                  itemCount: streakData.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Text(
                      streakData[index].weekDaysName ?? '',
                      style: StyleHelper.customStyle(color: AppColors.gray, size: 14.sp, family: semiBold),
                    ).paddingSymmetric(horizontal: (7.5).w);
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget chooseATopic() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Choose a topic', style: StyleHelper.customStyle(color: AppColors.black, size: 18.sp, family: semiBold)),
            Container(
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(12.r), color: AppColors.white,border: Border.all(color: AppColors.red, width: 1.w)),
              child: Row(
                children: [
                  SvgPicture.asset(AppImages.starIcon, height: 16.h, width: 16.w).paddingOnly(right: 16.w),
                  Text('0', style: StyleHelper.customStyle(color: AppColors.red, size: 14.sp)).paddingOnly(right: 6.w),
                ],
              ),
            ),
          ],
        ).paddingOnly(bottom: 8.h),
        Container(
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: AppColors.lightGray, width: 1.w),
            boxShadow: [
              BoxShadow(color: AppColors.lightGray, blurRadius: 1, offset: const Offset(0, 2))
            ]
          ),
          child: TextFormField(
            controller: searchController,
            cursorColor: AppColors.gray,
            decoration: InputDecoration(
              border: OutlineInputBorder(borderSide: BorderSide.none),
              prefixIcon: Icon(Icons.search, size: 24.sp, color: AppColors.gray),
              hintText: 'Search a topic...',
              hintStyle: StyleHelper.customStyle(color: AppColors.gray, size: 14.sp, family: semiBold),
              contentPadding: EdgeInsets.zero, // Remove default content padding
            ),
            onChanged: (value) {
              searchQuery(value);
            },
          ),
        ).paddingOnly(bottom: 10.h),


        Obx(() => ListView.builder(
          padding: EdgeInsets.zero, // Remove default ListView padding
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: filterList.length,
          itemBuilder: (context, index) {
            return topicCard(filterList[index]).paddingSymmetric(vertical: 5.h);
          },
        )),
      ],
    );
  }


  Widget topicCard(QuizModel quizModel) {
    return GestureDetector(
      onTap: () {
        Get.to(()=>QuizScreen());
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: ((quizModel.accuracy ?? 0) <= 0) ? Colors.transparent : ((quizModel.accuracy ?? 0) <=40) ? AppColors.red : ((quizModel.accuracy ?? 0) <= 70) ? Colors.amber :AppColors.green,width: (0.5).w),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              quizModel.quizTopic ?? '',
              style: StyleHelper.customStyle(color: AppColors.black, size: 14.sp, family: semiBold),
            ).paddingOnly(bottom: 2.h),
            Text('Attempts:${quizModel.attempts.toString()}',
                style: StyleHelper.customStyle(color: AppColors.gray, size: 14.sp, family: semiBold)),
            Text(
              'Accuracy:${quizModel.accuracy.toString()}',
              style: StyleHelper.customStyle(color: AppColors.gray, size: 14.sp, family: semiBold),
            ).paddingOnly(bottom: 4.h),
            if(quizModel.accuracy != 0)
            ProgressIndicatorTheme(
              data: ProgressIndicatorThemeData(color: AppColors.red, borderRadius: BorderRadius.circular(12.r)),
              child: Container(
                height: 10.h,
                width: ((double.tryParse(quizModel.accuracy.toString()) ?? 0.0) * 3).w,
                decoration: BoxDecoration(color:((quizModel.accuracy ?? 0) <= 0)
                          ? Colors.transparent
                          : ((quizModel.accuracy ?? 0) <=40)
                          ? AppColors.red
                          : ((quizModel.accuracy ?? 0) <= 70) ? Colors.amber :AppColors.green, borderRadius: BorderRadius.circular(12.r)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    controller.removeListener(scrollListener);
    controller.dispose();
    super.dispose();
  }
}
