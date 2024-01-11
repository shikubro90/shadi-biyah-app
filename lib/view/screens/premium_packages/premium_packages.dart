import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matrimony/utils/app_colors.dart';
import 'package:matrimony/utils/app_static_strings.dart';
import 'package:matrimony/view/screens/premium_packages/package_model/package_model.dart';
import 'package:matrimony/view/screens/premium_packages/premium_packages_controller/premium_packages_controller.dart';
import 'package:matrimony/view/widget/customText/custom_text.dart';
import 'package:matrimony/view/widget/custom_appbar/custom_appbar.dart';

class PremiumPackages extends StatefulWidget {
  const PremiumPackages({super.key});

  @override
  State<PremiumPackages> createState() => _PremiumPackagesState();
}

class _PremiumPackagesState extends State<PremiumPackages> {
  PageController pageController = PageController();
  int currentIndex = 0;

  final controller = Get.find<PremiumPackageController>();

  @override
  void initState() {
    super.initState();
    pageController.addListener(() {
      setState(() {
        currentIndex = pageController.page!.round();
      });
    });
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
          appBar: const CustomAppBar(
            title: AppStaticStrings.upgradetoPremiumAccount,
          ),
          body: Obx(
            () {
              return controller.isLoading.value
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : controller.results.isEmpty
                      ? const Center(
                          child: CustomText(
                            text: AppStaticStrings.noPremiumPackages,
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.only(
                            top: 44,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              //Card Design and Details
                              SingleChildScrollView(
                                physics: const BouncingScrollPhysics(),
                                controller: pageController,
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: List.generate(
                                      controller.results.length, (index) {
                                    return PackageCardDesign(
                                      country: controller.countryName!,
                                      package: controller.results[index],
                                    );
                                  }),
                                ),
                              ),

                              Padding(
                                padding: const EdgeInsets.only(top: 44),
                                child: DotsIndicator(
                                  dotsCount: controller.results.length,
                                  position: currentIndex,
                                  decorator: const DotsDecorator(
                                    color: AppColors.black10,
                                    activeColor: AppColors.pink100,
                                  ),
                                ),
                              )
                            ],
                          ),
                        );
            },
          )),
    );
  }
}
