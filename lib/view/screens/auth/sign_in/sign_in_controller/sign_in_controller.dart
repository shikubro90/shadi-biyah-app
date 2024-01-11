import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:matrimony/core/di_service/dependency_injection.dart';
import 'package:matrimony/core/global/api_response_model.dart';
import 'package:matrimony/core/route/app_route.dart';
import 'package:matrimony/utils/app_static_strings.dart';
import 'package:matrimony/view/screens/auth/sign_in/sign_in_model/sign_in_model.dart';
import 'package:matrimony/core/helper/sharedpreference_helper.dart';
import 'package:matrimony/utils/app_utils.dart';
import 'package:matrimony/view/screens/auth/sign_in/sign_in_repo/sign_in_repo.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignInController extends GetxController {
  SignInRepo signInRepo = SignInRepo(apiService: Get.find());
  bool isLoading = false;

  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();

  bool vpn = true;

  static const methodChannel = MethodChannel("method.com/vpn");

  //Check if VPN is connected then Sign IN or Show Warning

  Future getVPNconnection({required bool rememberMe}) async {
    final bool checkVPN = await methodChannel.invokeMethod("isVpnConnected");
    vpn = checkVPN;
    update();

    if (vpn) {
      TostMessage.snackBar(
          title: AppStaticStrings.error, message: AppStaticStrings.vpnDetected);
    } else {
      signIn().then((value) async {
        if (value == true) {
          final SharedPreferences prefs = await SharedPreferences.getInstance();

          await prefs.setBool(SharedPreferenceHelper.isRememberMe, rememberMe);
        }
      });
    }
  }

  Future<bool> signIn() async {
    //Chech if VPN is Connected

    isLoading = true;
    update();

    ApiResponseModel responseModel = await signInRepo.signInRepo(
        email: emailController.text, password: passController.text);

    if (responseModel.statusCode == 200) {
      //Decode Json
      SignInModel signUpModel =
          SignInModel.fromJson(jsonDecode(responseModel.responseJson));

      //Getting  Infomation

      String token =
          signUpModel.data!.attributes!.tokens!.access!.token.toString();
      String name = signUpModel.data!.attributes!.user!.name.toString();
      String id = signUpModel.data!.attributes!.user!.id.toString();
      String email = signUpModel.data!.attributes!.user!.email.toString();
      String img = signUpModel.data!.attributes!.user!.photo![0].publicFileUrl
          .toString();
      bool payment = signUpModel.data!.attributes!.user!.payment!;
      bool isPartnerPreferencesCompleted =
          signUpModel.data!.attributes!.user!.isPartnerPreferencesCompleted!;
      bool isPhoneNumberVerified =
          signUpModel.data!.attributes!.user!.isPhoneNumberVerified!;

      DependencyInjection dI = DependencyInjection();
      dI.dependencies();

      //Save Information in SharedPreferences

      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString(SharedPreferenceHelper.token, token);
      await prefs.setString(SharedPreferenceHelper.userIdKey, id);
      await prefs.setString(SharedPreferenceHelper.name, name);
      await prefs.setString(SharedPreferenceHelper.email, email);
      await prefs.setString(SharedPreferenceHelper.myImgUrl, img);
      await prefs.setBool(SharedPreferenceHelper.isPayment, payment);
      await prefs.setBool(SharedPreferenceHelper.isPayment, payment);
      await prefs.setBool(SharedPreferenceHelper.isPayment, payment);

      //Check if user completed his profile

      if (isPhoneNumberVerified == false) {
        Get.offAllNamed(
          AppRoute.otpVerifyPhn,
        );
      } else if (isPartnerPreferencesCompleted == false) {
        TostMessage.snackBar(
            title: AppStaticStrings.profileNotCompleate,
            message: AppStaticStrings.pleaseCompleateYourProfile);

        await prefs.setBool(
            SharedPreferenceHelper.isPartnerPreferencesCompleted, false);

        Get.offAllNamed(AppRoute.uploadPhoto, arguments: false);
      } else {
        await prefs.setBool(
            SharedPreferenceHelper.isPartnerPreferencesCompleted, true);

        if (kDebugMode) {
          print("This is Token ${prefs.get(SharedPreferenceHelper.token)}");
          print("This is ID ${prefs.get(SharedPreferenceHelper.userIdKey)}");
        }
        Get.offAllNamed(AppRoute.home);
      }

      TostMessage.toastMessage(message: responseModel.message);
      clear();
      isLoading = false;
      update();
      return true;
    } else {
      TostMessage.toastMessage(message: responseModel.message);
      isLoading = false;
      update();
      return false;
    }
  }

  clear() {
    emailController.clear();
    passController.clear();
  }
}
