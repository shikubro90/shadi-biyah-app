import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:matrimony/core/route/app_route.dart';
import 'package:matrimony/utils/app_colors.dart';
import 'package:matrimony/utils/app_icons.dart';
import 'package:matrimony/utils/app_images.dart';
import 'package:matrimony/utils/app_static_strings.dart';
import 'package:matrimony/utils/device_utils.dart';
import 'package:matrimony/view/screens/auth/sign_in/sign_in_controller/sign_in_controller.dart';
import 'package:matrimony/view/widget/button/button.dart';
import 'package:matrimony/view/widget/button/loading_button.dart';
import 'package:matrimony/view/widget/customText/custom_text.dart';
import 'package:matrimony/view/widget/custom_img/custom_img.dart';
import 'package:matrimony/view/widget/pop_up/all_pop_up.dart';
import 'package:matrimony/view/widget/text_editingField/textediting_field.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  @override
  void initState() {
    DeviceUtils.statusBarColor();
    super.initState();
  }

  bool rememberMe = true;
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Show the exit confirmation dialog
        bool exit = await showDialog(
          context: context,
          builder: (BuildContext context) {
            return const ExitConfirmationDialog();
          },
        );

        // Return true if the user wants to exit, false otherwise
        return exit;
      },
      child: GetBuilder<SignInController>(builder: (controller) {
        return SafeArea(
          top: false,
          child: Scaffold(
            body: SingleChildScrollView(
              child: Column(
                children: [
                  //Top Design

                  Stack(
                    alignment: Alignment.center,
                    clipBehavior: Clip.none,
                    children: [
                      const CustomImage(
                          imageType: ImageType.png, imageSrc: AppImages.shape),
                      Positioned(
                        bottom: -50,
                        child: Container(
                          width: 128,
                          height: 128,
                          padding: const EdgeInsets.all(20),
                          decoration: const BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                  blurStyle: BlurStyle.outer,
                                  spreadRadius: 2,
                                  color: AppColors.black5)
                            ],
                            shape: BoxShape.circle,
                            color: AppColors.white100,
                          ),
                          child: const CustomImage(
                              imageType: ImageType.png,
                              imageSrc: AppIcons.logo),
                        ),
                      ),
                    ],
                  ),
                  const CustomText(
                    color: AppColors.black100,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    top: 64,
                    bottom: 44,
                    text: AppStaticStrings.welcomeSignIn,
                  ),

                  //Text Form Fields
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //Email Section

                          const CustomText(
                            color: AppColors.black100,
                            text: AppStaticStrings.email,
                            bottom: 8,
                          ),

                          CustomTextField(
                            textEditingController: controller.emailController,
                            readOnly: false,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return AppStaticStrings.enterYourEmail;
                              } else if (!AppStaticStrings.emailRegexp
                                  .hasMatch(controller.emailController.text)) {
                                return AppStaticStrings.enterValidEmail;
                              } else {
                                return null;
                              }
                            },
                            hintText: AppStaticStrings.enterYourEmail,
                          ),
                          //PassWord Section

                          const CustomText(
                            color: AppColors.black100,
                            text: AppStaticStrings.password,
                            bottom: 8,
                            top: 16,
                          ),
                          CustomTextField(
                            textEditingController: controller.passController,
                            textInputAction: TextInputAction.done,
                            readOnly: false,
                            validator: (value) {
                              if (value == null || value.toString().isEmpty) {
                                return AppStaticStrings.pleaseEnterYourPass;
                              }
                              return null;
                            },
                            isPassword: true,
                            hintText: AppStaticStrings.enterYourPass,
                          ),

                          //Remember me Row
                          Padding(
                            padding: const EdgeInsets.only(top: 16, bottom: 50),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                //Remember Me
                                Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          rememberMe = !rememberMe;
                                        });
                                      },
                                      child: Container(
                                        height: 20,
                                        width: 20,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              color: AppColors.black20),
                                          color: rememberMe
                                              ? AppColors.pink100
                                              : null,
                                          borderRadius:
                                              BorderRadius.circular(4),
                                        ),
                                        child: Center(
                                          child: rememberMe
                                              ? SvgPicture.asset(
                                                  AppIcons.check,
                                                ) // Change the color to fit your design
                                              : null,
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {},
                                      child: const CustomText(
                                        left: 10,
                                        text: AppStaticStrings.rememberMe,
                                        color: AppColors.black100,
                                      ),
                                    )
                                  ],
                                ),
                                //Forget Password
                                GestureDetector(
                                  onTap: () {
                                    Get.toNamed(AppRoute.forgetPass);
                                  },
                                  child: const CustomText(
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.pink100,
                                    text:
                                        AppStaticStrings.forgetPasswordQuestion,
                                  ),
                                )
                              ],
                            ),
                          ),
                          //Sign In Button
                          controller.isLoading
                              ? const CustomLoadingButton()
                              : CustomButton(
                                  text: AppStaticStrings.signIn,
                                  ontap: () {
                                    if (formKey.currentState!.validate()) {
                                      //Check if VPN is connected then Sign IN or Show Warning

                                      controller.getVPNconnection(
                                          rememberMe: rememberMe);
                                    }
                                  }),

                          //Don't Have an Account

                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 24),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const CustomText(
                                  color: AppColors.black100,
                                  text: AppStaticStrings.dontHaveanAccount,
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                GestureDetector(
                                  onTap: () async {
                                    Get.toNamed(AppRoute.createProfileFor);
                                  },
                                  child: const CustomText(
                                    color: AppColors.pink100,
                                    text: AppStaticStrings.createNow,
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
