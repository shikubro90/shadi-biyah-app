import 'package:get/get.dart';
import 'package:matrimony/core/global/api_response_method.dart';
import 'package:matrimony/core/global/api_response_model.dart';
import 'package:matrimony/core/global/api_url_container.dart';
import 'package:matrimony/core/route/app_route.dart';
import 'package:matrimony/core/service/api_service.dart';
import 'package:matrimony/utils/app_static_strings.dart';
import 'package:matrimony/utils/app_utils.dart';

class SendOtpNum {
  static ApiService apiService = ApiService(sharedPreferences: Get.find());

  static Future<bool> sendOTP() async {
    String url = "${ApiUrlContainer.baseURL}${ApiUrlContainer.sendOtpPhn}";
    String responseMethod = ApiResponseMethod.postMethod;

    ApiResponseModel responseModel =
        await apiService.request(url, responseMethod, null, passHeader: true);

    if (responseModel.statusCode == 200) {
      TostMessage.toastMessage(message: responseModel.message);
      return true;
    } else {
      TostMessage.toastMessage(message: AppStaticStrings.someThingWentWrong);
      return false;
    }
  }

  static Future<void> verifyOTP({required String otpCode}) async {
    String url = "${ApiUrlContainer.baseURL}${ApiUrlContainer.verifyPhnNumber}";
    String responseMethod = ApiResponseMethod.postMethod;

    Map<String, String> body = {"otpCode": otpCode};

    ApiResponseModel responseModel = await apiService
        .request(url, responseMethod, body, passHeader: true, isRawData: true);

    if (responseModel.statusCode == 200) {
      TostMessage.toastMessage(message: responseModel.message);
      Get.offAllNamed(AppRoute.uploadPhoto, arguments: false);
    } else {
      TostMessage.toastMessage(message: AppStaticStrings.someThingWentWrong);
    }
  }
}
