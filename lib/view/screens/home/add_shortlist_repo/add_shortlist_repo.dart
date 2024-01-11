import 'package:get/get.dart';
import 'package:matrimony/core/global/api_response_method.dart';
import 'package:matrimony/core/global/api_response_model.dart';
import 'package:matrimony/core/global/api_url_container.dart';
import 'package:matrimony/core/service/api_service.dart';
import 'package:matrimony/utils/app_utils.dart';
import 'package:matrimony/view/screens/short_listed_profile/short_listed_profile_controller/short_listed_profile_controller.dart';

class AddShortListRepo {
  static ApiService apiService = ApiService(sharedPreferences: Get.find());

  //Update Short List
  static ShortListProfileController shortListProfileController =
      Get.find<ShortListProfileController>();

  static Future<void> addShortListRepo({required String id}) async {
    String url = "${ApiUrlContainer.baseURL}${ApiUrlContainer.addToShortlist}";
    String responseMethod = ApiResponseMethod.postMethod;

    Map<String, String> body = {"profileId": id};

    ApiResponseModel responseModel = await apiService
        .request(url, responseMethod, body, passHeader: true, isRawData: true);

    if (responseModel.statusCode == 201) {
      shortListProfileController.attributes = [];
      shortListProfileController.pageNum = 1;
      shortListProfileController.shortListedProfile();
    }

    TostMessage.toastMessage(message: responseModel.message);
  }
}
