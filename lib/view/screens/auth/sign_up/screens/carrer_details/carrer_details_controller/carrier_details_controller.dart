import 'dart:convert';
import 'package:get/get.dart';
import 'package:matrimony/core/global/api_url_container.dart';
import 'package:matrimony/core/helper/sharedpreference_helper.dart';
import 'package:matrimony/core/service/api_service.dart';
import 'package:matrimony/utils/app_utils.dart';
import 'package:matrimony/view/screens/auth/sign_up/sign_up_controller/sign_up_controller.dart';
import 'package:matrimony/view/screens/profile/profile_controller/profile_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class CarrierDetailsController extends GetxController {
  ApiService apiService = ApiService(sharedPreferences: Get.find());
  ProfileController profileController = Get.find<ProfileController>();
  SignUpController signUpController = Get.find<SignUpController>();

  Future<void> updateCarrierDetails() async {
    signUpController.isCarrierLoading = true;
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
      "education": signUpController.higherEducationController.text,
      "occupation": signUpController.occupationController.text,
      "workExperience": signUpController.workExperienceController.text,
      "income": signUpController.incomeController.text,
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
    signUpController.isCarrierLoading = true;
    update();
  }
}
