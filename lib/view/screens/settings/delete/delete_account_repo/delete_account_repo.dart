import 'package:get/get.dart';
import 'package:matrimony/core/global/api_response_method.dart';
import 'package:matrimony/core/global/api_response_model.dart';
import 'package:matrimony/core/global/api_url_container.dart';
import 'package:matrimony/core/helper/sharedpreference_helper.dart';
import 'package:matrimony/core/route/app_route.dart';
import 'package:matrimony/core/service/api_service.dart';
import 'package:matrimony/utils/app_utils.dart';
import 'package:matrimony/view/screens/home/home_controller/home_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DeleteAccountRepo {
  static ApiService apiService = ApiService(sharedPreferences: Get.find());

  static Future<void> deleteAccountRepo({
    required String passWord,
  }) async {
    String url = "${ApiUrlContainer.baseURL}${ApiUrlContainer.deleteAccount}";
    String responseMethod = ApiResponseMethod.postMethod;

    Map<String, String> body = {"password": passWord};

    ApiResponseModel responseModel = await apiService
        .request(url, responseMethod, body, passHeader: true, isRawData: true);

    if (responseModel.statusCode == 200) {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.remove(SharedPreferenceHelper.isRememberMe);
      await prefs.remove(SharedPreferenceHelper.token);
      await prefs.remove(SharedPreferenceHelper.userIdKey);
      if (Get.isRegistered<HomeController>()) {
        HomeController homeController = Get.find<HomeController>();
        homeController.dispose();
      }
      Get.offAllNamed(AppRoute.signIn);
    }

    TostMessage.toastMessage(message: responseModel.message);
  }
}
