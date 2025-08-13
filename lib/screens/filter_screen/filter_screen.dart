import 'package:quizy/app_theme/app_colors.dart';
import 'package:quizy/app_theme/style_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({super.key});

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  final score1 = TextEditingController();
  final score2 = TextEditingController();
  bool isScrolled = false;
  final ScrollController controller = ScrollController();

  RxBool isShowMore = false.obs;

  RxList<String> selectedTopics = <String>[].obs;

  List<String> topicList = [
    'Introduction', 'Application of Computers', 'Interacting with Computer',
    'Basics of Information Technology', 'Computer Architecture', 'Data Storage',
    'Processing Data', 'Displaying & Printing Data', 'Operating Systems',
    'Windows Operating System', 'Application Softwares', 'Word Processing',
    'Spreadsheet Programs', 'Internet Fundamentals', 'Computer Networks',
    'Data Communication', 'Internet Technology', 'Data Protection & Copyrights',
  ];

  @override
  void initState() {
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

  void toggleTopicSelection(String topic) {
    if (selectedTopics.contains(topic)) {
      selectedTopics.remove(topic);
    } else {
      selectedTopics.add(topic);
    }
  }

  void resetFilters() {
    selectedTopics.clear();
    score1.clear();
    score2.clear();
    setState(() {});
  }

  void applyFilters() {
    print('Selected Topics: ${selectedTopics.toList()}');
    print('Score Range: ${score1.text} - ${score2.text}');
    Get.back();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.grayBackground,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 30.h,),
          Container(
            decoration: BoxDecoration(
              color: AppColors.grayBackground,
              boxShadow: isScrolled ? [BoxShadow(color: AppColors.lightGray, blurRadius: 1, offset: const Offset(0, 2))] : null,
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(),
                    GestureDetector(
                        onTap: () { Get.back(); },
                        child: Icon(Icons.close, size: 34.sp, color: AppColors.black)
                    ),
                  ],
                ).paddingOnly(left: 16.w, right: 16.w),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Filter', style: StyleHelper.customStyle(color: AppColors.black, size: 20.sp, family: semiBold)),
                    GestureDetector(
                      onTap: resetFilters,
                      child: Text('Reset', style: StyleHelper.customStyle(color: AppColors.blue, size: 14.sp, family: semiBold)),
                    ),
                  ],
                ).paddingOnly(bottom: 16.h, left: 16.w, right: 16.w),
                if(isScrolled == false)
                  Divider(thickness: 1.w, color: AppColors.grayBorder),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              controller: controller,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Topics', style: StyleHelper.customStyle(color: AppColors.darkGray, size: 14.sp, family: medium)).paddingSymmetric(horizontal: 16.w),
                  Obx(() => ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: (!isShowMore.value) ? 4 : topicList.length,
                    itemBuilder: (context, index) {
                      String topic = topicList[index];
                      bool isSelected = selectedTopics.contains(topic);
                      return GestureDetector(
                        onTap: () {
                          toggleTopicSelection(topic);
                          setState(() {});
                        },
                        child: Padding(
                          padding:  EdgeInsets.symmetric(vertical: 4.h),
                          child: Row(
                            children: [
                              Icon(
                                  isSelected ? Icons.check_box : Icons.check_box_outline_blank,
                                  size: 24.sp,
                                  color: isSelected ? AppColors.blue : AppColors.gray.withOpacity(0.6)
                              ).paddingOnly(right: 16.w),
                              Expanded(
                                child: Text(
                                    topic,
                                    style: StyleHelper.customStyle(
                                        color: isSelected ? AppColors.blue : AppColors.black,
                                        size: 14.sp,
                                        family: medium
                                    )
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  )).paddingSymmetric(horizontal: 16.w),
                  SizedBox(height: 20.h),
                  GestureDetector(
                    onTap: () {
                      isShowMore.toggle();
                    },
                    child: Center(
                      child: Text(
                        (!isShowMore.value) ? 'Show More' : 'Show Less',
                        style: StyleHelper.customStyle(color: AppColors.blue, size: 16.sp, family: semiBold),
                      ),
                    ),
                  ).paddingSymmetric(horizontal: 16.w),
                  Divider(thickness: 1.w, color: AppColors.black),
                  Text('Score', style: StyleHelper.customStyle(color: AppColors.gray, size: 16.sp, family: semiBold)).paddingOnly(bottom: 16.h, left: 16.w, right: 16.w),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppColors.white,
                            borderRadius: BorderRadius.circular(12.r),
                            boxShadow: [BoxShadow(color: AppColors.lightGray, blurRadius: 4, offset: const Offset(0, 2))],
                          ),
                          child: TextFormField(
                              controller: score1,
                              cursorColor: AppColors.grayBorder,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                hintText: '0',
                                border: OutlineInputBorder(borderSide: BorderSide.none),
                                contentPadding: EdgeInsets.all(12.sp),
                              )
                          ),
                        ),
                      ),
                      SizedBox(width: 16.w),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppColors.white,
                            borderRadius: BorderRadius.circular(12.r),
                            boxShadow: [BoxShadow(color: AppColors.lightGray, blurRadius: 4, offset: const Offset(0, 2))],
                          ),
                          child: TextFormField(
                              controller: score2,
                              cursorColor: AppColors.grayBorder,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                hintText: '100',
                                border: OutlineInputBorder(borderSide: BorderSide.none),
                                contentPadding: EdgeInsets.all(12.sp),
                              )
                          ),
                        ),
                      ),
                    ],
                  ).paddingSymmetric(horizontal: 16.w),
                  SizedBox(height: 50.h),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        width: Get.width,
        padding: EdgeInsets.all(16.sp),
        decoration: BoxDecoration(
          color: AppColors.white,
          boxShadow: [ BoxShadow(color: AppColors.lightGray, blurRadius: 4, offset: const Offset(0, -2))]
        ),
        child: GestureDetector(
          onTap: applyFilters,
          child: Container(
            width: Get.width,
            padding: EdgeInsets.symmetric(vertical: 16.h),
            decoration: BoxDecoration(color: AppColors.blue, borderRadius: BorderRadius.circular(12.r)),
            child: Text(
              'Apply Filters',
              style: StyleHelper.customStyle(color: AppColors.white, size: 16.sp, family: semiBold),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    score1.dispose();
    score2.dispose();
    super.dispose();
  }
}