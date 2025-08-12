import 'package:animated_loader_demo_flutter/app_theme/app_colors.dart';
import 'package:animated_loader_demo_flutter/app_theme/style_helper.dart';
import 'package:animated_loader_demo_flutter/model/quiz_model.dart';
import 'package:animated_loader_demo_flutter/model/result_model.dart';
import 'package:animated_loader_demo_flutter/screens/main_screen.dart';
import 'package:animated_loader_demo_flutter/screens/quiz_screen/quiz_screen.dart';
import 'package:animated_loader_demo_flutter/utils/const_images.dart';
import 'package:animated_loader_demo_flutter/widgets/percent_indicatore.dart';
import 'package:animated_loader_demo_flutter/widgets/the_question_accurate_indicatore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class ResultScreen extends StatefulWidget {
  const ResultScreen({super.key});

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  final Rx<ResultModel> result =
      ResultModel(
        percentage: 40.0,
        attemptsLeft: 1,
        correct: 8,
        skipped: 1,
        timeTaken: "02:15",
        wrong: 1,
        questionResults: [
          QuestionStatus.correct,
          QuestionStatus.correct,
          QuestionStatus.correct,
          QuestionStatus.correct,
          QuestionStatus.correct,
          QuestionStatus.correct,
          QuestionStatus.skipped,
          QuestionStatus.wrong,
          QuestionStatus.correct,
          QuestionStatus.correct,
        ],
      ).obs;

  List<QuizModel> questionsList = [
    QuizModel(
      question: 'Emerging higher performance of superminis were',
      userAnswer: '32-bit',
      correctAnswer: '32-bit',
      questionStatus: QuestionStatus.correct,
      answer: [Answer(answer: '32-bit'), Answer(answer: '16-bit'), Answer(answer: '12-bit'), Answer(answer: '64-bit')],
    ),
    QuizModel(
      question: 'Which planet is known as the Red Planet?',
      userAnswer: 'Mars',
      correctAnswer: 'Mars',
      questionStatus: QuestionStatus.correct,
      answer: [Answer(answer: 'Earth'), Answer(answer: 'Mars'), Answer(answer: 'Venus'), Answer(answer: 'Jupiter')],
    ),
    QuizModel(
      question: 'What is the capital of Japan?',
      userAnswer: 'Tokyo',
      correctAnswer: 'Tokyo',
      questionStatus: QuestionStatus.correct,
      answer: [Answer(answer: 'Tokyo'), Answer(answer: 'Kyoto'), Answer(answer: 'Osaka'), Answer(answer: 'Nagoya')],
    ),
    QuizModel(
      question: 'Who developed the theory of relativity?',
      userAnswer: 'Albert Einstein',
      correctAnswer: 'Albert Einstein',
      questionStatus: QuestionStatus.correct,
      answer: [Answer(answer: 'Isaac Newton'), Answer(answer: 'Albert Einstein'), Answer(answer: 'Nikola Tesla'), Answer(answer: 'Galileo Galilei')],
    ),
    QuizModel(
      question: 'What is the largest mammal in the world?',
      userAnswer: 'Blue Whale',
      correctAnswer: 'Blue Whale',
      questionStatus: QuestionStatus.correct,
      answer: [Answer(answer: 'African Elephant'), Answer(answer: 'Blue Whale'), Answer(answer: 'Giraffe'), Answer(answer: 'Hippopotamus')],
    ),
    QuizModel(
      question: 'In which year did World War II end?',
      userAnswer: '1945',
      correctAnswer: '1945',
      questionStatus: QuestionStatus.correct,
      answer: [Answer(answer: '1945'), Answer(answer: '1939'), Answer(answer: '1942'), Answer(answer: '1950')],
    ),
    QuizModel(
      question: 'Which gas do plants absorb from the atmosphere?',
      userAnswer: '',
      correctAnswer: 'Carbon Dioxide',
      questionStatus: QuestionStatus.skipped,
      answer: [Answer(answer: 'Oxygen'), Answer(answer: 'Carbon Dioxide'), Answer(answer: 'Nitrogen'), Answer(answer: 'Helium')],
    ),
    QuizModel(
      question: 'What is the chemical symbol for gold?',
      userAnswer: 'Ag',
      correctAnswer: 'Au',
      questionStatus: QuestionStatus.wrong,
      answer: [Answer(answer: 'Ag'), Answer(answer: 'Au'), Answer(answer: 'Pb'), Answer(answer: 'Pt')],
    ),
    QuizModel(
      question: 'Which is the fastest land animal?',
      userAnswer: 'Cheetah',
      correctAnswer: 'Cheetah',
      questionStatus: QuestionStatus.correct,
      answer: [Answer(answer: 'Cheetah'), Answer(answer: 'Lion'), Answer(answer: 'Horse'), Answer(answer: 'Tiger')],
    ),
    QuizModel(
      question: 'How many continents are there on Earth?',
      userAnswer: '7',
      correctAnswer: '7',
      questionStatus: QuestionStatus.correct,
      answer: [Answer(answer: '5'), Answer(answer: '6'), Answer(answer: '7'), Answer(answer: '8')],
    ),
    QuizModel(
      question: 'Which is the smallest prime number?',
      userAnswer: '2',
      correctAnswer: '2',
      questionStatus: QuestionStatus.correct,
      answer: [Answer(answer: '1'), Answer(answer: '2'), Answer(answer: '3'), Answer(answer: '5')],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.grayBackground,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Result', style: StyleHelper.customStyle(color: AppColors.black, size: 24.sp, family: bold)),
            Text(
              'Topic: Introduction',
              style: StyleHelper.customStyle(color: AppColors.darkGray.withOpacity(0.5), size: 14.sp, family: semiBold),
            ).paddingOnly(bottom: 16.h),
            Container(
              padding: EdgeInsets.only(right: 16.w, left: 16.w, top: 16.h),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(16.r),
                boxShadow: [
                  BoxShadow(color: AppColors.black.withOpacity(0.1), blurRadius: 10, offset: Offset(0, 2)),
                  BoxShadow(color: AppColors.black.withOpacity(0.1), blurRadius: 10, offset: Offset(0, -2)),
                ],
              ),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressExample(
                        text: '${result.value.percentage?.toStringAsFixed(0)}',
                        textColor:
                            (result.value.percentage ?? 0) <= 30
                                ? AppColors.redisBrown
                                : (result.value.percentage ?? 0) <= 60
                                ? AppColors.amber
                                : AppColors.green,
                        backgroundColor:
                            (result.value.percentage ?? 0) <= 30
                                ? AppColors.redisBrown.withOpacity(0.3)
                                : (result.value.percentage ?? 0) <= 60
                                ? AppColors.amber.withOpacity(0.3)
                                : AppColors.green.withOpacity(0.3),
                        percent: (result.value.percentage ?? 0) / 100,
                      ).paddingOnly(right: 30.w),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.r),
                              color: AppColors.white,
                              border: Border.all(color: AppColors.red, width: 1.w),
                            ),
                            child: Row(
                              children: [
                                SvgPicture.asset(AppImages.starIcon, height: 24.h, width: 16.w).paddingOnly(right: 16.w),
                                Text(
                                  '30',
                                  style: StyleHelper.customStyle(color: AppColors.red, size: 18.sp, family: semiBold),
                                ).paddingOnly(right: 6.w),
                              ],
                            ),
                          ).paddingOnly(bottom: 24.h),
                          Text(
                            result.value.timeTaken ?? '',
                            style: StyleHelper.customStyle(
                              color:
                                  (result.value.percentage ?? 0) <= 30
                                      ? AppColors.redisBrown
                                      : (result.value.percentage ?? 0) <= 60
                                      ? AppColors.green
                                      : AppColors.green,
                              size: 34.sp,
                              family: medium,
                            ),
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.access_time,
                                size: 20.sp,
                                color:
                                    (result.value.percentage ?? 0) <= 30
                                        ? AppColors.redisBrown.withOpacity(0.5)
                                        : (result.value.percentage ?? 0) <= 60
                                        ? AppColors.green.withOpacity(0.5)
                                        : AppColors.green.withOpacity(0.5),
                              ).paddingOnly(right: 4.w),
                              Text(
                                'Time Taken',
                                style: StyleHelper.customStyle(
                                  color:
                                      (result.value.percentage ?? 0) <= 30
                                          ? AppColors.redisBrown.withOpacity(0.5)
                                          : (result.value.percentage ?? 0) <= 60
                                          ? AppColors.orange.withOpacity(0.5)
                                          : AppColors.green.withOpacity(0.5),
                                  size: 14.sp,
                                  family: medium,
                                ),
                              ),
                            ],
                          ).paddingOnly(bottom: 16.h),
                        ],
                      ),
                    ],
                  ),
                  Text(
                    (result.value.percentage ?? 0) <= 30
                        ? 'A little more practice and you\'ll be there'
                        : (result.value.percentage ?? 0) <= 70
                        ? 'At least you got a passing score!'
                        : 'You did that,Keep doing well',
                    textAlign: TextAlign.center,
                    maxLines: null,
                    style: StyleHelper.customStyle(color: AppColors.black, size: 15.sp, family: semiBold),
                  ).paddingOnly(),
                  Image.asset(AppImages.bodyBuilder, height: 24.h).paddingOnly(bottom: 16.h),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 16.h),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(color: AppColors.darkGray.withOpacity(0.4), width: 1.w),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              height: 50.h,
                              width: 50.w,
                              decoration: BoxDecoration(shape: BoxShape.circle, color: AppColors.green),
                              child: Center(
                                child: Text(
                                  '${result.value.correct}',
                                  style: StyleHelper.customStyle(color: AppColors.white, size: 24.sp, family: semiBold),
                                ),
                              ),
                            ),
                            Text('Correct', style: StyleHelper.customStyle(color: AppColors.green, size: 12.sp, family: semiBold)),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              height: 50.h,
                              width: 50.w,
                              decoration: BoxDecoration(shape: BoxShape.circle, color: AppColors.amberYellow),
                              child: Center(
                                child: Text(
                                  '${result.value.skipped}',
                                  style: StyleHelper.customStyle(color: AppColors.black, size: 24.sp, family: semiBold),
                                ),
                              ),
                            ),
                            Text('Skipped', style: StyleHelper.customStyle(color: AppColors.amberYellow, size: 12.sp, family: semiBold)),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              height: 50.h,
                              width: 50.w,
                              decoration: BoxDecoration(shape: BoxShape.circle, color: AppColors.bloodRed),
                              child: Center(
                                child: Text(
                                  '${result.value.wrong}',
                                  style: StyleHelper.customStyle(color: AppColors.white, size: 24.sp, family: semiBold),
                                ),
                              ),
                            ),
                            Text('Wrong', style: StyleHelper.customStyle(color: AppColors.bloodRed, size: 12.sp, family: semiBold)),
                          ],
                        ),
                      ],
                    ).paddingSymmetric(horizontal: 40.w),
                  ).paddingOnly(bottom: 16.h),
                  QuestionResultWidget(questionResults: result.value.questionResults ?? []).paddingOnly(bottom: 8.h),
                  Text(
                    'Attempts left to review questions: ${result.value.attemptsLeft}',
                    style: StyleHelper.customStyle(color: AppColors.dimGray.withOpacity(0.7), size: 12.sp, family: semiBold),
                  ).paddingOnly(bottom: 16.h),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
                    decoration: BoxDecoration(
                      color: AppColors.disableButton.withOpacity(0.5),
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(12.r), topRight: Radius.circular(12.r)),
                    ),
                    child: Column(
                      children: [
                        Text(
                          'View complete history & share attempt',
                          style: StyleHelper.customStyle(color: AppColors.dimGray, size: 12.sp, family: medium),
                        ).paddingOnly(bottom: 8.h),
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.symmetric(vertical: 4.h),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8.r),
                                  border: Border.all(color: AppColors.green, width: 1.w),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.history, color: AppColors.green, size: 18.sp).paddingOnly(right: 8.w),
                                    Text('History', style: StyleHelper.customStyle(color: AppColors.green, size: 14.sp, family: medium)),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(width: 16.w),
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.symmetric(vertical: 4.h),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8.r),
                                  border: Border.all(color: AppColors.blue, width: 1.w),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.ios_share_outlined, color: AppColors.blue, size: 18.sp).paddingOnly(right: 8.w),
                                    Text('Share', style: StyleHelper.customStyle(color: AppColors.green, size: 14.sp, family: medium)),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Text('Review Answer', style: StyleHelper.customStyle(color: AppColors.blackText, size: 18.sp, family: semiBold)).paddingOnly(top: 16.h),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: questionsList.length,
              itemBuilder: (context, index) {
                final question = questionsList[index];
                return reviewAnswer(question, index);
              },
            ),
          ],
        ).paddingSymmetric(horizontal: 16.w, vertical: 40.h),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.only(left: 16.w,right: 16.w,top: 16.h),
        decoration: BoxDecoration(
            color: AppColors.white,
            boxShadow: [
              BoxShadow(
                color: AppColors.lightGray,
                blurRadius: 4,
                offset: Offset(0, -2),
              )
            ],
            border: Border(top: BorderSide(color: AppColors.grayBorder, width: 2.0))),
        child: Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: (){
                  Get.offAll(()=>MainScreen(currentIndex: 0),transition: Transition.leftToRight,duration: Duration(milliseconds: 1000));
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 8.h),
                  decoration: BoxDecoration(border: Border.all(color: AppColors.blue, width: 1.w), borderRadius: BorderRadius.circular(8.r)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.arrow_back, color: AppColors.blue, size: 24.sp).paddingOnly(right: 8.w),
                      Text('Topics', style: StyleHelper.customStyle(color: AppColors.blue, size: 16.sp, family: semiBold)),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: GestureDetector(
                onTap: (){
                  Get.back();
                  Get.to(()=>QuizScreen());
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 8.h),
                  decoration: BoxDecoration(color: AppColors.blue,border: Border.all(color: AppColors.blue, width: 1.w), borderRadius: BorderRadius.circular(8.r)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.refresh, color: AppColors.white, size: 24.sp).paddingOnly(right: 8.w),
                      Text('Reattempt', style: StyleHelper.customStyle(color: AppColors.white, size: 16.sp, family: semiBold)),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget reviewAnswer(QuizModel question, int index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              '${index + 1})',
              style: StyleHelper.customStyle(
                color:
                    question.questionStatus == QuestionStatus.correct
                        ? AppColors.green
                        : question.questionStatus == QuestionStatus.skipped
                        ? AppColors.amberOrange
                        : AppColors.red,
                size: 12.sp,
                family: medium,
              ),
            ).paddingOnly(right: 6.w),
            Expanded(
              child: Container(
                height: 2.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.r),
                  color:
                      question.questionStatus == QuestionStatus.correct
                          ? AppColors.green
                          : question.questionStatus == QuestionStatus.skipped
                          ? AppColors.amberOrange
                          : AppColors.red,
                ),
              ),
            ),
            Icon(
              question.questionStatus == QuestionStatus.correct
                  ? Icons.check
                  : question.questionStatus == QuestionStatus.wrong
                  ? Icons.close
                  : Icons.lens_blur,
              size: 14.sp,
              color:
                  question.questionStatus == QuestionStatus.correct
                      ? AppColors.green
                      : question.questionStatus == QuestionStatus.skipped
                      ? AppColors.amberOrange
                      : AppColors.red,
            ).paddingOnly(left: 12.w),
            Text(
              question.questionStatus == QuestionStatus.correct
                  ? 'Correct'
                  : question.questionStatus == QuestionStatus.skipped
                  ? 'Skipped'
                  : 'Wrong',
              style: StyleHelper.customStyle(
                color:
                    question.questionStatus == QuestionStatus.correct
                        ? AppColors.green
                        : question.questionStatus == QuestionStatus.skipped
                        ? AppColors.amberOrange
                        : AppColors.red,
                size: 12.sp,
                family: medium,
              ),
            ),
          ],
        ),
        Text('Description', style: TextStyle(color: Colors.grey[600], fontSize: 12.sp, fontWeight: FontWeight.w500)).paddingOnly(bottom: 4.h),

        Text(
          question.question ?? '',
          style: TextStyle(color: Colors.black87, fontSize: 18.sp, fontWeight: FontWeight.w600),
        ).paddingOnly(bottom: 10.h),

        Text('Options', style: TextStyle(color: Colors.grey[600], fontSize: 12.sp, fontWeight: FontWeight.w500)).paddingOnly(bottom: 6.h),

        ...?question.answer?.asMap().entries.map((entry) {
          int optionIndex = entry.key;
          var option = entry.value;

          bool isCorrectAnswer = option.answer == question.correctAnswer;
          bool isUserAnswer = option.answer == question.userAnswer;

          Color bgColor = AppColors.white;
          Color textColor = AppColors.blackText;

          // Handle skipped
          if (question.questionStatus == QuestionStatus.skipped) {
            bgColor = AppColors.white;
            textColor = AppColors.blackText;
          }
          // Handle correct
          else if (question.questionStatus == QuestionStatus.correct) {
            if (isCorrectAnswer) {
              bgColor = AppColors.green;
              textColor = AppColors.white;
            }
          }
          // Handle wrong
          else if (question.questionStatus == QuestionStatus.wrong) {
            if (isUserAnswer && !isCorrectAnswer) {
              bgColor = AppColors.red;
              textColor = AppColors.white;
            }
            if (isCorrectAnswer) {
              bgColor = AppColors.green;
              textColor = AppColors.white;
            }
          }

          return Container(
            width: double.infinity,
            margin: EdgeInsets.only(bottom: 12.h),
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
            decoration: BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.circular(8.r),
              border: Border.all(color: Colors.grey[300]!, width: 1),
              boxShadow: [BoxShadow(color: AppColors.lightGray, blurRadius: 4, offset: const Offset(0, 2))],
            ),
            child: Text(
              option.answer ?? '',
              style: TextStyle(color: textColor, fontSize: 16.sp, fontWeight: FontWeight.w500),
              textAlign: TextAlign.center,
            ),
          );
        }),
      ],
    );
  }
}
