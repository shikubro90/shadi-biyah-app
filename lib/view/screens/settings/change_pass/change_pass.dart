import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matrimony/core/route/app_route.dart';
import 'package:matrimony/utils/app_colors.dart';
import 'package:matrimony/utils/app_static_strings.dart';
import 'package:matrimony/view/screens/settings/change_pass/change_pass_repo/change_pass_repo.dart';
import 'package:matrimony/view/widget/button/button.dart';
import 'package:matrimony/view/widget/customText/custom_text.dart';
import 'package:matrimony/view/widget/custom_appbar/custom_appbar.dart';
import 'package:matrimony/view/widget/text_editingField/textediting_field.dart';

class ChangePasswordSetting extends StatefulWidget {
  const ChangePasswordSetting({super.key});

  @override
  State<ChangePasswordSetting> createState() => _ChangePasswordSettingState();
}

class _ChangePasswordSettingState extends State<ChangePasswordSetting> {
  TextEditingController currentPassController = TextEditingController();
  TextEditingController newPassController = TextEditingController();
  TextEditingController retypePassController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        top: false,
        child: Scaffold(
          appBar: const CustomAppBar(
            title: AppStaticStrings.changePassword,
          ),
          bottomNavigationBar: CustomButton(
            text: AppStaticStrings.changePassword,
            left: 20,
            right: 20,
            bottom: 24,
            ontap: () {
              if (formKey.currentState!.validate()) {
                ChangePassController.resetPassRepo(
                    newPassword: retypePassController.text,
                    oldPassword: currentPassController.text);
              }
            },
          ),
          body: Padding(
            padding: const EdgeInsets.only(
              left: 20,
              right: 20,
            ),
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //Current Password

                    const CustomText(
                      bottom: 8,
                      textAlign: TextAlign.left,
                      color: AppColors.black100,
                      text: AppStaticStrings.currentPassword,
                    ),
                    CustomTextField(
                      isPassword: true,
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
                      textEditingController: currentPassController,
                      readOnly: false,
                      hintText: AppStaticStrings.enterYourCurrPass,
                    ),

                    //New Password

                    const CustomText(
                      top: 16,
                      bottom: 8,
                      textAlign: TextAlign.left,
                      color: AppColors.black100,
                      text: AppStaticStrings.enterNewPassword,
                    ),
                    CustomTextField(
                      isPassword: true,
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
                      textEditingController: newPassController,
                      readOnly: false,
                      hintText: AppStaticStrings.enterNewPassword,
                    ),

                    //Re-Type Password

                    const CustomText(
                      top: 16,
                      bottom: 8,
                      textAlign: TextAlign.left,
                      color: AppColors.black100,
                      text: AppStaticStrings.reTypepassword,
                    ),
                    CustomTextField(
                      isPassword: true,
                      validator: (value) {
                        if (value.isEmpty) {
                          return AppStaticStrings.fieldCantBeEmpty;
                        } else if (newPassController.text !=
                            retypePassController.text) {
                          return AppStaticStrings.passDoesNotMatch;
                        } else {
                          return null;
                        }
                      },
                      textEditingController: retypePassController,
                      readOnly: false,
                      hintText: AppStaticStrings.reTypepassword,
                    ),

                    //Forget Password?

                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Get.toNamed(AppRoute.forgetPassSettings);
                          },
                          child: const CustomText(
                            top: 16,
                            fontWeight: FontWeight.w500,
                            color: AppColors.pink100,
                            text: AppStaticStrings.forgetPasswordQuestion,
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
