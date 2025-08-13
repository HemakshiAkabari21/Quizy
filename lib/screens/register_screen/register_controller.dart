import 'dart:convert';

import 'package:quizy/model/country_model.dart';
import 'package:quizy/repository/network_function.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as RequestType;

class RegisterController extends GetxController{

  RxString selectedRole = 'Student'.obs;

  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailAddressController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final countryController = TextEditingController();

  RxBool isFirstName = false.obs;
  RxBool isLastName = false.obs;
  RxBool isEmailAddress = false.obs;
  RxBool isPassword = false.obs;
  RxBool isConfirmPass = false.obs;
  RxBool isCountry = false.obs;

  RxString firstNameError = ''.obs;
  RxString lastNameError = ''.obs;
  RxString emailAddressError = ''.obs;
  RxString passwordError = ''.obs;
  RxString confirmPasswordError = ''.obs;
  RxString countryError = ''.obs;

  RxList<CountryModel> countryList = <CountryModel>[].obs;
  var selectedCountry = CountryModel().obs;
  var isDropdownOpen = false.obs;

  RxBool isLoader = false.obs;



  callCountryApi() {
    isLoader.value =  true;
    NetworkFunctions.apiRequest(
      url: 'https://restcountries.com/v3.1/all?fields=name,flags',
      method: 'get',
      isShowLoader: true,
    ).then((response) {
      if (response != null && response.statusCode == 200) {
        List<dynamic> jsonList = json.decode(response.body);
        List<CountryModel> result =
        jsonList.map((item) => CountryModel.fromJson(item)).toList();
        countryList.assignAll(result);
        isLoader.value = false;
      }
    });
  }

  bool isValidate() {
    if (firstNameController.text.trim().isEmpty) {
      isFirstName.value = true;
      firstNameError.value = 'Please enter first name';
      return false;
    }
    if (lastNameController.text.trim().isEmpty) {
      isLastName.value = true;
      lastNameError.value = 'Please enter Last Name';
      return false;
    }
    if(emailAddressController.text.trim().isEmpty){
      isEmailAddress.value = true;
      emailAddressError.value = 'Please enter email address';
      return false;
    }
    if(RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$').hasMatch(emailAddressController.text.trim())){
      isEmailAddress.value = true;
      emailAddressError.value = 'Please enter valid Email - Address';
      return false;
    }
    if(passwordController.text.trim().isEmpty){
      isPassword.value = true;
      passwordError.value = 'Please enter password';
      return false;
    }
    if(confirmPasswordController.text.trim().isEmpty){
      isConfirmPass.value = true;
      confirmPasswordError.value = 'Please enter confirm-password';
      return false;
    }
    if(passwordController.text.trim() != confirmPasswordController.text.trim()){
      isPassword.value = true;
      isConfirmPass.value = true;
      passwordError.value = 'The Password and Confirm-Password dose not match';
      confirmPasswordError.value = 'The Password and Confirm-Password dose not match';
    }
    if(countryController.text.trim().isEmpty){
      isCountry.value = true;
      countryError.value = 'Please select the country';
      return false;
    }
    return true;
  }



}