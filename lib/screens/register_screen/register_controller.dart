import 'dart:convert';

import 'package:animated_loader_demo_flutter/model/country_model.dart';
import 'package:animated_loader_demo_flutter/repository/network_function.dart';
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



}