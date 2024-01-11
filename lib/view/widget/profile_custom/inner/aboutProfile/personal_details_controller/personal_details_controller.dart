import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matrimony/core/global/api_url_container.dart';
import 'package:matrimony/core/global/height_calculator/height_calculator.dart';
import 'package:matrimony/core/helper/sharedpreference_helper.dart';
import 'package:matrimony/core/service/api_service.dart';
import 'package:matrimony/utils/app_utils.dart';
import 'package:matrimony/view/screens/profile/profile_controller/profile_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class PersonalDetailsController extends GetxController {
  ApiService apiService = ApiService(sharedPreferences: Get.find());

  ProfileController profileController = Get.find<ProfileController>();

  TextEditingController nameController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController maritalStatusController = TextEditingController();
  TextEditingController ageController = TextEditingController();

  TextEditingController fitController = TextEditingController();
  TextEditingController incController = TextEditingController();
  TextEditingController religionController = TextEditingController();
  TextEditingController casteController = TextEditingController();
  TextEditingController sectController = TextEditingController();

  TextEditingController motherTounghController = TextEditingController();

  TextEditingController datesController = TextEditingController();
  TextEditingController monthController = TextEditingController();
  TextEditingController yearController = TextEditingController();

  TextEditingController residentialStatusController = TextEditingController();

  String countryValue = "Pakistan";
  String stateValue = "Punjab";
  String cityValue = "Lahore";
  bool isLoading = false;

  Future<void> updatePersonalDetails() async {
    isLoading = true;
    update();

    final prefs = await SharedPreferences.getInstance();

    String? id = prefs.getString(SharedPreferenceHelper.userIdKey);
    String? token = prefs.getString(SharedPreferenceHelper.token);

    var request = http.MultipartRequest(
      "PATCH",
      Uri.parse(
          "${ApiUrlContainer.baseURL}${ApiUrlContainer.updateProfile}$id"),
    );

    Map<String, String> params = {
      "name": nameController.text,
      "gender": genderController.text,
      "maritalStatus": maritalStatusController.text,
      "height": HeightConverter.feetAndInchesToCentimeters(
          "${fitController.text} ${incController.text}"),
      "dataOfBirth":
          "${datesController.text} ${monthController.text} ${yearController.text}",
      "religion": religionController.text,
      "country": countryValue,
      "state": stateValue,
      "city": cityValue,
      "residentialStatus": residentialStatusController.text,
      "motherTongue": motherTounghController.text
    };

    params.forEach((key, value) {
      request.fields[key] = value;
    });
    request.headers['Content-Type'] = 'multipart/form-data';
    request.headers['Authorization'] = "Bearer $token";
    // Send the request
    var response = await request.send();

    String responseBody = await response.stream.bytesToString();

    // Parse the JSON string
    Map<String, dynamic> parsedResponse = jsonDecode(responseBody);

    // Access the "message" field
    String message = parsedResponse['message'];

    if (response.statusCode == 200) {
      profileController.myProfile().then((value) {
        navigator!.pop();
      });
      TostMessage.toastMessage(message: message);
    } else {
      TostMessage.toastMessage(message: message);
    }
    isLoading = false;
    update();
  }
}
