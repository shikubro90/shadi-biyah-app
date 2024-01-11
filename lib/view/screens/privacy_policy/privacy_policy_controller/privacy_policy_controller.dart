import 'dart:convert';
import 'package:get/get.dart';
import 'package:matrimony/core/global/api_response_model.dart';
import 'package:matrimony/core/global/side_menu_model/side_menu_model.dart';
import 'package:matrimony/utils/app_utils.dart';
import 'package:matrimony/view/screens/privacy_policy/privacy_policy_repo/privacy_policy_repo.dart';

class PrivacyPolicyController extends GetxController with GetxServiceMixin {
  PrivacyPolicyRepo privacyPolicyRepo = PrivacyPolicyRepo();

  SideMenuModel sideMenuModel = SideMenuModel();
  bool isLoading = false;

  List<Attribute> attributes = [];

  Future<void> privacyPolicy() async {
    isLoading = true;
    update();
    ApiResponseModel responseModel =
        await privacyPolicyRepo.privacyPolicyRepo();

    if (responseModel.statusCode == 200) {
      attributes.clear();
      sideMenuModel =
          SideMenuModel.fromJson(jsonDecode(responseModel.responseJson));

      List<Attribute>? rawData = sideMenuModel.data!.attributes;

      if (rawData != null) {
        attributes.clear();

        attributes.addAll(rawData);
      }
    } else {
      TostMessage.toastMessage(message: responseModel.message);
    }

    isLoading = false;
    update();
  }

  @override
  void onInit() {
    privacyPolicy();

    super.onInit();
  }
}
