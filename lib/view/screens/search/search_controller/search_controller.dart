import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matrimony/core/global/api_response_model.dart';
import 'package:matrimony/core/global/height_calculator/height_calculator.dart';
import 'package:matrimony/utils/app_utils.dart';
import 'package:matrimony/view/screens/home/home_model/home_model.dart';
import 'package:matrimony/view/screens/search/search_repo/search_repo.dart';

class SearchUserController extends GetxController {
  SearchRepo searchRepo = SearchRepo(apiService: Get.find());

  TextEditingController nameController = TextEditingController();
  //
  TextEditingController ageMaxController = TextEditingController();
  TextEditingController ageMinController = TextEditingController();
  TextEditingController heightMaxController = TextEditingController();
  TextEditingController heightMinController = TextEditingController();
  //
  TextEditingController countryController = TextEditingController();
  TextEditingController stateController = TextEditingController();

  TextEditingController cityController = TextEditingController();
  TextEditingController residenceController = TextEditingController();
  TextEditingController motherTongueController = TextEditingController();
  TextEditingController religionController = TextEditingController();
  TextEditingController sectController = TextEditingController();
  TextEditingController castController = TextEditingController();
  //
  // TextEditingController higherEducationController = TextEditingController();
  // TextEditingController occupationController = TextEditingController();
  TextEditingController maritalStatusController = TextEditingController();
  //
  String countryValue = "";
  String stateValue = "";
  String cityValue = "";
  ////
  /////
  bool isLoading = false;

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
      await search();

      dataLoading = false;
      update();
    }
  }

  Future<void> search() async {
    isLoading = true;
    update();

    //Check if Height is empty then convert it

    String hMin = heightMinController.text.isEmpty
        ? ""
        : HeightConverter.feetAndInchesToCentimeters(heightMinController.text);

    String hMax = heightMaxController.text.isEmpty
        ? ""
        : HeightConverter.feetAndInchesToCentimeters(heightMaxController.text);

    try {
      ApiResponseModel responseModel = await searchRepo.searchRepo(
          name: nameController.text,
          partnerMinAge: ageMinController.text,
          partnerMixAge: ageMaxController.text,
          partnerMinHeight: hMin,
          partnerMixHeight: hMax,
          partnerMaritalStatus: maritalStatusController.text,
          partnerReligion: religionController.text,
          partnerCaste: castController.text,
          partnerMotherTongue: motherTongueController.text,
          partnerCountry: countryValue,
          partnerCity: cityValue,
          partnerResidentialStatus: residenceController.text,
          pageNum: pageNum);

      if (responseModel.statusCode == 200) {
        homeModel = HomeModel.fromJson(jsonDecode(responseModel.responseJson));

        List<Result>? rawData = homeModel.data?.attributes?.results;
        if (rawData != null && rawData.isNotEmpty) {
          results.addAll(rawData);
        }
      } else {
        TostMessage.toastMessage(message: responseModel.message);
      }
    } catch (error) {
      isLoading = false;
      update();
    }

    isLoading = false;
    update();
  }

  refreshData() {
    clear();
    results = [];
    pageNum = 1;
    search();
  }

  clear() {
    pageNum = 1;
    nameController.clear();
    ageMinController.clear();
    ageMaxController.clear();
    heightMinController.clear();
    heightMaxController.clear();

    maritalStatusController.clear();
    religionController.clear();
    castController.clear();
    motherTongueController.clear();
    countryValue = "";
    cityValue = "";
    residenceController.clear();
  }

  @override
  void onInit() {
    scrollController.addListener(addScrollListener);
    super.onInit();
  }
}
