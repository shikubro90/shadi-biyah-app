import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:matrimony/core/di_service/dependency_injection.dart';
import 'package:matrimony/core/global/api_url_container.dart';
import 'package:matrimony/core/global/religion_caste_sect.dart';
import 'package:matrimony/core/helper/sharedpreference_helper.dart';
import 'package:matrimony/core/route/app_route.dart';
import 'package:matrimony/utils/app_static_strings.dart';
import 'package:matrimony/utils/app_utils.dart';
import 'package:matrimony/view/screens/profile/profile_controller/profile_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class PartnerPreController extends GetxController {
  ProfileController profileController = Get.find<ProfileController>();

  TextEditingController ageMaxController = TextEditingController();
  TextEditingController ageMinController = TextEditingController();
  TextEditingController heightMaxController = TextEditingController();
  TextEditingController heightMinController = TextEditingController();
  //
  TextEditingController residenceController = TextEditingController();
  TextEditingController motherTongueController = TextEditingController();
  TextEditingController religionController = TextEditingController();
  TextEditingController sectController = TextEditingController();
  TextEditingController castController = TextEditingController();
  //
  TextEditingController higherEducationController = TextEditingController();
  TextEditingController occupationController = TextEditingController();
  TextEditingController maritalStatusController = TextEditingController();
  TextEditingController maxIncomeController = TextEditingController();
  TextEditingController minIncomeController = TextEditingController();
  //
  String countryValue = "Country";
  String stateValue = "State";
  String cityValue = "City";

  bool isLoading = false;

  Future<void> updatePartnerPre({required bool isUpdate}) async {
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
      "partnerMinAge": ageMinController.text,
      "partnerMixAge": ageMaxController.text,
      "partnerMinHeight": heightMinController.text,
      "partnerMixHeight": heightMaxController.text,
      "partnerMaritalStatus": maritalStatusController.text,
      "partnerCountry": countryValue,
      "partnerCity": "$stateValue $cityValue",
      "partnerReligion": religionController.text,
      //
      "partnerResidentialStatus": residenceController.text,
      "partnerEducation": higherEducationController.text,
      "partnerSect": ReligionSectCaste.casteSect,
      "partnerCaste": castController.text,
      "partnerMotherTongue": motherTongueController.text,
      "partnerMaxIncome": maxIncomeController.text,
      "partnerMinIncome": " ",
      "partnerOccupation": occupationController.text,
      "isPartnerPreferencesCompleted": "true",
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
      DependencyInjection dI = DependencyInjection();
      dI.dependencies();

      //
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setBool(SharedPreferenceHelper.isPartnerPreferencesCompleted, true);

      TostMessage.toastMessage(
          message: AppStaticStrings.partnerPreferenceUpdated);

      profileController.myProfile();
      isUpdate
          ? navigator!.pop()
          : Get.offAllNamed(
              AppRoute.home,
            );
    } else {
      TostMessage.toastMessage(message: message);
    }
    isLoading = false;
    update();
  }
}
