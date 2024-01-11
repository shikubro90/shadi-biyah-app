import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matrimony/core/helper/sharedpreference_helper.dart';
import 'package:matrimony/core/route/app_route.dart';
import 'package:matrimony/utils/app_colors.dart';
import 'package:matrimony/utils/app_icons.dart';
import 'package:matrimony/utils/app_static_strings.dart';
import 'package:matrimony/utils/device_utils.dart';
import 'package:matrimony/view/screens/home/home_controller/home_controller.dart';
import 'package:matrimony/view/widget/customText/custom_text.dart';
import 'package:matrimony/view/widget/custom_appbar/custom_appbar.dart';
import 'package:matrimony/view/widget/custom_img/custom_img.dart';
import 'package:matrimony/view/widget/pop_up/all_pop_up.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  void initState() {
    DeviceUtils.statusBarColor();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        top: false,
        child: Scaffold(
          appBar: const CustomAppBar(
            title: AppStaticStrings.settings,
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  //ChangePassword

                  SettingsCustom(
                    icon: AppIcons.lock,
                    text: AppStaticStrings.changePassword,
                    ontap: () {
                      Get.toNamed(AppRoute.changePassSetting);
                    },
                  ),

                  //Login Activity

                  SettingsCustom(
                    icon: AppIcons.deviceMobile,
                    text: AppStaticStrings.loginActivity,
                    ontap: () {
                      Get.toNamed(AppRoute.loginActivity);
                    },
                  ),

                  //Delete Account

                  SettingsCustom(
                    icon: AppIcons.trash,
                    text: AppStaticStrings.deleteAccount,
                    ontap: () {
                      Get.toNamed(AppRoute.deleteAccount);
                    },
                  ),

                  //Upgrade Account

                  SettingsCustom(
                    icon: AppIcons.premiumpink,
                    text: AppStaticStrings.upgradeAccount,
                    ontap: () {
                      Get.toNamed(AppRoute.premiumPackages);
                    },
                  ),
                  //Log Out

                  SettingsCustom(
                    icon: AppIcons.logout,
                    text: AppStaticStrings.logOut,
                    ontap: () {
                      AllPopUp.showDialogWith2Button(
                          button1ontap: () async {
                            final SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                            await prefs
                                .remove(SharedPreferenceHelper.isRememberMe);
                            await prefs.remove(SharedPreferenceHelper.token);
                            await prefs
                                .remove(SharedPreferenceHelper.userIdKey);
                            if (Get.isRegistered<HomeController>()) {
                              HomeController homeController =
                                  Get.find<HomeController>();
                              homeController.dispose();
                            }
                            Get.offAllNamed(AppRoute.signIn);
                          },
                          button2ontap: () {},
                          context: context,
                          title:
                              AppStaticStrings.youSureWantToLogOutYourProfile,
                          button1Title: AppStaticStrings.logOut,
                          button2Title: AppStaticStrings.cancel);
                    },
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}

class SettingsCustom extends StatelessWidget {
  final String icon;
  final String text;
  final VoidCallback ontap;

  const SettingsCustom(
      {super.key, required this.icon, required this.text, required this.ontap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        ontap();
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
        decoration: BoxDecoration(
            border: Border.all(color: AppColors.black20),
            borderRadius: BorderRadius.circular(8)),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: AppColors.pink5),
              child: CustomImage(imageSrc: icon),
            ),
            CustomText(
              left: 16,
              text: text,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            )
          ],
        ),
      ),
    );
  }
}
