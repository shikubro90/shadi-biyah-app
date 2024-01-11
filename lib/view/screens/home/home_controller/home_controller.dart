import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matrimony/core/global/api_response_model.dart';
import 'package:matrimony/utils/app_static_strings.dart';
import 'package:matrimony/utils/app_utils.dart';
import 'package:matrimony/view/screens/home/home_model/home_model.dart';
import 'package:matrimony/view/screens/home/home_repo/home_repo.dart';

class HomeController extends GetxController with GetxServiceMixin {
  HomeRepo homeRepo = HomeRepo(apiService: Get.find());

  bool isLoading = false;

  bool retry = false;

  List<Result> results = [];

  HomeModel homeModel = HomeModel();

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
      await home();

      dataLoading = false;
      update();
    }
  }

  Future<void> home() async {
    try {
      isLoading = true;
      retry = false;
      update();
      ApiResponseModel responseModel =
          await homeRepo.homeRepo(pageNum: pageNum);

      if (responseModel.statusCode == 200) {
        homeModel = HomeModel.fromJson(jsonDecode(responseModel.responseJson));

        List<Result>? rawData = homeModel.data?.attributes?.results;
        if (rawData != null && rawData.isNotEmpty) {
          results.addAll(rawData);
        }
      } else {
        TostMessage.toastMessage(message: responseModel.message);
      }

      isLoading = false;
      update();
    } catch (error) {
      TostMessage.toastMessage(message: AppStaticStrings.someThingWentWrong);
      isLoading = false;
      retry = true;
      update();
    }
  }

  @override
  void onInit() {
    scrollController.addListener(addScrollListener);
    home();
    super.onInit();
  }
}
