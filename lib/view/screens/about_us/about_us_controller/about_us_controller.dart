import 'dart:convert';
import 'package:get/get.dart';
import 'package:matrimony/core/global/api_response_model.dart';
import 'package:matrimony/core/global/side_menu_model/side_menu_model.dart';
import 'package:matrimony/utils/app_utils.dart';
import 'package:matrimony/view/screens/about_us/about_us_repo/about_us_repo.dart';

class AboutUsController extends GetxController with GetxServiceMixin {
  AboutUsRepo aboutUsRepo = AboutUsRepo();

  SideMenuModel sideMenuModel = SideMenuModel();
  bool isLoading = false;

  List<Attribute> attributes = [];

  Future<void> aboutUs() async {
    isLoading = true;
    update();
    ApiResponseModel responseModel = await aboutUsRepo.aboutUsRepo();

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
    aboutUs();

    super.onInit();
  }
}
