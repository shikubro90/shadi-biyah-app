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

class AboutYourSelfController extends GetxController {
  TextEditingController aboutTextEdiController = TextEditingController();
  ProfileController profileController = Get.find<ProfileController>();
  bool isLoading = false;

  Future<void> updateAboutMe({required bool isUpdate}) async {
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
    request.fields["aboutMe"] = aboutTextEdiController.text;
    request.fields["isAboutMeCompleted"] = "true";

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
      TostMessage.toastMessage(message: message);
      profileController.myProfile();
      isUpdate
          ? navigator!.pop()
          : Get.toNamed(AppRoute.familyDetails, arguments: [
              AppStaticStrings.familyDetails,
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
    } else {
      TostMessage.toastMessage(message: message);
    }
    isLoading = false;
    update();
  }
}
