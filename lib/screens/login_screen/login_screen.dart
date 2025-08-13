import 'package:quizy/app_theme/app_colors.dart';
import 'package:quizy/app_theme/style_helper.dart';
import 'package:quizy/screens/login_screen/login_controller.dart';
import 'package:quizy/screens/main_screen.dart';
import 'package:quizy/screens/register_screen/register_screen.dart';
import 'package:quizy/utils/const_images.dart';
import 'package:quizy/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  RxBool isPasswordShown = false.obs;

  LoginController loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.grayBackground,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Log In', style: StyleHelper.customStyle(color: AppColors.black, size: 22.sp, family: medium)),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Image.asset(AppImages.bee, height: 24.h, width: 36.w, fit: BoxFit.cover),
                    Text('MCQsLearn', style: StyleHelper.customStyle(color: AppColors.black, size: 20.sp, family: medium)),
                  ],
                ),
              ],
            ).paddingOnly(bottom: 16.h),
            Text('Email Address', style: StyleHelper.customStyle(color: AppColors.black, size: 14.sp, family: semiBold)).paddingOnly(bottom: 8.h),
            Container(
              width: Get.width,
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(8.r),
                border: Border.all(color: AppColors.lightGray),
                boxShadow: [
                  BoxShadow(color: AppColors.lightGray, blurRadius: 4, offset: Offset(0, 2)),
                  BoxShadow(color: AppColors.lightGray, blurRadius: 4, offset: Offset(0, -1)),
                ],
              ),
              child: TextFormField(
                controller: loginController.emailController,
                cursorColor: AppColors.slateGray,
                validator: (value) {
                  if (value?.isEmpty ?? false) {
                    loginController.isEmail.value = true;
                    loginController.emailError.value = 'Please enter email address';
                  }
                  if (RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$').hasMatch(value ?? '')) {
                    loginController.isEmail.value = true;
                    loginController.emailError.value = 'Please enter valid email address';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.circular(12.r)),
                  contentPadding: EdgeInsets.all(5.sp),
                  fillColor: AppColors.white,
                  filled: true,
                ),
              ),
            ).paddingOnly(bottom: loginController.isEmail.value ? 0.h : 12.h),
           Obx(()=>loginController.isEmail.value?Text(
             loginController.emailError.value,
             style: StyleHelper.customStyle(color: AppColors.red, size: 12.sp,family: semiBold),
           ).paddingOnly(bottom: 12.h,top: 8.h):SizedBox()),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Password', style: StyleHelper.customStyle(color: AppColors.black, size: 14.sp, family: semiBold)),
                Obx(
                  () => GestureDetector(
                    onTap: () {
                      isPasswordShown.toggle();
                    },
                    child: Row(
                      children: [
                        Container(
                          height: 20.h,
                          width: 20.w,
                          decoration: BoxDecoration(
                            color: AppColors.white,
                            borderRadius: BorderRadius.circular(4.r),
                            border: Border.all(color: AppColors.lightGray),
                            boxShadow: [BoxShadow(color: AppColors.lightGray, blurRadius: 4, offset: Offset(0, 2))],
                          ),
                          child: isPasswordShown.value ? Icon(Icons.check, color: AppColors.blue, size: 20.sp) : SizedBox(),
                        ).paddingOnly(right: 5.w),
                        Text('Show Password', style: StyleHelper.customStyle(color: AppColors.darkGray, size: 12.sp, family: semiBold)),
                      ],
                    ),
                  ),
                ),
              ],
            ).paddingOnly(bottom: 8.h),
            Obx(() => Container(
                width: Get.width,
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(8.r),
                  border: Border.all(color: AppColors.lightGray),
                  boxShadow: [
                    BoxShadow(color: AppColors.lightGray, blurRadius: 4, offset: Offset(0, 2)),
                    BoxShadow(color: AppColors.lightGray, blurRadius: 4, offset: Offset(0, -1)),
                  ],
                ),
                child: TextFormField(
                  controller: loginController.passwordController,
                  cursorColor: AppColors.slateGray,
                  obscureText: !isPasswordShown.value,
                  obscuringCharacter: '•',
                  decoration: InputDecoration(
                    border: OutlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.circular(12.r)),
                    contentPadding: EdgeInsets.all(5.sp),
                    fillColor: AppColors.white,
                    filled: true,
                  ),
                  validator: (value) {
                    if (value?.isEmpty ?? false) {
                      loginController.isPass.value = true;
                      loginController.passError.value = 'Please enter Password';
                    }
                    if ((value?.length ?? 0) < 6) {
                      loginController.isPass.value = true;
                      loginController.passError.value = 'Password must be at least 6 characters long.';
                    }
                    return null;
                  },
                ),
              )),
            Obx(()=>loginController.isPass.value ?Text(loginController.passError.value, style: StyleHelper.customStyle(color: AppColors.red, size: 12.sp,family: semiBold)).paddingOnly(top: 8.h) :SizedBox()),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [SizedBox(), Text('Forgot password?', style: StyleHelper.customStyle(color: AppColors.blue, size: 12.sp, family: bold))],
            ).paddingSymmetric(vertical: 8.h),
            CustomButton(
              topMargin: 8.h,
              bottomMargin: 8.h,
              borderRadius: 8.r,
              width: Get.width,
              color:AppColors.yellow,
              text: 'Login',
              textStyle: StyleHelper.customStyle(color: AppColors.black, size: 16.sp, family: semiBold),
              onTap: (){
                Get.offAll(()=>MainScreen(currentIndex: 0),transition: Transition.leftToRight,duration: Duration(milliseconds: 1000));
               /* if(loginController.isValidate()){

                }*/
              },
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  flex: 2,
                    child: Container(height: (1.5).h, color: AppColors.darkGray).paddingOnly(right: 5.w)),
                Text("Don't have an account?", style: StyleHelper.customStyle(color: AppColors.darkGray, size: 14.sp, family: semiBold)),
                Expanded(
                  flex: 2,
                    child: Container(height: (1.5).h, color: AppColors.darkGray).paddingOnly(left: 5.w)),
              ],
            ).paddingSymmetric(vertical: 8.h),
            CustomButton(
              topMargin: 5.h,
              width: Get.width,
              text: 'Register',
              borderColor: AppColors.blue,
              borderRadius: 8.r,
              color: AppColors.white.withOpacity(0.1),
              textStyle: StyleHelper.customStyle(color: AppColors.blue, size: 16.sp, family: semiBold),
              onTap: (){
                Get.to(()=> RegisterScreen(),transition: Transition.leftToRightWithFade,duration: Duration(milliseconds: 500));
              },
            ),

            GestureDetector(
              onTap: () {},
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Privacy Policy'.tr,
                    style: StyleHelper.customStyle(color: AppColors.gray, size: 12.sp, family: semiBold),
                  ).paddingOnly(right: 4.w),
                  Icon(Icons.open_in_new, size: 13.sp, color: AppColors.gray).paddingOnly(top: 2.h),
                ],
              ),
            ).paddingOnly(top: 12.h),
          ],
        ).paddingOnly(top: 40.h, left: 16.w, right: 16.w),
      ),
    );
  }
}
