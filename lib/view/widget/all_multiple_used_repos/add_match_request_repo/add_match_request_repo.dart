import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matrimony/core/global/api_response_method.dart';
import 'package:matrimony/core/global/api_response_model.dart';
import 'package:matrimony/core/global/api_url_container.dart';
import 'package:matrimony/core/service/api_service.dart';
import 'package:matrimony/utils/app_utils.dart';
import 'package:matrimony/view/screens/send_request/send_request_controller/send_request_controller.dart';
import 'package:matrimony/view/widget/pop_up/all_pop_up.dart';

class AddMatchRequest {
  static ApiService apiService = ApiService(sharedPreferences: Get.find());

  //Update Match Req

  // static Sentre matchReqController = Get.find<MatchReqController>();
  static SendMatchReqController sendMatchReqController =
      Get.find<SendMatchReqController>();
  static Future<void> matchReq(
      {required String id, required BuildContext context}) async {
    String url =
        "${ApiUrlContainer.baseURL}${ApiUrlContainer.sendMatchRequest}";
    String responseMethod = ApiResponseMethod.postMethod;

    Map<String, String> body = {"profileId": id};

    ApiResponseModel responseModel = await apiService
        .request(url, responseMethod, body, passHeader: true, isRawData: true);

    if (responseModel.statusCode == 201) {
      sendMatchReqController.data = [];
      sendMatchReqController.sendReq();
      TostMessage.toastMessage(message: responseModel.message);
    } else if (responseModel.statusCode == 402) {
      // ignore: use_build_context_synchronously
      AllPopUp.reachedLimitDiolog(context: context);
    } else {
      TostMessage.toastMessage(message: responseModel.message);
    }
  }
}
