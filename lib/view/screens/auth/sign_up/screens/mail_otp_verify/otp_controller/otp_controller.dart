import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:matrimony/core/global/api_response_model.dart';
import 'package:matrimony/core/helper/sharedpreference_helper.dart';
import 'package:matrimony/core/route/app_route.dart';
import 'package:matrimony/utils/app_utils.dart';
import 'package:matrimony/view/screens/auth/sign_up/screens/mail_otp_verify/otp_repo/otp_repo.dart';
import 'package:matrimony/view/screens/auth/sign_up/sign_up_controller/sign_up_controller.dart';
import 'package:matrimony/view/screens/auth/sign_up/sign_up_model/sign_up_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUpOtpController extends GetxController {
  SignUpController signUpController = Get.find<SignUpController>();
  String oneTimeCode = "";
  SignUpOtpRepo signUpOtpRepo = SignUpOtpRepo(apiService: Get.find());

  bool isLoading = false;
  Future<void> verifySignUpOtp() async {
    isLoading = true;
    update();
    ApiResponseModel responseModel = await signUpOtpRepo.signUpOtpRepo(
        email: signUpController.emailController.text, oneTimeCode: oneTimeCode);

    if (responseModel.statusCode == 200) {
      //Decode Json
      SignUpModel signUpModel =
          SignUpModel.fromJson(jsonDecode(responseModel.responseJson));

      String token =
          signUpModel.data!.attributes!.tokens!.access!.token.toString();
      String id = signUpModel.data!.attributes!.user!.id.toString();
      String name = signUpModel.data!.attributes!.user!.name.toString();
      String img = signUpModel.data!.attributes!.user!.photo![0].publicFileUrl
          .toString();
      bool payment = signUpModel.data!.attributes!.user!.payment!;
      String email = signUpModel.data!.attributes!.user!.email.toString();

      //Save Information in SharedPreferences

      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString(SharedPreferenceHelper.token, token);
      await prefs.setString(SharedPreferenceHelper.userIdKey, id);
      await prefs.setString(SharedPreferenceHelper.name, name);
      await prefs.setString(SharedPreferenceHelper.myImgUrl, img);
      await prefs.setBool(SharedPreferenceHelper.isPayment, payment);
      await prefs.setString(SharedPreferenceHelper.email, email);

      if (kDebugMode) {
        print("This is Token ${prefs.get(SharedPreferenceHelper.token)}");
        print("This is ID ${prefs.get(SharedPreferenceHelper.userIdKey)}");
      }
      TostMessage.toastMessage(message: responseModel.message);
      Get.offAllNamed(AppRoute.otpVerifyPhn, arguments: false);
    } else {
      TostMessage.toastMessage(message: responseModel.message);
    }
    isLoading = false;
    update();
  }
}
