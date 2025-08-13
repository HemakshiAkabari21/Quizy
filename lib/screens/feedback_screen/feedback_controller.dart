import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class FeedbackController extends GetxController{

  final titleController = TextEditingController();
  final detailsController = TextEditingController();

  RxBool isTitleError = false.obs;
  RxBool isDetailsError = false.obs;

  RxString titleErrorText = ''.obs;
  RxString detailErrorText = ''.obs;

  bool isValidate(){
    if(titleController.text.trim().isEmpty){
      isTitleError.value = true;
      titleErrorText.value = 'Please enter title of feedback';
      return false;
    }
    if(detailsController.text.trim().isEmpty){
      isDetailsError.value = true;
      detailErrorText.value = 'Please enter Details of feedback';
      return false;
    }
    return true;
  }


}