import 'package:get/get.dart';
import 'package:matrimony/core/global/api_response_method.dart';
import 'package:matrimony/core/global/api_response_model.dart';
import 'package:matrimony/core/global/api_url_container.dart';
import 'package:matrimony/core/service/api_service.dart';
import 'package:matrimony/utils/app_utils.dart';
import 'package:matrimony/view/screens/blocked_profile/blocked_profile_controller/blocked_profile_controller.dart';
import 'package:matrimony/view/screens/home/home_controller/home_controller.dart';

class UnBlockProfileRepo {
  static ApiService apiService = ApiService(sharedPreferences: Get.find());

  static BlockedProfileController blockedProfileController =
      Get.find<BlockedProfileController>();

  static HomeController homeController = Get.find<HomeController>();

  static Future<void> unBlockProfile({
    required String id,
  }) async {
    String url = "${ApiUrlContainer.baseURL}${ApiUrlContainer.unBlocklist}$id";
    String responseMethod = ApiResponseMethod.deleteMethod;

    ApiResponseModel responseModel = await apiService.request(
      url,
      responseMethod,
      null,
      passHeader: true,
    );

    if (responseModel.statusCode == 201) {
      blockedProfileController.pageNum = 1;
      blockedProfileController.results = [];
      blockedProfileController.blockedProfile();

      //
      homeController.pageNum = 1;
      homeController.results = [];
      homeController.home();
    }

    TostMessage.toastMessage(message: responseModel.message);
  }
}
