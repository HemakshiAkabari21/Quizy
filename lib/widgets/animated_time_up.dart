import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:quizy/app_theme/app_colors.dart';
import 'package:quizy/screens/result_screen/result_screen.dart';

class AnimatedTimeUpDialog extends StatefulWidget {
  const AnimatedTimeUpDialog({super.key});

  @override
  State<AnimatedTimeUpDialog> createState() => _AnimatedTimeUpDialogState();
}

class _AnimatedTimeUpDialogState extends State<AnimatedTimeUpDialog> with TickerProviderStateMixin {
  late AnimationController scaleController;
  late AnimationController clockController;
  late AnimationController pulseController;
  late Animation<double> scaleAnimation;
  late Animation<double> clockRotation;
  late Animation<double> pulseAnimation;

  @override
  void initState() {
    super.initState();

    scaleController = AnimationController(duration: const Duration(milliseconds: 600), vsync: this);
    scaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(parent: scaleController, curve: Curves.easeInBack));

    clockController = AnimationController(duration: const Duration(milliseconds: 800), vsync: this);
    clockRotation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(parent: clockController, curve: Curves.easeInOut));

    pulseController = AnimationController(duration: const Duration(milliseconds: 1000), vsync: this);
    pulseAnimation = Tween<double>(begin: 1.0, end: 1.2).animate(CurvedAnimation(parent: pulseController, curve: Curves.easeInOut));

    _startAnimations();
  }

  void _startAnimations() async {
    scaleController.forward();
    await Future.delayed(const Duration(milliseconds: 300));
    clockController.forward();
    await Future.delayed(const Duration(milliseconds: 200));
    pulseController.repeat(reverse: true);
  }

  @override
  void dispose() {
    scaleController.dispose();
    clockController.dispose();
    pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: AnimatedBuilder(
        animation: scaleAnimation,
        builder: (context, child) {
          return Transform.scale(
            scale: scaleAnimation.value,
            child: Container(
              padding: EdgeInsets.all(24.sp),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20.r),
                boxShadow: [BoxShadow(color: AppColors.black.withOpacity(0.3), blurRadius: 20, offset: const Offset(0, 10))],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AnimatedBuilder(
                    animation: pulseAnimation,
                    builder: (context, child) {
                      return Transform.scale(
                        scale: pulseAnimation.value,
                        child: AnimatedBuilder(
                          animation: clockRotation,
                          builder: (context, child) {
                            return Transform.rotate(
                              angle: clockRotation.value * 0.1, // Subtle rotation
                              child: Container(
                                width: 80.w,
                                height: 80.h,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppColors.red.withOpacity(0.1),
                                  border: Border.all(color: Colors.red, width: 2.w),
                                ),
                                child: Icon(Icons.access_time_filled, size: 40.sp, color: AppColors.red),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 20.h),
                  SlideTransition(
                    position: Tween<Offset>(
                      begin: const Offset(0, -0.5),
                      end: Offset.zero,
                    ).animate(CurvedAnimation(parent: scaleController, curve: const Interval(0.3, 1.0, curve: Curves.easeOut))),
                    child: Text('Time\'s Up!', style: TextStyle(fontSize: 28.sp, fontWeight: FontWeight.bold, color: AppColors.red)),
                  ),
                  SizedBox(height: 12.h),
                  FadeTransition(
                    opacity: Tween<double>(
                      begin: 0.0,
                      end: 1.0,
                    ).animate(CurvedAnimation(parent: scaleController, curve: const Interval(0.5, 1.0, curve: Curves.easeIn))),
                    child: Text(
                      'Your quiz time has ended.\nLet\'s see how you performed!',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16.sp, color: Colors.grey[600], height: 1.4),
                    ),
                  ),
                  SizedBox(height: 30.h),
                  SlideTransition(
                    position: Tween<Offset>(
                      begin: const Offset(-1, 0),
                      end: Offset.zero,
                    ).animate(CurvedAnimation(parent: scaleController, curve: const Interval(0.6, 1.0, curve: Curves.easeOut))),
                    child: Container(
                      height: 2.h,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(colors: [Colors.transparent, Colors.red.withOpacity(0.3), Colors.transparent]),
                        borderRadius: BorderRadius.circular(1.r),
                      ),
                    ),
                  ),

                  SizedBox(height: 20.h),
                  SlideTransition(
                    position: Tween<Offset>(
                      begin: const Offset(0, 0.5),
                      end: Offset.zero,
                    ).animate(CurvedAnimation(parent: scaleController, curve: const Interval(0.7, 1.0, curve: Curves.easeOut))),
                    child: GestureDetector(
                      onTap: () {
                        pulseController.stop();
                        Get.back();
                        Get.back();
                        Get.to(() =>  ResultScreen(),transition: Transition.downToUp,duration: Duration(milliseconds: 1000));
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(vertical: 12.h),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(colors: [Colors.red, Colors.red.shade700], begin: Alignment.topLeft, end: Alignment.bottomRight),
                          borderRadius: BorderRadius.circular(12.r),
                          boxShadow: [BoxShadow(color: Colors.red.withOpacity(0.3), blurRadius: 8, offset: const Offset(0, 4))],
                        ),
                        child: Text(
                          'View Results',
                          style: TextStyle(color: Colors.white, fontSize: 16.sp, fontWeight: FontWeight.w600),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
