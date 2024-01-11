import 'package:get/get.dart';
import 'package:matrimony/core/global/api_response_method.dart';
import 'package:matrimony/core/global/api_response_model.dart';
import 'package:matrimony/core/global/api_url_container.dart';
import 'package:matrimony/core/service/api_service.dart';
import 'package:matrimony/utils/app_utils.dart';

class ChangePassController {
  static Future<void> resetPassRepo({
    required String newPassword,
    required String oldPassword,
  }) async {
    String url = "${ApiUrlContainer.baseURL}${ApiUrlContainer.changePassword}";
    String responseMethod = ApiResponseMethod.postMethod;
    Map<String, dynamic> params = {
      "oldPassword": oldPassword,
      "newPassword": newPassword
    };

    ApiService apiService = ApiService(sharedPreferences: Get.find());

    ApiResponseModel responseModel = await apiService.request(
        url, responseMethod, params,
        passHeader: true, isRawData: true);

    if (responseModel.statusCode == 200) {
      navigator!.pop();
    }

    TostMessage.toastMessage(message: responseModel.message);
  }
}
