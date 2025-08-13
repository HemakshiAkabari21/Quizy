import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ChangePasswordController extends GetxController{

  final oldPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  RxBool isOldPasswordError = false.obs;
  RxBool isNewPasswordError = false.obs;
  RxBool isConfirmPasswordError = false.obs;

  RxString oldPassWordErrorText = ''.obs;
  RxString newPassWordErrorText = ''.obs;
  RxString confirmPassWordErrorText = ''.obs;

  bool isValidate(){
    if(oldPasswordController.text.trim().isEmpty){
      isOldPasswordError.value = true;
      oldPassWordErrorText.value = 'Please enter old-password';
      return false;
    }
    if(newPasswordController.text.trim().isEmpty){
      isNewPasswordError.value = true;
      newPassWordErrorText.value = 'Please enter new-password';
      return false;
    }
    if(confirmPasswordController.text.trim().isEmpty){
      isConfirmPasswordError.value = true;
      confirmPassWordErrorText.value = 'Please enter confirm-password';
      return false;
    }
    if(newPasswordController.text.trim() != confirmPasswordController.text.trim()){
      isNewPasswordError.value = true;
      isConfirmPasswordError.value = true;
      newPassWordErrorText.value = 'NewPassword and Confirm-Password dose not match';
      confirmPassWordErrorText.value = 'NewPassword and Confirm-Password dose not match';
      return false;
    }
    return true;
  }


}