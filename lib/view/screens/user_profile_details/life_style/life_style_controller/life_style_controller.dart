import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:matrimony/core/global/api_url_container.dart';
import 'package:matrimony/core/helper/sharedpreference_helper.dart';
import 'package:matrimony/core/route/app_route.dart';
import 'package:matrimony/utils/app_static_strings.dart';
import 'package:matrimony/utils/app_utils.dart';
import 'package:matrimony/view/screens/profile/profile_controller/profile_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class LifeStyleController extends GetxController {
  ProfileController profileController = Get.find<ProfileController>();
  TextEditingController habbitsController = TextEditingController();
  TextEditingController hobbiesController = TextEditingController();
  TextEditingController movieController = TextEditingController();
  TextEditingController musicController = TextEditingController();
  TextEditingController sportsController = TextEditingController();
  TextEditingController tvShowController = TextEditingController();

  bool isLoading = false;

  Future<void> updateLifeStyle({required bool isUpdate}) async {
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
    Map<String, dynamic> params = {
      "habits": habbitsController.text,
      "hobbies": hobbiesController.text,
      "favouriteMusic": musicController.text,
      "favouriteMovies": movieController.text,
      "sports": sportsController.text,
      "tvShows": tvShowController.text,
      "isLifestyleInformationCompleted": "true",
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
      TostMessage.toastMessage(message: AppStaticStrings.lifestyleUpdated);

      if (isUpdate) {
        profileController.myProfile();
        navigator!.pop();
      } else {
        Get.toNamed(AppRoute.partnerPreferences, arguments: [
          AppStaticStrings.partnerPreferences,
          "",
          "",
          "",
          "",
          "Country",
          "State",
          "City",
          "",
          "",
          "",
          "",
          "",
          "",
          "",
          "",
          "",
          "",
          false
        ]);
      }
    } else {
      TostMessage.toastMessage(message: message);
    }
    isLoading = false;
    update();
  }
}
