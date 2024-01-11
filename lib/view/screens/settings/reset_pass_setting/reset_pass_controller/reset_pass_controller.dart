import 'package:get/get.dart';
import 'package:matrimony/core/global/api_response_method.dart';
import 'package:matrimony/core/global/api_response_model.dart';
import 'package:matrimony/core/global/api_url_container.dart';
import 'package:matrimony/core/service/api_service.dart';
import 'package:matrimony/utils/app_utils.dart';

class ResetPassSettingController {
  static Future<ApiResponseModel> resetPassRepo({
    required String email,
    required String newPassword,
  }) async {
    String url = "${ApiUrlContainer.baseURL}${ApiUrlContainer.resetPassword}";
    String responseMethod = ApiResponseMethod.postMethod;
    Map<String, dynamic> params = {"password": newPassword, "email": email};
    ApiService apiService = ApiService(sharedPreferences: Get.find());

    ApiResponseModel responseModel = await apiService
        .request(url, responseMethod, params, passHeader: false);

    return responseModel;
  }

  static Future<bool> resetPass(
      {required String email, required String newPassword}) async {
    ApiResponseModel responseModel =
        await resetPassRepo(email: email, newPassword: newPassword);

    if (responseModel.statusCode == 200) {
      TostMessage.toastMessage(message: responseModel.message);
      navigator!.pop();
      navigator!.pop();
      navigator!.pop();
      navigator!.pop();
      return true;
    } else {
      TostMessage.toastMessage(message: responseModel.message);
      return false;
    }
  }
}
