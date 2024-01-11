import 'package:get/get.dart';
import 'package:matrimony/core/global/api_response_method.dart';
import 'package:matrimony/core/global/api_response_model.dart';
import 'package:matrimony/core/global/api_url_container.dart';
import 'package:matrimony/core/service/api_service.dart';
import 'package:matrimony/utils/app_utils.dart';

class VerifySignInOTP {
  String oneTimeCode = "";

  static Future<ApiResponseModel> signInOtpRepo({
    required String email,
    required String oneTimeCode,
  }) async {
    String url =
        "${ApiUrlContainer.baseURL}${ApiUrlContainer.signUpVerifyEmail}";
    String responseMethod = ApiResponseMethod.postMethod;
    Map<String, dynamic> params = {
      "email": email,
      "oneTimeCode": oneTimeCode,
    };
    ApiService apiService = ApiService(sharedPreferences: Get.find());

    ApiResponseModel responseModel = await apiService
        .request(url, responseMethod, params, passHeader: false);

    return responseModel;
  }

  static Future<bool> verifySignInOtp(
      {required String email, required String oneTimeCode}) async {
    ApiResponseModel responseModel =
        await signInOtpRepo(email: email, oneTimeCode: oneTimeCode);

    if (responseModel.statusCode == 200) {
      TostMessage.toastMessage(message: responseModel.message);
      return true;
    } else {
      TostMessage.toastMessage(message: responseModel.message);
      return false;
    }
  }
}
