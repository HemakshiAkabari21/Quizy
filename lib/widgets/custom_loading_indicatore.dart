import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:quizy/app_theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:quizy/app_theme/style_helper.dart';

class CustomLoadingIndicator extends StatefulWidget {
  final double? height;
  final double? width;
  final double? strokeWidth;
  const CustomLoadingIndicator({super.key,this.width,this.height,this.strokeWidth});

  @override
  _CustomLoadingIndicatorState createState() => _CustomLoadingIndicatorState();
}

class _CustomLoadingIndicatorState extends State<CustomLoadingIndicator> with TickerProviderStateMixin {
  late AnimationController _progressController;
  late AnimationController _scaleController;
  late Animation<double> _progressAnimation;
  late Animation<double> _scaleAnimation;

  int _currentCount = 5;
  bool _isAnimating = false;

  @override
  void initState() {
    super.initState();

    // Progress animation controller (5 seconds total)
    _progressController = AnimationController(
      duration: Duration(seconds: 5),
      vsync: this,
    );

    // Scale animation controller for number animation
    _scaleController = AnimationController(
      duration: Duration(milliseconds: 800),
      vsync: this,
    );

    // Progress animation from 0 to 1
    _progressAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _progressController,
      curve: Curves.linear,
    ));

    // Scale animation for in/out effect
    _scaleAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _scaleController,
      curve: Curves.elasticOut,
    ));

    _startCountdown();
  }

  void _startCountdown() async {
    _isAnimating = true;

    // Start the progress animation
    _progressController.forward();

    // Animate each number
    for (int i = 5; i >= 1; i--) {
      setState(() {
        _currentCount = i;
      });

      // Reset and start scale animation
      _scaleController.reset();
      _scaleController.forward();

      // Wait for 1 second before next number
      await Future.delayed(Duration(seconds: 1));
    }

    _isAnimating = false;
  }

  void _resetCountdown() {
    _progressController.reset();
    _scaleController.reset();
    setState(() {
      _currentCount = 5;
    });
    _startCountdown();
  }

  @override
  void dispose() {
    _progressController.dispose();
    _scaleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [

            Text('Attempt new questions in every reattempt',style: StyleHelper.customStyle(color: AppColors.black,size: 14.sp,family: semiBold),).paddingOnly(bottom: 16.h),
            Text('Quiz starting in...',style: StyleHelper.customStyle(color: AppColors.gray.withOpacity(0.9),size: 14.sp,family: semiBold),).paddingOnly(bottom: 16.h),
            AnimatedBuilder(
              animation: _progressAnimation,
              builder: (context, child) {
                return SizedBox(
                  width: 200,
                  height: 200,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      // Circular Progress Indicator
                      SizedBox(
                        width:widget.width ?? 200,
                        height:widget.height ?? 200,
                        child: CircularProgressIndicator(
                          color: AppColors.green,
                          backgroundColor: AppColors.green.withOpacity(0.1),
                          value: _progressAnimation.value,
                          strokeWidth: widget.strokeWidth ?? 20,
                        ),
                      ),
                      // Animated Countdown Number
                      AnimatedBuilder(
                        animation: _scaleAnimation,
                        builder: (context, child) {
                          return Transform.scale(
                            scale: _scaleAnimation.value,
                            child: Text(
                              _currentCount.toString(),
                              style: TextStyle(
                                fontSize: 60,
                                fontWeight: FontWeight.bold,
                                color: AppColors.blackText,
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                );
              },
            ).paddingOnly(bottom: 40.h),
            Text('Go premium to access all features',style: StyleHelper.customStyle(color: AppColors.black,size: 14.sp,family: semiBold),),
            SizedBox(height: 120.h,),
          ],
        ),
      ),
    );
  }
}