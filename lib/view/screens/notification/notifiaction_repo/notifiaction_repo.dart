import 'package:get/get.dart';
import 'package:matrimony/core/global/api_response_method.dart';
import 'package:matrimony/core/global/api_response_model.dart';
import 'package:matrimony/core/global/api_url_container.dart';
import 'package:matrimony/core/service/api_service.dart';

class NotificationRepo {
  ApiService apiService = ApiService(sharedPreferences: Get.find());

  Future<ApiResponseModel> notificationRepo({required String pageNum}) async {
    String url =
        "${ApiUrlContainer.baseURL}${ApiUrlContainer.notification}$pageNum";
    String responseMethod = ApiResponseMethod.getMethod;

    ApiResponseModel responseModel = await apiService.request(
      url,
      responseMethod,
      null,
      passHeader: true,
    );

    return responseModel;
  }
}
