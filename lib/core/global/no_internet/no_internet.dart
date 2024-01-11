import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matrimony/utils/app_colors.dart';
import 'package:matrimony/utils/app_static_strings.dart';
import 'package:matrimony/view/widget/customText/custom_text.dart';

class NoInternetController extends GetxController {
  final Connectivity _connectivity = Connectivity();

  bool isLoading = false;

  Future<bool> checkInternetConnection() async {
    isLoading = true;
    update();

    var connectivityResult = await Connectivity().checkConnectivity();

    Future.delayed(
      const Duration(seconds: 1),
      () {
        isLoading = false;
        update();
      },
    );

    return connectivityResult != ConnectivityResult.none;
  }

  void onConnectivityChange(ConnectivityResult result) {
    if (result == ConnectivityResult.none) {
      Get.rawSnackbar(
          messageText: const CustomText(
            color: AppColors.white100,
            text: AppStaticStrings.noConnection,
          ),
          isDismissible: false,
          backgroundColor: AppColors.black100,
          icon: const Icon(
            Icons.wifi_off_outlined,
            color: AppColors.white100,
            size: 35,
          ),
          snackStyle: SnackStyle.FLOATING,
          duration: const Duration(days: 1));

      // Get.offAllNamed(AppRoute.noInternet);
    } else {
      if (Get.isSnackbarOpen) {
        Get.closeAllSnackbars();
        //Get.offAllNamed(AppRoute.homeScreen);
      }
    }
  }

  @override
  void onInit() {
    _connectivity.onConnectivityChanged.listen((event) {
      onConnectivityChange(event);
    });
    super.onInit();
  }
}
