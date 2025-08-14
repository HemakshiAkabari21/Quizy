import 'dart:async';
import 'package:quizy/app_theme/app_colors.dart';
import 'package:quizy/app_theme/style_helper.dart';
import 'package:quizy/model/quiz_model.dart';
import 'package:quizy/screens/result_screen/result_screen.dart';
import 'package:quizy/widgets/animated_time_up.dart';
import 'package:quizy/widgets/custom_loading_indicatore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> with TickerProviderStateMixin {
  List<QuizModel> questionList = [
    QuizModel(
      question: 'Emerging higher performance of superminis were',
      userAnswer: '',
      answer: [Answer(answer: '32-bit'), Answer(answer: '16-bit'), Answer(answer: '12-bit'), Answer(answer: '64-bit')],
    ),
    QuizModel(
      question: 'Which planet is known as the Red Planet?',
      userAnswer: '',
      answer: [Answer(answer: 'Earth'), Answer(answer: 'Mars'), Answer(answer: 'Venus'), Answer(answer: 'Jupiter')],
    ),
    QuizModel(
      question: 'What is the capital of Japan?',
      userAnswer: '',
      answer: [Answer(answer: 'Tokyo'), Answer(answer: 'Kyoto'), Answer(answer: 'Osaka'), Answer(answer: 'Nagoya')],
    ),
    QuizModel(
      question: 'Who developed the theory of relativity?',
      userAnswer: '',
      answer: [Answer(answer: 'Isaac Newton'), Answer(answer: 'Albert Einstein'), Answer(answer: 'Nikola Tesla'), Answer(answer: 'Galileo Galilei')],
    ),
    QuizModel(
      question: 'What is the largest mammal in the world?',
      userAnswer: '',
      answer: [Answer(answer: 'African Elephant'), Answer(answer: 'Blue Whale'), Answer(answer: 'Giraffe'), Answer(answer: 'Hippopotamus')],
    ),
    QuizModel(
      question: 'In which year did World War II end?',
      userAnswer: '',
      answer: [Answer(answer: '1945'), Answer(answer: '1939'), Answer(answer: '1942'), Answer(answer: '1950')],
    ),
    QuizModel(
      question: 'Which gas do plants absorb from the atmosphere?',
      userAnswer: '',
      answer: [Answer(answer: 'Oxygen'), Answer(answer: 'Carbon Dioxide'), Answer(answer: 'Nitrogen'), Answer(answer: 'Helium')],
    ),
    QuizModel(
      question: 'What is the chemical symbol for gold?',
      userAnswer: '',
      answer: [Answer(answer: 'Ag'), Answer(answer: 'Au'), Answer(answer: 'Pb'), Answer(answer: 'Pt')],
    ),
    QuizModel(
      question: 'Which is the fastest land animal?',
      userAnswer: '',
      answer: [Answer(answer: 'Cheetah'), Answer(answer: 'Lion'), Answer(answer: 'Horse'), Answer(answer: 'Tiger')],
    ),
    QuizModel(
      question: 'How many continents are there on Earth?',
      userAnswer: '',
      answer: [Answer(answer: '5'), Answer(answer: '6'), Answer(answer: '7'), Answer(answer: '8')],
    ),
    QuizModel(
      question: 'Which is the smallest prime number?',
      userAnswer: '',
      answer: [Answer(answer: '1'), Answer(answer: '2'), Answer(answer: '3'), Answer(answer: '5')],
    ),
  ];

  PageController pageController = PageController();
  int currentIndex = 0;
  late AnimationController controller;
  late Timer _timer;
  bool isLoading = true;
  int currentQuestion = 1;
  int totalQuestions = 10;

  // Quiz duration in seconds (5 minutes = 300 seconds)
  int totalTimeInSeconds = 300;
  int remainingTimeInSeconds = 300;

  String get timeRemaining {
    int minutes = remainingTimeInSeconds ~/ 60;
    int seconds = remainingTimeInSeconds % 60;
    return "${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}";
  }

  double get progressValue {
    return remainingTimeInSeconds / totalTimeInSeconds;
  }

  bool get shouldBounce {
    return remainingTimeInSeconds <= 90;
  }

  Color get progressColor {
    if (remainingTimeInSeconds > 180) {
      // More than 3 minutes
      return AppColors.green;
    } else if (remainingTimeInSeconds > 90) {
      // More than 1.5 minutes
      return AppColors.amberOrange;
    } else {
      // 1.5 minutes or less
      return AppColors.red;
    }
  }

  @override
  void initState() {
    super.initState();
    controller = AnimationController(vsync: this, duration: const Duration(minutes: 5));

    Future.delayed(const Duration(seconds: 5), () {
      setState(() {
        isLoading = false;
      });
      startCountdownTimer();
    });
  }

  void startCountdownTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (remainingTimeInSeconds > 0) {
          remainingTimeInSeconds--;
        } else {
          timer.cancel();
          Get.dialog(const AnimatedTimeUpDialog(), barrierDismissible: false, barrierColor: Colors.black.withOpacity(0.6));
        }
      });
    });
  }

  /*void showTimeUpDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Time\'s Up!'),
          content: const Text('Your quiz time has ended.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                // Navigate back or submit quiz
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }*/

  @override
  void dispose() {
    controller.dispose();

    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return isLoading ? const Center(child: CustomLoadingIndicator()) : buildQuizUI();
  }

  Widget buildQuizUI() {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFFF5F5F5),
        body: Padding(
          padding: EdgeInsets.symmetric(vertical: 20.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Topic Header
              Text(
                'Topic: Introduction',
                style: TextStyle(color: Colors.grey[600], fontSize: 16.sp, fontWeight: FontWeight.w500),
              ).paddingOnly(bottom: 8.h).paddingSymmetric(horizontal: 16.w),
              // Timer Container
              Transform.scale(
                scale: 1.0,
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8.r),
                    boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 4, offset: const Offset(0, 2))],
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.access_time, color: progressColor, size: 30.sp),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            LinearProgressIndicator(
                              value: progressValue,
                              backgroundColor: Colors.grey[200],
                              valueColor: AlwaysStoppedAnimation<Color>(progressColor),
                              borderRadius: BorderRadius.circular(4.r),
                              minHeight: 6.h,
                            ),
                            Row(
                              children: [
                                Text('Time Remaining: ', style: TextStyle(color: Colors.grey[600], fontSize: 14.sp, fontWeight: FontWeight.w500)),
                                Text(timeRemaining, style: TextStyle(color: progressColor, fontSize: 14.sp, fontWeight: FontWeight.w500)),
                              ],
                            ).paddingOnly(top: 8.h),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ).paddingOnly(bottom: 16.h, right: 16.w, left: 16.w),

              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
                    decoration: BoxDecoration(
                      color: AppColors.white.withOpacity(0.9),
                      borderRadius: BorderRadius.circular(8.r),
                      border: Border.all(color: AppColors.blue),
                    ),
                    child: Text(
                      'Question ${currentIndex + 1}',
                      style: TextStyle(color: AppColors.blue, fontSize: 14.sp, fontWeight: FontWeight.w600),
                    ),
                  ).paddingOnly(right: 8.w),

                  Text('out of ${questionList.length}', style: TextStyle(color: Colors.grey[600], fontSize: 14.sp)),
                ],
              ).paddingOnly(bottom: 8.h, right: 16.w, left: 16.w),
              Divider(color: AppColors.gray.withOpacity(0.5), thickness: 1.w).paddingOnly(bottom: 8.h),
              Expanded(
                child: PageView.builder(
                  controller: pageController,
                  physics: const NeverScrollableScrollPhysics(), // disables swipe
                  itemCount: questionList.length,
                  itemBuilder: (context, questionIndex) {
                    final quiz = questionList[questionIndex];
                    quiz.userAnswer ??= '';
                    final RxInt selectedIndex = (quiz.answer?.indexWhere((a) => a.answer == quiz.userAnswer) ?? -1).obs;

                    return SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Description',
                            style: TextStyle(color: Colors.grey[600], fontSize: 12.sp, fontWeight: FontWeight.w500),
                          ).paddingOnly(bottom: 4.h),

                          Text(
                            quiz.question ?? '',
                            style: TextStyle(color: Colors.black87, fontSize: 18.sp, fontWeight: FontWeight.w600),
                          ).paddingOnly(bottom: 10.h),

                          Text(
                            'Options',
                            style: TextStyle(color: Colors.grey[600], fontSize: 12.sp, fontWeight: FontWeight.w500),
                          ).paddingOnly(bottom: 6.h),

                          ...?quiz.answer?.asMap().entries.map((entry) {
                            int optionIndex = entry.key;
                            var option = entry.value;

                            return GestureDetector(
                              onTap: () {
                                selectedIndex.value = optionIndex;
                                quiz.userAnswer = option.answer;
                              },
                              child: Obx(() {
                                bool isSelected = selectedIndex.value == optionIndex;
                                return Container(
                                  width: double.infinity,
                                  margin: EdgeInsets.only(bottom: 12.h),
                                  padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                                  decoration: BoxDecoration(
                                    color: isSelected ? AppColors.blue : AppColors.white,
                                    borderRadius: BorderRadius.circular(8.r),
                                    border: Border.all(color: Colors.grey[300]!, width: 1),
                                    boxShadow: [BoxShadow(color: AppColors.lightGray, blurRadius: 4, offset: const Offset(0, 2))],
                                  ),
                                  child: Text(
                                    option.answer ?? '',
                                    style: TextStyle(
                                      color: isSelected ? AppColors.white : AppColors.blackText,
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                );
                              }),
                            );
                          }),
                        ],
                      ),
                    );
                  },
                ).paddingSymmetric(horizontal: 16.w),
              ),
            ],
          ),
        ),
        bottomNavigationBar: Container(
          padding: EdgeInsets.only(top: 16.h),
          decoration: BoxDecoration(
            color: AppColors.white,
            boxShadow: [BoxShadow(color: AppColors.gray.withOpacity(0.5), blurRadius: 4, offset: Offset(0, -2))],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  currentIndex == 0
                      ? Expanded(
                        child: GestureDetector(
                          onTap: () {
                            Get.dialog(quitDialog());
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 8.h),
                            decoration: BoxDecoration(
                              border: Border.all(color: AppColors.redisBrown, width: 1.5),
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.close, color: AppColors.redisBrown),
                                SizedBox(width: 8.w),
                                Text('Quit', style: TextStyle(color: AppColors.redisBrown, fontSize: 16.sp, fontWeight: FontWeight.w600)),
                              ],
                            ),
                          ),
                        ),
                      )
                      : Expanded(
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                Get.dialog(quitDialog());
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 26.w),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8.r),
                                  border: Border.all(color: AppColors.redisBrown, width: 1.w),
                                ),
                                child: Icon(Icons.close, size: 24.sp, color: AppColors.redisBrown),
                              ).paddingOnly(right: 8.w),
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  currentIndex = -1;
                                });
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(vertical: 4.sp, horizontal: 26.w),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8.r),
                                  border: Border.all(color: AppColors.blue, width: 1.w),
                                ),
                                child: Icon(Icons.arrow_back, size: 24.sp, color: AppColors.blue),
                              ),
                            ),
                          ],
                        ),
                      ),

                  SizedBox(width: 8.w),

                  // Next Button
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        if (currentIndex < questionList.length - 1) {
                          setState(() {
                            currentIndex++;
                          });
                          pageController.animateToPage(currentIndex, duration: const Duration(milliseconds: 400), curve: Curves.easeInOut);
                        } else {
                          debugPrint("====Answer====");
                          for (var entry in questionList.asMap().entries) {
                            int index = entry.key;
                            var quiz = entry.value;
                            debugPrint("Q${index + 1}: ${quiz.question}");
                            debugPrint("Answer: ${quiz.userAnswer}");
                          }
                          Get.back();
                          Get.to(() => ResultScreen(),transition: Transition.downToUp,duration: Duration(milliseconds: 1000));
                        }
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 4.h),
                        decoration: BoxDecoration(
                          color: AppColors.white.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8.r),
                          border: Border.all(color: AppColors.blue, width: 1.w),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              currentIndex == questionList.length - 1 ? 'Submit' : 'Next',
                              style: TextStyle(color: AppColors.blue, fontSize: 16.sp, fontWeight: FontWeight.w600),
                            ),
                            SizedBox(width: 8.w),
                            const Icon(Icons.arrow_forward, color: AppColors.blue),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ).paddingSymmetric(horizontal: 12.w),
            ],
          ),
        ),
      ),
    );
  }

  Widget quitDialog() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: EdgeInsets.all(16.sp),
          decoration: BoxDecoration(color: AppColors.white, borderRadius: BorderRadius.circular(24.r)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.cancel_outlined, size: 34.sp, color: AppColors.redisBrown).paddingOnly(right: 8.w),
                  Text('Quit', style: StyleHelper.customStyle(color: AppColors.redisBrown, size: 24.sp, family: semiBold)),
                ],
              ).paddingOnly(bottom: 16.h),
              Text(
                'Are you sure you want to quit? Your progress will be lost',
                style: StyleHelper.customStyle(color: AppColors.dimGray, size: 14.sp, family: semiBold),
                maxLines: null,
                textAlign: TextAlign.center,
              ).paddingOnly(bottom: 20.h),
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 12.h),
                        decoration: BoxDecoration(color: AppColors.dimGray, borderRadius: BorderRadius.circular(12.r)),
                        child: Center(child: Text('Back', style: StyleHelper.customStyle(color: AppColors.white, size: 16.sp, family: semiBold))),
                      ),
                    ),
                  ),
                  SizedBox(width: 16.w),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Get.back();
                        Get.back();
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 12.h),
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(12.r),
                          border: Border.all(color: AppColors.redisBrown, width: 1.w),
                        ),
                        child: Center(
                          child: Text('Quit', style: StyleHelper.customStyle(color: AppColors.redisBrown, size: 16.sp, family: semiBold)),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    ).paddingSymmetric(horizontal: 20.w);
  }
}
