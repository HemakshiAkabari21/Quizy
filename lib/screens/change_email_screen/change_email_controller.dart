import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ChangeEmailController extends GetxController{

  final emailAddressController = TextEditingController();
  final passwordController = TextEditingController();

  RxBool isEmailError = false.obs;
  RxBool isPassError = false.obs;

  RxString emailErrorText = ''.obs;
  RxString passErrorText = ''.obs;

  bool isValidate(){
    if(emailAddressController.text.trim().isEmpty){
      isEmailError.value = true;
      emailErrorText.value = 'Please enter email address';
      return false;
    }
    if(RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$').hasMatch(emailAddressController.text.trim())){
      isEmailError.value = true;
      emailErrorText.value = 'Please enter valid Email - Address';
      return false;
    }
    if(passwordController.text.trim().isEmpty){
      isPassError.value = true;
      passErrorText.value = 'Please enter password';
      return false;
    }
    return true;
  }

}