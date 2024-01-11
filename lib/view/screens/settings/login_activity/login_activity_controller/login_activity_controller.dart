import 'dart:convert';
import 'package:get/get.dart';
import 'package:matrimony/core/global/api_response_model.dart';
import 'package:matrimony/utils/app_utils.dart';
import 'package:matrimony/view/screens/settings/login_activity/login_activity_model/login_activity_model.dart';
import 'package:matrimony/view/screens/settings/login_activity/login_activity_repo/login_activity_repo.dart';

class LogInActivityController extends GetxController {
  LogInActivityRepo logInActivityRepo =
      LogInActivityRepo(apiService: Get.find());

  bool isLoading = false;

  List<Attribute> results = [];

  LogInActivityModel logInActivityModel = LogInActivityModel();

  Future<void> logInActivity() async {
    isLoading = true;
    update();
    ApiResponseModel responseModel =
        await logInActivityRepo.loginActivityRepo();

    if (responseModel.statusCode == 200) {
      logInActivityModel =
          LogInActivityModel.fromJson(jsonDecode(responseModel.responseJson));

      List<Attribute>? rawData = logInActivityModel.data?.attributes;
      if (rawData != null && rawData.isNotEmpty) {
        results.addAll(rawData);
      }
    } else {
      TostMessage.toastMessage(message: responseModel.message);
    }

    isLoading = false;
    update();
  }

  refreshData() {
    results.clear();
    logInActivity();
  }

  @override
  void onInit() {
    logInActivity();
    super.onInit();
  }
}
