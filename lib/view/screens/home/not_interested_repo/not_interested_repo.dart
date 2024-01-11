import 'package:get/get.dart';
import 'package:matrimony/core/global/api_response_method.dart';
import 'package:matrimony/core/global/api_response_model.dart';
import 'package:matrimony/core/global/api_url_container.dart';
import 'package:matrimony/core/service/api_service.dart';
import 'package:matrimony/utils/app_utils.dart';
import 'package:matrimony/view/screens/home/home_controller/home_controller.dart';

class NotInterestedRepo {
  static ApiService apiService = ApiService(sharedPreferences: Get.find());

  static HomeController homeController = Get.find<HomeController>();

  static Future<void> notInterestedRepo({required String id}) async {
    String url = "${ApiUrlContainer.baseURL}${ApiUrlContainer.notInterested}";
    String responseMethod = ApiResponseMethod.postMethod;

    Map<String, String> body = {"profileId": id};

    ApiResponseModel responseModel = await apiService
        .request(url, responseMethod, body, passHeader: true, isRawData: true);

    if (responseModel.statusCode == 201) {
      homeController.results = [];
      homeController.pageNum = 1;
      homeController.home();
    }

    TostMessage.toastMessage(message: responseModel.message);
  }
}
