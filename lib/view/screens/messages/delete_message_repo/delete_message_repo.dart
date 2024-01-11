import 'package:get/get.dart';
import 'package:matrimony/core/global/api_response_method.dart';
import 'package:matrimony/core/global/api_response_model.dart';
import 'package:matrimony/core/global/api_url_container.dart';
import 'package:matrimony/core/service/api_service.dart';
import 'package:matrimony/utils/app_utils.dart';
import 'package:matrimony/view/screens/blocked_profile/blocked_profile_controller/blocked_profile_controller.dart';
import 'package:matrimony/view/screens/messages/message_controller/message_controller.dart';

class DeleteChatRepo {
  static ApiService apiService = ApiService(sharedPreferences: Get.find());

  static BlockedProfileController blockedProfileController =
      Get.find<BlockedProfileController>();

  static MessageController messageController = Get.find<MessageController>();

  static Future<void> deleteChat({
    required String chatId,
  }) async {
    String url = "${ApiUrlContainer.baseURL}${ApiUrlContainer.deleteChat}";
    String responseMethod = ApiResponseMethod.deleteMethod;

    Map<String, String> body = {"chatId": chatId};

    ApiResponseModel responseModel = await apiService
        .request(url, responseMethod, body, passHeader: true, isRawData: true);

    if (responseModel.statusCode == 200) {
      messageController.refreshData();
    }

    TostMessage.toastMessage(message: responseModel.message);
  }
}
