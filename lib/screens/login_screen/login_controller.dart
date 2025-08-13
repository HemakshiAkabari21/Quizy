import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class LoginController extends GetxController{

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  RxString emailError = ''.obs;
  RxString passError = ''.obs;

  RxBool isEmail = false.obs;
  RxBool isPass = false.obs;

  bool isValidate(){
    if(emailController.text.trim().isEmpty){
      isEmail.value = true;
      emailError.value = 'Please enter email address';
      return false;
    }
    if(RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$').hasMatch(emailController.text.trim())){
      isEmail.value = true;
      emailError.value = 'Please enter valid Email - Address';
      return false;
    }
    if(passwordController.text.trim().isEmpty){
      isPass.value = true;
      passError.value = 'Please enter password';
      return false;
    }
    return true;
  }


}