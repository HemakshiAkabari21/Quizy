import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ChangeNameController extends GetxController {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();

  RxBool isFirstNameError = false.obs;
  RxBool isLastNameError = false.obs;

  RxString firstNameErrorText = ''.obs;
  RxString lastNameErrorText = ''.obs;

  bool isValidate() {
    if (firstNameController.text.trim().isEmpty) {
      isFirstNameError.value = true;
      firstNameErrorText.value = 'Please enter first name';
      return false;
    }
    if (lastNameController.text.trim().isEmpty) {
      isLastNameError.value = true;
      lastNameErrorText.value = 'Please enter Last Name';
      return false;
    }
    return true;
  }
}
