import 'package:get/get.dart';
import 'package:matrimony/core/global/api_response_method.dart';
import 'package:matrimony/core/global/api_response_model.dart';
import 'package:matrimony/core/global/api_url_container.dart';
import 'package:matrimony/core/service/api_service.dart';

class MatchReqRepo {
  ApiService apiService = ApiService(sharedPreferences: Get.find());

  Future<ApiResponseModel> matchReqRepo({required String pageNum}) async {
    String url =
        "${ApiUrlContainer.baseURL}${ApiUrlContainer.getMatchRequest}$pageNum";
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
