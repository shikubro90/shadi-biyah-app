import 'package:get/get.dart';
import 'package:matrimony/core/global/api_response_method.dart';
import 'package:matrimony/core/global/api_response_model.dart';
import 'package:matrimony/core/global/api_url_container.dart';
import 'package:matrimony/core/service/api_service.dart';
import 'package:matrimony/utils/app_utils.dart';

class ResendOtp {
  static ApiService apiService = ApiService(sharedPreferences: Get.find());

  static Future<ApiResponseModel> resendOTPRepo({
    required String email,
  }) async {
    String url = "${ApiUrlContainer.baseURL}${ApiUrlContainer.resendOTP}";
    String responseMethod = ApiResponseMethod.postMethod;

    Map<String, dynamic> params = {
      "email": email,
    };

    ApiResponseModel responseModel = await apiService
        .request(url, responseMethod, params, passHeader: false);

    return responseModel;
  }

  static Future<bool> resendOTP({
    required String email,
  }) async {
    ApiResponseModel responseModel = await resendOTPRepo(email: email);

    if (responseModel.statusCode == 200) {
      TostMessage.toastMessage(message: responseModel.message);
      return true;
    } else {
      TostMessage.toastMessage(message: responseModel.message);
      return false;
    }
  }
}
