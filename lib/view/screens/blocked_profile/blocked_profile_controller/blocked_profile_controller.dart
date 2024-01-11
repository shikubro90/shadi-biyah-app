import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matrimony/core/global/api_response_model.dart';
import 'package:matrimony/utils/app_utils.dart';
import 'package:matrimony/view/screens/blocked_profile/blocked_profile_model/blocked_profile_model.dart';
import 'package:matrimony/view/screens/blocked_profile/blocked_profile_repo/blocked_profile_repo.dart';

class BlockedProfileController extends GetxController with GetxServiceMixin {
  BlockProfileListRepo blockProfileRepo = BlockProfileListRepo();

  bool isLoading = false;

  List<Datum> results = [];

  BlockProfileModel notificationModel = BlockProfileModel();

  ScrollController scrollController = ScrollController();

  int pageNum = 1;
  bool dataLoading = false;

  Future<void> addScrollListener() async {
    if (dataLoading) return;

    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      dataLoading = true;
      update();

      pageNum = pageNum + 1;
      await blockedProfile();

      dataLoading = false;
      update();
    }
  }

  Future<void> blockedProfile() async {
    isLoading = true;
    update();
    ApiResponseModel responseModel =
        await blockProfileRepo.blockProfileRepo(pageNum: pageNum.toString());

    if (responseModel.statusCode == 200) {
      notificationModel =
          BlockProfileModel.fromJson(jsonDecode(responseModel.responseJson));

      List<Datum>? rawData = notificationModel.data?.attributes?.data;

      if (rawData != null && rawData.isNotEmpty) {
        results.addAll(rawData);
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
    blockedProfile();
    super.onInit();
  }
}
