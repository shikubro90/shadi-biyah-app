import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matrimony/core/global/api_response_model.dart';
import 'package:matrimony/utils/app_utils.dart';
import 'package:matrimony/view/screens/short_listed_profile/short_listed_profile_model/short_listed_profile_model.dart';
import 'package:matrimony/view/screens/short_listed_profile/short_listed_profile_repo/short_listed_profile_repo.dart';

class ShortListProfileController extends GetxController with GetxServiceMixin {
  ShortListRepo shortListRepo = ShortListRepo();

  ShortListProfileModel profileModel = ShortListProfileModel();
  bool isLoading = false;

  List<Datum> attributes = [];

  ScrollController scrollController = ScrollController();
  bool dataLoading = false;

  int pageNum = 1;

  Future<void> addScrollListener() async {
    if (dataLoading) return;

    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      dataLoading = true;
      update();

      pageNum = pageNum + 1;
      await shortListedProfile();

      dataLoading = false;
      update();
    }
  }

  Future<void> shortListedProfile() async {
    isLoading = true;
    update();
    ApiResponseModel responseModel =
        await shortListRepo.shortListRepo(pageNum: pageNum.toString());

    if (responseModel.statusCode == 200) {
      profileModel = ShortListProfileModel.fromJson(
          jsonDecode(responseModel.responseJson));

      List<Datum>? rawData = profileModel.data?.attributes!.data;

      if (rawData != null) {
        //  results.addAll(rawData);

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
    scrollController.addListener(addScrollListener);
    shortListedProfile();
    super.onInit();
  }
}
