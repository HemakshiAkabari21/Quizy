import 'package:quizy/app_theme/app_colors.dart';
import 'package:quizy/app_theme/style_helper.dart';
import 'package:quizy/model/country_model.dart';
import 'package:quizy/screens/login_screen/login_screen.dart';
import 'package:quizy/screens/main_screen.dart';
import 'package:quizy/screens/register_screen/register_controller.dart';
import 'package:quizy/utils/const_images.dart';
import 'package:quizy/widgets/custom_button.dart';
import 'package:quizy/widgets/expaded_custom_text_filed_for_single_selection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final RegisterController registerController = Get.put(RegisterController(),permanent: true);
  RxBool isPasswordShown = false.obs;

  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.addPostFrameCallback((_){
      registerController.callCountryApi();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.grayBackground,
      body: Obx(()=> registerController.isLoader.value
      ? LoadingAnimationWidget.inkDrop(color: Colors.amber, size: 20.sp)
      : SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Register', style: StyleHelper.customStyle(color: AppColors.black, size: 22.sp, family: medium)),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Image.asset(AppImages.bee, height: 24.h, width: 36.w, fit: BoxFit.cover),
                    Text('MCQsLearn', style: StyleHelper.customStyle(color: AppColors.black, size: 20.sp, family: medium)),
                  ],
                ),
              ],
            ).paddingOnly(bottom: 16.h),
            Text('First Name', style: StyleHelper.customStyle(color: AppColors.black, size: 14.sp, family: semiBold)).paddingOnly(bottom: 8.h),
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
                controller: registerController.firstNameController,
                cursorColor: AppColors.slateGray,
                validator: (value) {
                  if (value?.isEmpty ?? false) {
                    registerController.isFirstName.value = true;
                    registerController.firstNameError.value = 'Please enter first name';
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
            ).paddingOnly(bottom: registerController.isFirstName.value ? 0.h : 12.h),
            if (registerController.isFirstName.value)
              Text(
                registerController.firstNameError.value,
                style: StyleHelper.customStyle(color: AppColors.red, size: 12.sp,family: semiBold),
              ).paddingOnly(bottom: 12.h,top: 8.h),
            Text('Last Name', style: StyleHelper.customStyle(color: AppColors.black, size: 14.sp, family: semiBold)).paddingOnly(bottom: 8.h),
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
                controller: registerController.lastNameController,
                cursorColor: AppColors.slateGray,
                validator: (value) {
                  if (value?.isEmpty ?? false) {
                    registerController.isLastName.value = true;
                    registerController.lastNameError.value = 'Please enter last name';
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
            ).paddingOnly(bottom: registerController.isLastName.value ? 0.h : 12.h),
            if (registerController.isLastName.value)
              Text(
                registerController.lastNameError.value,
                style: StyleHelper.customStyle(color: AppColors.red, size: 12.sp,family: semiBold),
              ).paddingOnly(bottom: 12.h,top: 8.h),
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
                controller: registerController.emailAddressController,
                cursorColor: AppColors.slateGray,
                validator: (value) {
                  if (value?.isEmpty ?? false) {
                    registerController.isEmailAddress.value = true;
                    registerController.emailAddressError.value = 'Please enter email address';
                  }
                  if (RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$').hasMatch(value ?? '')) {
                    registerController.isEmailAddress.value;
                    registerController.emailAddressError.value = 'Please enter valid email address';
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
            ).paddingOnly(bottom: registerController.isEmailAddress.value ? 0.h : 12.h),
            if (registerController.isEmailAddress.value)
              Text(
                registerController.emailAddressError.value,
                style: StyleHelper.customStyle(color: AppColors.red, size: 12.sp,family: semiBold),
              ).paddingOnly(bottom: 12.h,top: 8.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Password', style: StyleHelper.customStyle(color: AppColors.black, size: 14.sp, family: semiBold)),
                GestureDetector(
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
              ],
            ).paddingOnly(bottom: 8.h),
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
                controller: registerController.passwordController,
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
                    registerController.isPassword.value = true;
                    registerController.passwordError.value = 'Please enter Password';
                  }
                  if ((value?.length ?? 0) < 6) {
                    registerController.isPassword.value = true;
                    registerController.passwordError.value = 'Password must be at least 6 characters long.';
                  }
                  if (value != registerController.confirmPasswordController.text.trim()) {
                    registerController.isPassword.value = true;
                    registerController.passwordError.value = 'Password and ConfirmPassword dose not match';
                  }
                  return null;
                },
              ),
            ).paddingOnly(bottom: registerController.isPassword.value ? 0.h : 12.h),
            if (registerController.isPassword.value)
              Text(
                registerController.passwordError.value,
                style: StyleHelper.customStyle(color: AppColors.red, size: 12.sp,family: semiBold),
              ).paddingOnly(bottom: 12.h,top: 8.h),
            Text('Confirm Password', style: StyleHelper.customStyle(color: AppColors.black, size: 14.sp, family: semiBold)).paddingOnly(bottom: 8.h),
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
                controller: registerController.confirmPasswordController,
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
                    registerController.isConfirmPass.value = true;
                    registerController.confirmPasswordError.value = 'Please enter Confirm-Password';
                  }
                  if ((value?.length ?? 0) < 6) {
                    registerController.isConfirmPass.value = true;
                    registerController.confirmPasswordError.value = 'Confirm-Password must be at least 6 characters long.';
                  }
                  if (value != registerController.passwordController.text.trim()) {
                    registerController.isConfirmPass.value = true;
                    registerController.confirmPasswordError.value = 'Password and ConfirmPassword dose not match';
                  }
                  return null;
                },
              ),
            ).paddingOnly(bottom: registerController.isConfirmPass.value ? 0.h : 12.h),
            if (registerController.isConfirmPass.value)
              Text(
                registerController.confirmPasswordError.value,
                style: StyleHelper.customStyle(color: AppColors.red, size: 12.sp),
              ).paddingOnly(bottom: 12.h,top: 8.h),
            Text('Country', style: StyleHelper.customStyle(color: AppColors.black, size: 14.sp, family: semiBold)).paddingOnly(bottom: 8.h),
            registerController.countryList.isEmpty
                ? Text(
              'no_deliveryman_found_pls_add_deliveryman'.tr,
              textAlign: TextAlign.center,
              style: StyleHelper.customStyle(color: AppColors.gray, size: 16.sp, family: semiBold),
            )
                : ExpandableDeliveryBoyTextField(
              controller: registerController.countryController,
              isError: registerController.isCountry.value,
              errorText: registerController.isCountry.value ? 'pls_select_delivery_boy'.tr : null,
              countryList: registerController.countryList,
              selectedCountry: registerController.selectedCountry.value,
              hintText: 'Select your country...',
              prefix: Icon(Icons.location_on_outlined, color: AppColors.darkGray, size: 24.sp),
              validator: (value) {
                if (value?.isEmpty ?? false) {
                  registerController.isCountry.value = true;
                  registerController.countryError.value = 'Please Select Country';
                }
                return null;
              },
              onCountrySelected: (country) {
                setState(() {
                  registerController.selectedCountry.value = country ?? CountryModel();
                });
              },
              onCountrySaved: (country) {
                print('Saved country from add screen: $country');
              },
            ).paddingOnly(bottom: 16.h),


            if (registerController.isCountry.value)
              Text(
                registerController.countryError.value,
                style: StyleHelper.customStyle(color: AppColors.red, size: 12.sp),
              ).paddingOnly(bottom: 20.h,top: 8.h),
            Row(
              children: [
                Text('I am a:', style: StyleHelper.customStyle(color: AppColors.black, size: 14.sp, family: semiBold)).paddingOnly(right: 8.w),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      registerController.selectedRole.value = 'Student';
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 8.h),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(8.r), bottomLeft: Radius.circular(8.r)),
                        border: Border.all(color: AppColors.blue),
                        color: registerController.selectedRole.value == 'Student' ? AppColors.blue : AppColors.grayBackground,
                      ),
                      child: Text(
                        'Student',
                        style: StyleHelper.customStyle(
                          color: registerController.selectedRole.value == 'Student' ? AppColors.white : AppColors.blue,
                          size: 14.sp,
                          family: semiBold,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      registerController.selectedRole.value = 'Teacher';
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 8.h),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(topRight: Radius.circular(8.r), bottomRight: Radius.circular(8.r)),
                        border: Border.all(color: AppColors.blue),
                        color: registerController.selectedRole.value == 'Teacher' ? AppColors.blue : AppColors.grayBackground,
                      ),
                      child: Text(
                        'Teacher',
                        style: StyleHelper.customStyle(
                          color: registerController.selectedRole.value == 'Teacher' ? AppColors.white : AppColors.blue,
                          size: 14.sp,
                          family: semiBold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            CustomButton(
              width: Get.width,
              topMargin: 20.h,
              bottomMargin: 20.h,
              text: 'Register',
              color: AppColors.blue,
              textStyle: StyleHelper.customStyle(color: AppColors.white, size: 16.sp, family: semiBold),
              onTap: () {
                if(registerController.isValidate()){
                  Get.offAll(() => MainScreen(currentIndex: 0), transition: Transition.leftToRight, duration: Duration(milliseconds: 1000));
                }
              },
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(flex: 2, child: Container(height: (1.5).h, color: AppColors.darkGray).paddingOnly(right: 5.w)),
                Text("Have an account?", style: StyleHelper.customStyle(color: AppColors.darkGray, size: 14.sp, family: semiBold)),
                Expanded(flex: 2, child: Container(height: (1.5).h, color: AppColors.darkGray).paddingOnly(left: 5.w)),
              ],
            ).paddingSymmetric(vertical: 8.h),
            CustomButton(
              onTap: () {
                Get.offAll(() => LoginScreen(), transition: Transition.rightToLeftWithFade, duration: Duration(milliseconds: 500));
              },
              color: AppColors.white.withOpacity(0.5),
              borderColor: AppColors.yellow,
              borderRadius: 8.r,
              text: 'Log In',
              textStyle: StyleHelper.customStyle(color: AppColors.yellow, size: 14.sp, family: semiBold),
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
            ).paddingOnly(top: 12.h, bottom: 20.h),
          ],
        ).paddingOnly(top: 40.h, left: 16.w, right: 16.w),
      )),
    );
  }
}
