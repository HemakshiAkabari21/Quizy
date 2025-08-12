import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class LoginController extends GetxController{

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  RxString emailError = ''.obs;
  RxString passError = ''.obs;

  RxBool isEmail = false.obs;
  RxBool isPass = false.obs;


}