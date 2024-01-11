import 'package:get/get.dart';
import 'package:matrimony/core/global/api_response_method.dart';
import 'package:matrimony/core/global/api_response_model.dart';
import 'package:matrimony/core/global/api_url_container.dart';
import 'package:matrimony/core/service/api_service.dart';
import 'package:matrimony/utils/app_utils.dart';
import 'package:matrimony/view/screens/settings/login_activity/login_activity_controller/login_activity_controller.dart';

class LogOutUser {
  static ApiService apiService = ApiService(sharedPreferences: Get.find());

  static Future<void> logOut({
    required String id,
  }) async {
    String url = "${ApiUrlContainer.baseURL}${ApiUrlContainer.logOut}$id";
    String responseMethod = ApiResponseMethod.deleteMethod;

    ApiResponseModel responseModel = await apiService.request(
      url,
      responseMethod,
      null,
      passHeader: true,
    );

    if (responseModel.statusCode == 200) {
      LogInActivityController logInActivityController =
          Get.find<LogInActivityController>();
      logInActivityController.results = [];
      logInActivityController.logInActivity();
    }

    TostMessage.toastMessage(message: responseModel.message);
  }
}
