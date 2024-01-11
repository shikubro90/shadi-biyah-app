import 'package:get/get.dart';
import 'package:matrimony/core/global/api_response_method.dart';
import 'package:matrimony/core/global/api_response_model.dart';
import 'package:matrimony/core/global/api_url_container.dart';
import 'package:matrimony/core/service/api_service.dart';
import 'package:matrimony/utils/app_utils.dart';
import 'package:matrimony/view/screens/send_request/send_request_controller/send_request_controller.dart';

class SendReminderRepo {
  static ApiService apiService = ApiService(sharedPreferences: Get.find());

  static Future<ApiResponseModel> sendReminderRepo(
      {required String userId}) async {
    String url =
        "${ApiUrlContainer.baseURL}${ApiUrlContainer.sendReminder}$userId";
    String responseMethod = ApiResponseMethod.postMethod;

    ApiResponseModel responseModel = await apiService.request(
      url,
      responseMethod,
      null,
      passHeader: true,
    );

    if (responseModel.statusCode == 201) {
      SendMatchReqController sendMatchReqController =
          Get.find<SendMatchReqController>();

      sendMatchReqController.sendReq();
    }

    TostMessage.toastMessage(message: responseModel.message);

    return responseModel;
  }
}
