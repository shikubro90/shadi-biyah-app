import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:matrimony/core/route/app_route.dart';
import 'package:matrimony/utils/app_colors.dart';
import 'package:matrimony/utils/app_icons.dart';
import 'package:matrimony/utils/app_static_strings.dart';
import 'package:matrimony/utils/app_utils.dart';
import 'package:matrimony/view/screens/auth/sign_up/sign_up_controller/sign_up_controller.dart';
import 'package:matrimony/view/widget/button/button.dart';
import 'package:matrimony/view/widget/button/loading_button.dart';
import 'package:matrimony/view/widget/customText/custom_text.dart';
import 'package:matrimony/view/widget/custom_appbar_pink/custom_appbar_pink.dart';
import 'package:matrimony/view/widget/text_editingField/textediting_field.dart';

class LogInDetails extends StatefulWidget {
  const LogInDetails({super.key});

  @override
  State<LogInDetails> createState() => _LogInDetailsState();
}

class _LogInDetailsState extends State<LogInDetails> {
  final TextStyle style = GoogleFonts.poppins(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.black100,
  );

  bool isAgree = true;
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return CustomAppBarPink(
        bottomNavBar: Container(
          color: AppColors.white100,
          height: 160,
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: GetBuilder<SignUpController>(builder: (controller) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    //I Agree box

                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isAgree = !isAgree;
                        });
                      },
                      child: Container(
                        height: 20,
                        width: 20,
                        decoration: BoxDecoration(
                          border: Border.all(color: AppColors.black20),
                          color: isAgree ? AppColors.pink100 : null,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Center(
                          child: isAgree
                              ? SvgPicture.asset(
                                  AppIcons.check,
                                )
                              : null,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    //Text

                    Expanded(
                      child: RichText(
                        maxLines: 2,
                        text: TextSpan(
                          children: <TextSpan>[
                            TextSpan(
                                text: AppStaticStrings.iHaveReadAndAgree,
                                style: style),
                            TextSpan(
                              text: AppStaticStrings.termsConditions,
                              style: GoogleFonts.poppins(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: AppColors.pink100,
                                decoration: TextDecoration.underline,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  // Navigate to the Terms & Conditions screen
                                  Get.toNamed(AppRoute.termsCondition);
                                },
                            ),
                            TextSpan(text: ' & ', style: style),
                            TextSpan(
                              text: AppStaticStrings.privacyPolicy,
                              style: GoogleFonts.poppins(
                                color: AppColors.pink100,
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                decoration: TextDecoration.underline,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  // Navigate to the Privacy Policy screen
                                  Get.toNamed(AppRoute.privacyPolicy);
                                },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                //  Button

                controller.isLoading
                    ? const CustomLoadingButton(
                        bottom: 24,
                        left: 20,
                        right: 20,
                      )
                    : CustomButton(
                        top: 24,
                        text: AppStaticStrings.continuee,
                        bottom: 24,
                        ontap: () async {
                          if (isAgree) {
                            if (formKey.currentState!.validate()) {
                              //Check if VPN is connected then Sign IN or Show Warning
                              await controller.getVPNconnection();
                            }
                          } else {
                            TostMessage.toastMessage(
                                message:
                                    AppStaticStrings.agreeToTermsAndCondition);
                          }
                        }),
              ],
            );
          }),
        ),
        title: AppStaticStrings.loginDetails,
        onBack: () {
          Get.back();
        },
        child: GetBuilder<SignUpController>(builder: (controller) {
          //Setting a default country code
          controller.countryCodeController.text = "+93";
          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 24),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //Name Section
                    const CustomText(
                      text: AppStaticStrings.name,
                      bottom: 8,
                    ),

                    CustomTextField(
                      keyboardType: TextInputType.name,
                      textEditingController: controller.nameController,
                      validator: (value) {
                        if (value == null || value.toString().isEmpty) {
                          return AppStaticStrings.fieldCantBeEmpty;
                        } else if (value.length < 5) {
                          return AppStaticStrings.nameLength;
                        }
                        return null;
                      },
                      readOnly: false,
                      hintText: AppStaticStrings.enterYourName,
                    ),
                    //Email Section
                    const CustomText(
                      top: 16,
                      text: AppStaticStrings.email,
                      bottom: 8,
                    ),

                    CustomTextField(
                      textEditingController: controller.emailController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return AppStaticStrings.pleaseEnterYourEmail;
                        } else if (!AppStaticStrings.emailRegexp
                            .hasMatch(controller.emailController.text)) {
                          return AppStaticStrings.enterValidEmail;
                        } else {
                          return null;
                        }
                      },
                      readOnly: false,
                      hintText: AppStaticStrings.enterYourEmail,
                    ),

                    //Phone Number

                    const CustomText(
                      top: 16,
                      text: AppStaticStrings.phoneNumber,
                      bottom: 8,
                    ),

                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 2,
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 4),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: AppColors.black10)),
                            child: CountryCodePicker(
                              onChanged: (value) {
                                controller.countryCodeController.text =
                                    value.dialCode.toString();
                              },

                              showCountryOnly: false,
                              // optional. Shows only country name and flag when popup is closed.
                              showOnlyCountryWhenClosed: false,
                              // optional. aligns the flag and the Text left
                              alignLeft: false,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Expanded(
                          flex: 3,
                          child: CustomTextField(
                            textEditingController:
                                controller.phoneNumController,
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value.isEmpty) {
                                return AppStaticStrings.fieldCantBeEmpty;
                              } else {
                                return null;
                              }
                            },
                            readOnly: false,
                            hintText: AppStaticStrings.enterYourPhoneNumber,
                          ),
                        )
                      ],
                    ),

                    //Password Section
                    const CustomText(
                      color: AppColors.black100,
                      text: AppStaticStrings.password,
                      bottom: 8,
                      top: 16,
                    ),

                    //Input Password
                    CustomTextField(
                      textEditingController: controller.passController,
                      validator: (value) {
                        if (value.isEmpty) {
                          return AppStaticStrings.fieldCantBeEmpty;
                        } else if (value.length < 8) {
                          return AppStaticStrings.passwordLength;
                        } else if (!AppStaticStrings.passRegExp
                            .hasMatch(value)) {
                          return AppStaticStrings.passMustContainBoth;
                        } else {
                          return null;
                        }
                      },
                      readOnly: false,
                      isPassword: true,
                      hintText: AppStaticStrings.enterYourPass,
                    ),
                    //Confirm Password Section

                    const CustomText(
                      color: AppColors.black100,
                      text: AppStaticStrings.confirmPassword,
                      bottom: 8,
                      top: 16,
                    ),
                    CustomTextField(
                      validator: (value) {
                        if (value.isEmpty) {
                          return AppStaticStrings.fieldCantBeEmpty;
                        } else if (controller.passController.text !=
                            controller.confirmPassController.text) {
                          return AppStaticStrings.passDoesNotMatch;
                        } else {
                          return null;
                        }
                      },
                      textEditingController: controller.confirmPassController,
                      readOnly: false,
                      isPassword: true,
                      hintText: AppStaticStrings.reTypepassword,
                    ),
                    const SizedBox(
                      height: 10,
                    )
                  ],
                ),
              ),
            ),
          );
        }));
  }
}
