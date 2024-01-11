import 'package:get/get.dart';
import 'package:matrimony/core/global/api_response_method.dart';
import 'package:matrimony/core/global/api_response_model.dart';
import 'package:matrimony/core/global/api_url_container.dart';
import 'package:matrimony/core/service/api_service.dart';
import 'package:matrimony/utils/app_utils.dart';

class ReportUser {
  static ApiService apiService = ApiService(sharedPreferences: Get.find());

  static Future<void> reportUser(
      {required String id,
      required String reportType,
      required String reportDescription}) async {
    String url = "${ApiUrlContainer.baseURL}${ApiUrlContainer.report}";
    String responseMethod = ApiResponseMethod.postMethod;

    Map<String, String> body = {
      "profileId": id,
      "reportType": reportType,
      "reportDescription": reportDescription
    };

    ApiResponseModel responseModel = await apiService
        .request(url, responseMethod, body, passHeader: true, isRawData: true);

    if (responseModel.statusCode == 201) {
      navigator!.pop();
    }

    TostMessage.toastMessage(message: responseModel.message);
  }
}
