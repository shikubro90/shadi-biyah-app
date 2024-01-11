import 'dart:convert';
import 'package:get/get.dart';
import 'package:matrimony/core/global/api_response_model.dart';
import 'package:matrimony/utils/app_utils.dart';
import 'package:matrimony/view/screens/purches_more_match/pusches_match_model/pusches_match_model.dart';

import 'package:matrimony/view/screens/purches_more_match/pusches_match_repo/pusches_match_repo.dart';

class PurchesMoreController extends GetxController {
  PurchesMoreRepo purchesMoreRepo = PurchesMoreRepo(apiService: Get.find());

  bool isLoading = false;
  int purchesPriceIndex = 0;
  List<Result> results = [];

  String? countyry = "";

  PurchesMoreModel purchesMoreModel = PurchesMoreModel();

  Future<void> premiumPackage() async {
    isLoading = true;
    update();
    ApiResponseModel responseModel = await purchesMoreRepo.purchesMoreRepo();

    if (responseModel.statusCode == 200) {
      purchesMoreModel =
          PurchesMoreModel.fromJson(jsonDecode(responseModel.responseJson));

      List<Result>? rawData = purchesMoreModel.data?.attributes?.result;
      if (rawData != null && rawData.isNotEmpty) {
        countyry = purchesMoreModel.data?.attributes?.country.toString();
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
    premiumPackage();
    super.onInit();
  }
}
