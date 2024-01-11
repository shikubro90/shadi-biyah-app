import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matrimony/core/helper/date_converter.dart';
import 'package:matrimony/core/route/app_route.dart';
import 'package:matrimony/utils/app_colors.dart';
import 'package:matrimony/utils/app_static_strings.dart';
import 'package:matrimony/view/screens/my_subscription_plan/my_subscription_controller/my_subscription_controller.dart';
import 'package:matrimony/view/widget/button/button.dart';
import 'package:matrimony/view/widget/customText/custom_text.dart';
import 'package:matrimony/view/widget/custom_appbar/custom_appbar.dart';

class MySubsCriptionPlan extends StatefulWidget {
  const MySubsCriptionPlan({super.key});

  @override
  State<MySubsCriptionPlan> createState() => _MySubsCriptionPlanState();
}

class _MySubsCriptionPlanState extends State<MySubsCriptionPlan> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        top: false,
        child: GetBuilder<MySubscriptionController>(builder: (controller) {
          return Scaffold(
              appBar: const CustomAppBar(
                  title: AppStaticStrings.mySubscriptionPlan),
              bottomNavigationBar: CustomButton(
                text: controller.hasSubscription == false
                    ? AppStaticStrings.upgradeAccount
                    : AppStaticStrings.renewSubscription,
                ontap: () {
                  Get.toNamed(AppRoute.premiumPackages);
                },
                left: 20,
                right: 20,
                bottom: 24,
              ),
              body: controller.isLoading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : controller.hasSubscription == false
                      ? const Center(
                          child: CustomText(
                            text: AppStaticStrings.noSubsCription,
                          ),
                        )
                      : SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 20, right: 20),
                            child: RefreshIndicator(
                              onRefresh: () async {
                                controller.mySubscription();
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  //Package Design

                                  // if (controller.attributes.name != "Free trial")
                                  //   Padding(
                                  //     padding:
                                  //         const EdgeInsets.symmetric(vertical: 24),
                                  //     child: PackageCardDesign(
                                  //       country: "",
                                  //       showButton: false,
                                  //       package:
                                  //           controller.attributes.subscriptionId,
                                  //     ),
                                  //   ),

                                  //Match Request left

                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const CustomText(
                                        fontSize: 16,
                                        text: AppStaticStrings.matchRequestleft,
                                      ),
                                      CustomText(
                                        color: AppColors.pink100,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        text:
                                            "${controller.attributes.matchRequests}",
                                      )
                                    ],
                                  ),

                                  //Send Reminderleft

                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 12, bottom: 30),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const CustomText(
                                          fontSize: 16,
                                          text:
                                              AppStaticStrings.sendReminderleft,
                                        ),
                                        CustomText(
                                          color: AppColors.pink100,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                          text:
                                              "${controller.attributes.reminders}",
                                        )
                                      ],
                                    ),
                                  ),

                                  //Will be Expired on

                                  CustomText(
                                    left: 30,
                                    right: 30,
                                    maxLines: 2,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    text:
                                        "${AppStaticStrings.yourPackageWillExpire} ${DateConverter.formatValidityDate(controller.attributes.expiryDate.toString())}",
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ));
        }));
  }
}
