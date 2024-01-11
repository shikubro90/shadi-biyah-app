import 'package:get/get.dart';
import 'package:matrimony/core/global/api_response_method.dart';
import 'package:matrimony/core/global/api_response_model.dart';
import 'package:matrimony/core/global/api_url_container.dart';
import 'package:matrimony/core/service/api_service.dart';
import 'package:matrimony/utils/app_utils.dart';
import 'package:matrimony/view/screens/blocked_profile/blocked_profile_controller/blocked_profile_controller.dart';
import 'package:matrimony/view/screens/home/home_controller/home_controller.dart';

class BlockProfileRepo {
  static ApiService apiService = ApiService(sharedPreferences: Get.find());

  static BlockedProfileController blockedProfileController =
      Get.find<BlockedProfileController>();

  static HomeController homeController = Get.find<HomeController>();

  static Future<void> blockProfile({
    required String id,
  }) async {
    String url = "${ApiUrlContainer.baseURL}${ApiUrlContainer.blockProfile}";
    String responseMethod = ApiResponseMethod.postMethod;

    Map<String, String> body = {"profileId": id};

    ApiResponseModel responseModel = await apiService
        .request(url, responseMethod, body, passHeader: true, isRawData: true);

    if (responseModel.statusCode == 201) {
      blockedProfileController.pageNum = 1;
      blockedProfileController.results = [];
      blockedProfileController.blockedProfile();

      homeController.pageNum = 1;
      homeController.results = [];
      homeController.home();
    }

    TostMessage.toastMessage(message: responseModel.message);
    navigator!.pop();
  }
}
