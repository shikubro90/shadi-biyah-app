import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matrimony/core/di_service/dependency_injection.dart';
import 'package:matrimony/core/global/no_internet/no_internet.dart';
import 'package:matrimony/core/helper/sharedpreference_helper.dart';
import 'package:matrimony/core/route/app_route.dart';
import 'package:matrimony/utils/app_colors.dart';
import 'package:matrimony/utils/app_images.dart';
import 'package:matrimony/utils/app_static_strings.dart';
import 'package:matrimony/view/widget/button/button.dart';
import 'package:matrimony/view/widget/button/loading_button.dart';
import 'package:matrimony/view/widget/customText/custom_text.dart';
import 'package:matrimony/view/widget/custom_img/custom_img.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NoInternet extends StatelessWidget {
  const NoInternet({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.blue,
      body: GetBuilder<NoInternetController>(builder: (controller) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const CustomImage(
                  imageType: ImageType.png, imageSrc: AppImages.retry),
              const Column(
                children: [
                  CustomText(
                    fontSize: 44,
                    bottom: 20,
                    color: AppColors.white100,
                    text: AppStaticStrings.oops,
                  ),
                  CustomText(
                    fontSize: 18,
                    maxLines: 3,
                    color: AppColors.white100,
                    text: AppStaticStrings.noInternetConFound,
                  ),
                ],
              ),
              controller.isLoading
                  ? const CustomLoadingButton(
                      left: 40,
                      right: 40,
                    )
                  : CustomButton(
                      left: 40,
                      right: 40,
                      text: AppStaticStrings.tryAgain,
                      ontap: () async {
                        DependencyInjection dI = DependencyInjection();

                        final SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        final String? token =
                            prefs.getString(SharedPreferenceHelper.token);
                        if (await controller.checkInternetConnection() &&
                            token != null) {
                          // Get.put(HomeController());
                          dI.dependencies();

                          //Future.delayed(const Duration(seconds: 3), () {});

                          Get.offAllNamed(AppRoute.home);
                        } else if (!await controller
                                .checkInternetConnection() &&
                            token == null) {
                          dI.dependencies();

                          Get.offAllNamed(AppRoute.signIn);
                        }
                      },
                    )
            ],
          ),
        );
      }),
    );
  }
}
