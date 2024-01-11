import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matrimony/core/helper/sharedpreference_helper.dart';
import 'package:matrimony/core/route/app_route.dart';
import 'package:matrimony/utils/app_colors.dart';
import 'package:matrimony/utils/app_icons.dart';
import 'package:matrimony/utils/app_static_strings.dart';
import 'package:matrimony/view/screens/profile/profile_controller/profile_controller.dart';
import 'package:matrimony/view/widget/customText/custom_text.dart';
import 'package:matrimony/view/widget/custom_img/custom_img.dart';
import 'package:matrimony/view/widget/pop_up/all_pop_up.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeDrawer extends StatefulWidget {
  const HomeDrawer({super.key});

  @override
  State<HomeDrawer> createState() => _HomeDrawerState();
}

class _HomeDrawerState extends State<HomeDrawer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width / 1.3,
      decoration: const BoxDecoration(
          color: AppColors.pink100,
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(16), bottomRight: Radius.circular(16))),
      child: Padding(
        padding: const EdgeInsets.only(top: 44, left: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //Image and Name Rows

            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                    padding: const EdgeInsets.all(4),
                    child: Column(
                      children: [
                        GetBuilder<ProfileController>(builder: (controller) {
                          return controller.isLoading
                              ? const Center(
                                  child: CircularProgressIndicator(),
                                )
                              : Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    // Profile Section

                                    Stack(
                                      clipBehavior: Clip.none,
                                      children: [
                                        Container(
                                          height: 64,
                                          width: 64,
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              image: DecorationImage(
                                                  fit: BoxFit.cover,
                                                  image: NetworkImage(
                                                      "${controller.attributes.user!.photo![0].publicFileUrl}"))),
                                        ),
                                        if (controller
                                            .attributes.user!.payment!)
                                          Positioned(
                                            top: -4,
                                            left: -4,
                                            child: Container(
                                                padding:
                                                    const EdgeInsets.all(5),
                                                decoration: const BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: AppColors.white100),
                                                child: const CustomImage(
                                                    imageSrc:
                                                        AppIcons.premium)),
                                          ),
                                      ],
                                    ),
                                    //Name and premium Account
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        CustomText(
                                            color: AppColors.white100,
                                            fontWeight: FontWeight.w500,
                                            text:
                                                "${controller.attributes.user!.name}"),
                                        CustomText(
                                          fontSize: 12,
                                          color: AppColors.white100,
                                          fontWeight: FontWeight.w500,
                                          text:
                                              "${controller.attributes.mySubscription}",
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    )
                                  ],
                                );
                        }),
                        const SizedBox(
                          height: 24,
                        ),
                        //My Profile
                        CustomRow(
                            icon: AppIcons.profile,
                            text: AppStaticStrings.profile,
                            ontap: () {
                              Get.toNamed(AppRoute.profile);
                            }),

                        // My Subscription Plan

                        CustomRow(
                            icon: AppIcons.premiumWhite,
                            text: AppStaticStrings.mySubscriptionPlan,
                            ontap: () {
                              Get.toNamed(AppRoute.mySubscriptionPlan);
                            }),
                        // Matches Request

                        CustomRow(
                            icon: AppIcons.heart,
                            text: AppStaticStrings.matchRequest,
                            ontap: () {
                              Get.toNamed(AppRoute.matchRequest);
                            }),
                        // Sent Request

                        CustomRow(
                            icon: AppIcons.heart,
                            text: AppStaticStrings.sentRequest,
                            ontap: () {
                              Get.toNamed(AppRoute.sentRequest);
                            }),
                        //short listed Profiles

                        CustomRow(
                            icon: AppIcons.starFill,
                            text: AppStaticStrings.shortlistedProfiles,
                            ontap: () {
                              Get.toNamed(AppRoute.shortListedProfile);
                            }),
                        //Blocked Profiles

                        CustomRow(
                            icon: AppIcons.block,
                            text: AppStaticStrings.blockedProfiles,
                            ontap: () {
                              Get.toNamed(AppRoute.blockProfile);
                            }),

                        //Divider

                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 24),
                          height: 1,
                          width: double.infinity,
                          color: AppColors.pink60,
                        ),
                        //Settings

                        CustomRow(
                            icon: AppIcons.settings,
                            text: AppStaticStrings.settings,
                            ontap: () {
                              Get.toNamed(AppRoute.settings);
                            }),

                        //Policy

                        CustomRow(
                            icon: AppIcons.policy,
                            text: AppStaticStrings.privacyPolicy,
                            ontap: () {
                              Get.toNamed(AppRoute.privacyPolicy);
                            }),
                        //Term Condition

                        CustomRow(
                            icon: AppIcons.termCondition,
                            text: AppStaticStrings.termsConditions,
                            ontap: () {
                              Get.toNamed(AppRoute.termsCondition);
                            }),
                        //About Us

                        CustomRow(
                            icon: AppIcons.information,
                            text: AppStaticStrings.aboutUs,
                            ontap: () {
                              Get.toNamed(AppRoute.aboutUs);
                            }),

                        //Divider

                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 24),
                          height: 1,
                          width: double.infinity,
                          color: AppColors.pink60,
                        ),
                        //Log out

                        CustomRow(
                            icon: AppIcons.logoutWhite,
                            text: AppStaticStrings.logOut,
                            ontap: () {
                              AllPopUp.showDialogWith2Button(
                                context: context,
                                title: AppStaticStrings.areYouSureWantToLogOut,
                                button1Title: AppStaticStrings.yes,
                                button2Title: AppStaticStrings.no,
                                button1ontap: () async {
                                  Get.offAllNamed(AppRoute.signIn);

                                  final SharedPreferences prefs =
                                      await SharedPreferences.getInstance();

                                  await prefs.remove(
                                      SharedPreferenceHelper.isRememberMe);
                                  await prefs
                                      .remove(SharedPreferenceHelper.token);
                                  await prefs
                                      .remove(SharedPreferenceHelper.userIdKey);

                                  // DependencyInjection dI =
                                  //     DependencyInjection();
                                  // dI.disposeController();
                                },
                                button2ontap: () {},
                              );
                            }),
                      ],
                    )),
              ),
            ),

            //Upgrade to Premium Account button

            GestureDetector(
              onTap: () async {
                Get.toNamed(AppRoute.premiumPackages);
              },
              child: Container(
                margin: const EdgeInsets.only(bottom: 24),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: AppColors.white100),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomImage(
                      imageSrc: AppIcons.premium,
                      size: 16,
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    CustomText(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: AppColors.pink100,
                      text: AppStaticStrings.upgradeAccount,
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class CustomRow extends StatelessWidget {
  final String icon;
  final String text;
  final VoidCallback ontap;

  const CustomRow(
      {super.key, required this.icon, required this.text, required this.ontap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        ontap();
      },
      child: Padding(
        padding: const EdgeInsets.only(bottom: 16),
        child: Row(
          children: [
            CustomImage(
              size: 16,
              imageSrc: icon,
            ),
            const SizedBox(
              width: 8,
            ),
            CustomText(
              text: text,
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: AppColors.white100,
            )
          ],
        ),
      ),
    );
  }
}
