import 'dart:convert';

import 'package:get/get.dart';
import 'package:matrimony/core/global/api_response_model.dart';
import 'package:matrimony/utils/app_utils.dart';
import 'package:matrimony/view/screens/profile/profile_model/profile_model.dart';
import 'package:matrimony/view/screens/profile/profile_repo/profile_repo.dart';

class ProfileController extends GetxController with GetxServiceMixin {
  MyProfileRepo myProfileRepo = MyProfileRepo(apiService: Get.find());

  ProfileModel profileModel = ProfileModel();
  bool isLoading = false;

  Attributes attributes = Attributes();

  Future<void> myProfile() async {
    // results.clear();
    isLoading = true;
    update();
    ApiResponseModel responseModel = await myProfileRepo.myProfileRepo();

    if (responseModel.statusCode == 200) {
      profileModel =
          ProfileModel.fromJson(jsonDecode(responseModel.responseJson));

      Attributes? rawData = profileModel.data?.attributes;

      if (rawData != null) {
        //  results.addAll(rawData);

        attributes = rawData;
      }
    } else {
      TostMessage.toastMessage(message: responseModel.message);
    }

    isLoading = false;
    update();
  }

  @override
  void onInit() {
    myProfile();
    super.onInit();
  }
}
