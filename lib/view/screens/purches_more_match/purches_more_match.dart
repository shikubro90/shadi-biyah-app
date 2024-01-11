import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matrimony/core/route/app_route.dart';
import 'package:matrimony/utils/app_colors.dart';
import 'package:matrimony/utils/app_static_strings.dart';
import 'package:matrimony/view/screens/purches_more_match/pusches_match_controller/pusches_match_controller.dart';
import 'package:matrimony/view/widget/button/button.dart';
import 'package:matrimony/view/widget/customText/custom_text.dart';
import 'package:matrimony/view/widget/custom_appbar/custom_appbar.dart';

class PurchesMoreMatch extends StatefulWidget {
  const PurchesMoreMatch({super.key});

  @override
  State<PurchesMoreMatch> createState() => _PurchesMoreMatchState();
}

class _PurchesMoreMatchState extends State<PurchesMoreMatch> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: GetBuilder<PurchesMoreController>(builder: (controller) {
        return Scaffold(
            appBar: const CustomAppBar(
                title: AppStaticStrings.purchaseMatchRequest),
            bottomNavigationBar: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: CustomButton(
                  text: AppStaticStrings.purchase,
                  ontap: () {
                    Get.toNamed(AppRoute.upgradePackageCard, arguments: [
                      controller.results[controller.purchesPriceIndex],
                      false,
                      controller.countyry
                    ]);
                  }),
            ),
            body: controller.isLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                              children: List.generate(controller.results.length,
                                  (index) {
                            return Row(
                              children: [
                                Radio(
                                  activeColor: AppColors.pink100,
                                  value: index,
                                  groupValue: controller.purchesPriceIndex,
                                  onChanged: (value) {
                                    setState(() {
                                      controller.purchesPriceIndex = value!;
                                    });
                                  },
                                ),
                                CustomText(
                                  fontSize: 16,
                                  right: 16,
                                  text: controller.results[index].matchRequests
                                      .toString(),
                                ),
                                const CustomText(
                                  fontSize: 16,
                                  right: 16,
                                  text: AppStaticStrings.matchRequest,
                                ),
                                CustomText(
                                  color: AppColors.pink100,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                  text: controller.countyry == "PK"
                                      ? "\$${controller.results[index].pkCountryPrice}"
                                      : "\$${controller.results[index].otherCountryPrice}",
                                ),
                              ],
                            );
                          })),
                          GestureDetector(
                            onTap: () {
                              Get.toNamed(AppRoute.premiumPackages);
                            },
                            child: Container(
                              margin: const EdgeInsets.symmetric(vertical: 20),
                              child: const CustomText(
                                color: AppColors.pink100,
                                fontWeight: FontWeight.w500,
                                text:
                                    AppStaticStrings.seeAllsubscriptionPackeges,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ));
      }),
    );
  }
}
