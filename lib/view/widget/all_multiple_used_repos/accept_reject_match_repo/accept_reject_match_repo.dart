import 'package:get/get.dart';
import 'package:matrimony/core/global/api_response_method.dart';
import 'package:matrimony/core/global/api_response_model.dart';
import 'package:matrimony/core/global/api_url_container.dart';
import 'package:matrimony/core/global/status.dart';
import 'package:matrimony/core/service/api_service.dart';
import 'package:matrimony/utils/app_utils.dart';
import 'package:matrimony/view/screens/match_request/match_req_controller/match_req_controller.dart';
import 'package:matrimony/view/screens/my_matches/my_match_controller/my_match_controller.dart';
import 'package:matrimony/view/screens/send_request/send_request_controller/send_request_controller.dart';

class AcceptRejectReqRepo {
  static ApiService apiService = ApiService(sharedPreferences: Get.find());
  static MatchReqController matchReqController = Get.find<MatchReqController>();
  static MyMatchController myMatchController = Get.find<MyMatchController>();

  static SendMatchReqController sendMatchReqController =
      Get.find<SendMatchReqController>();

  static Future<void> acceptMatchReqRepo(
      {required String id, required Status status}) async {
    String url =
        "${ApiUrlContainer.baseURL}${ApiUrlContainer.acceptMatchReq}$id";
    String responseMethod = ApiResponseMethod.patchMethod;

    Map<String, String> body = {
      "status": status == Status.accepted ? "accepted" : "rejected"
    };

    ApiResponseModel responseModel = await apiService
        .request(url, responseMethod, body, passHeader: true, isRawData: true);

    if (responseModel.statusCode == 200) {
      matchReqController.attributes = [];
      matchReqController.pageNum = 1;
      matchReqController.matchReq();
      //

      myMatchController.attributes = [];
      myMatchController.pageNum = 1;
      myMatchController.myMatch();

      //
      sendMatchReqController.data = [];
      sendMatchReqController.sendReq();
    }
    TostMessage.toastMessage(message: responseModel.message);
  }
}
