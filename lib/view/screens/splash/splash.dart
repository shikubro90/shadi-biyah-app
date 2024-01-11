import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matrimony/core/helper/sharedpreference_helper.dart';
import 'package:matrimony/core/route/app_route.dart';
import 'package:matrimony/utils/app_colors.dart';
import 'package:matrimony/utils/app_icons.dart';
import 'package:matrimony/utils/device_utils.dart';
import 'package:matrimony/view/widget/custom_img/custom_img.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future<void> navigate() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final bool? isRemembered =
        prefs.getBool(SharedPreferenceHelper.isRememberMe);
    final bool? isOnBoaeding =
        prefs.getBool(SharedPreferenceHelper.isOnBoaeding);

    final bool? isPartnerPreferencesCompleted =
        prefs.getBool(SharedPreferenceHelper.isPartnerPreferencesCompleted);

    Future.delayed(
      const Duration(seconds: 1),
      () {
        if (isRemembered == true && isPartnerPreferencesCompleted == true) {
          Get.offAllNamed(AppRoute.home);
        } else if (isOnBoaeding == null) {
          Get.offNamed(AppRoute.onboarding);
        } else {
          Get.offNamed(AppRoute.signIn);
        }
      },
    );
  }

  @override
  void initState() {
    DeviceUtils.statusBarColor();

    navigate();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        top: false,
        child: Scaffold(
            backgroundColor: AppColors.pink100,
            body: Center(
              child: Container(
                width: 128,
                height: 128,
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.white100,
                ),
                child: const CustomImage(
                    imageType: ImageType.png, imageSrc: AppIcons.logo),
              ),
            )));
  }
}
