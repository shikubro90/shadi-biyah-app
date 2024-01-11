import 'dart:convert';
import 'package:get/get.dart';
import 'package:matrimony/core/global/api_response_model.dart';
import 'package:matrimony/core/global/side_menu_model/side_menu_model.dart';
import 'package:matrimony/utils/app_utils.dart';
import 'package:matrimony/view/screens/terms_condition/terms_condition_repo/terms_condition_repo.dart';

class TermsAndConditionController extends GetxController with GetxServiceMixin {
  TermsConditionRepo termsConditionRepo = TermsConditionRepo();

  SideMenuModel sideMenuModel = SideMenuModel();
  bool isLoading = false;

  List<Attribute> attributes = [];

  Future<void> termsCondition() async {
    isLoading = true;
    update();
    ApiResponseModel responseModel =
        await termsConditionRepo.termsConditionRepo();

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
    termsCondition();
    super.onInit();
  }
}
