import 'dart:convert';
import 'package:get/get.dart';
import 'package:matrimony/core/global/api_response_model.dart';
import 'package:matrimony/utils/app_utils.dart';
import 'package:matrimony/view/screens/premium_packages/premium_package_model/premium_package_model.dart';
import 'package:matrimony/view/screens/premium_packages/premium_packages_repo/premium_packages_repo.dart';

class PremiumPackageController extends GetxController with GetxServiceMixin {
  PremiumPackageRepo premiumPackageRepo =
      PremiumPackageRepo(apiService: Get.find());

  var isLoading = false.obs;

  List<ResultElement> results = [];

  String? countryName = "";

  PremiumPackageModel premiumPackageModel = PremiumPackageModel();

  Future<void> premiumPackage() async {
    // results.clear();
    isLoading.value = true;

    ApiResponseModel responseModel =
        await premiumPackageRepo.premiumPackageRepo();

    if (responseModel.statusCode == 200) {
      premiumPackageModel =
          PremiumPackageModel.fromJson(jsonDecode(responseModel.responseJson));

      List<ResultElement>? rawData =
          premiumPackageModel.data?.attributes!.result!.results;
      if (rawData != null && rawData.isNotEmpty) {
        countryName = premiumPackageModel.data?.attributes!.country;
        results.addAll(rawData);
      }
    } else {
      TostMessage.toastMessage(message: responseModel.message);
    }

    isLoading.value = false;
    update();
  }

  @override
  void onInit() {
    premiumPackage();
    super.onInit();
  }
}
