import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:matrimony/core/helper/sharedpreference_helper.dart';
import 'package:matrimony/core/route/app_route.dart';
import 'package:matrimony/utils/app_colors.dart';
import 'package:matrimony/utils/app_images.dart';
import 'package:matrimony/utils/app_static_strings.dart';
import 'package:matrimony/utils/device_utils.dart';
import 'package:matrimony/view/widget/button/button.dart';
import 'package:matrimony/view/widget/customText/custom_text.dart';
import 'package:matrimony/view/widget/custom_img/custom_img.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  List<String> onBoardingText = [
    AppStaticStrings.suggestingLifePartner,
    AppStaticStrings.helpsToMake,
    AppStaticStrings.letsFind
  ];

  List<String> imgList = [
    AppImages.onboarding1,
    AppImages.onboarding2,
    AppImages.onboarding3,
  ];
  int currentIndex = 0;
  PageController pageController = PageController();

  Future<void> setOnboarding() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(SharedPreferenceHelper.isOnBoaeding, false);
  }

  @override
  void initState() {
    setOnboarding();
    DeviceUtils.statusBarColor();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        extendBody: true,
        bottomNavigationBar: Container(
          height: height < 800.h ? (height / 2.4.h) : (height / 2.6.h),
          decoration: const BoxDecoration(
              color: AppColors.pink100,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24), topRight: Radius.circular(24))),
          child: Column(
            children: [
              Padding(
                  padding: const EdgeInsets.only(top: 24, bottom: 16),
                  child: SmoothPageIndicator(
                    count: imgList.length,
                    effect: const ExpandingDotsEffect(
                        dotWidth: 8,
                        dotHeight: 8,
                        dotColor: AppColors.black20,
                        activeDotColor: AppColors.white100),
                    controller: pageController,
                  )),
              Padding(
                padding: const EdgeInsets.only(
                    top: 16, bottom: 52, left: 20, right: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const CustomText(
                      color: AppColors.white100,
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      text: AppStaticStrings.findYourLifePartner,
                    ),
                    CustomText(
                      maxLines: 2,
                      color: AppColors.white100,
                      textAlign: TextAlign.left,
                      top: 16,
                      bottom: 26,
                      fontSize: 18,
                      text: onBoardingText[currentIndex],
                    ),
                    CustomButton(
                      ontap: () {
                        Get.offAllNamed(AppRoute.signIn);
                      },
                      textColor: AppColors.pink100,
                      backgroundColor: AppColors.white100,
                    )
                  ],
                ),
              )
            ],
          ),
        ),
        body: SizedBox(
          height:
              height - (height < 800.h ? (height / 2.3.h) : (height / 2.8.h)),
          child: PageView.builder(
            controller: pageController,
            onPageChanged: (value) {
              setState(() {
                currentIndex = value;
              });
            },
            itemCount: imgList.length,
            itemBuilder: (context, index) {
              return CustomImage(
                  fit: BoxFit.cover,
                  imageType: ImageType.png,
                  imageSrc: imgList[index]);
            },
          ),
        ),
      ),
    );
  }
}
