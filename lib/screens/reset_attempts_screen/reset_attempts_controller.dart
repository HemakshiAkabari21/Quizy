import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ResetAttemptsController extends GetxController{

  final passwordController = TextEditingController();

  RxBool isPasswordError = false.obs;

  RxString passwordErrorText = ''.obs;

  bool isValidate(){
    if(passwordController.text.trim().isEmpty){
      isPasswordError.value = true;
      passwordErrorText.value = 'Please enter password first';
      return false;
    }
    return true;
  }



}