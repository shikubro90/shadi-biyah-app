import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matrimony/utils/app_colors.dart';
import 'package:matrimony/utils/app_static_strings.dart';
import 'package:matrimony/view/screens/settings/reset_pass_setting/reset_pass_controller/reset_pass_controller.dart';
import 'package:matrimony/view/widget/button/button.dart';
import 'package:matrimony/view/widget/customText/custom_text.dart';
import 'package:matrimony/view/widget/custom_appbar/custom_appbar.dart';
import 'package:matrimony/view/widget/text_editingField/textediting_field.dart';

class ResetPasswordSetting extends StatefulWidget {
  const ResetPasswordSetting({super.key});

  @override
  State<ResetPasswordSetting> createState() => _ResetPasswordSettingState();
}

class _ResetPasswordSettingState extends State<ResetPasswordSetting> {
  TextEditingController newPassController = TextEditingController();
  TextEditingController confirmPassController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  String email = Get.arguments;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        top: false,
        child: Scaffold(
          appBar: const CustomAppBar(
            title: AppStaticStrings.resetPassword,
          ),
          bottomNavigationBar: CustomButton(
            text: AppStaticStrings.resetPassword,
            left: 20,
            right: 20,
            bottom: 24,
            ontap: () {
              if (formKey.currentState!.validate()) {
                ResetPassSettingController.resetPass(
                    email: email, newPassword: confirmPassController.text);
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
                    //Suggestion Text
                    const CustomText(
                      maxLines: 2,
                      bottom: 16,
                      textAlign: TextAlign.left,
                      color: AppColors.black100,
                      text: AppStaticStrings.yourPassMustBe,
                    ),
                    //Set a new Password

                    const CustomText(
                      bottom: 8,
                      textAlign: TextAlign.left,
                      color: AppColors.black100,
                      text: AppStaticStrings.setaNewPassword,
                    ),
                    CustomTextField(
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
                      isPassword: true,
                      textEditingController: newPassController,
                      readOnly: false,
                      hintText: AppStaticStrings.enterNewPassword,
                    ),

                    //Confirm Password

                    const CustomText(
                      top: 16,
                      bottom: 8,
                      textAlign: TextAlign.left,
                      color: AppColors.black100,
                      text: AppStaticStrings.confirmNewPassword,
                    ),
                    CustomTextField(
                      validator: (value) {
                        if (value.isEmpty) {
                          return AppStaticStrings.fieldCantBeEmpty;
                        } else if (newPassController.text !=
                            confirmPassController.text) {
                          return AppStaticStrings.passDoesNotMatch;
                        } else {
                          return null;
                        }
                      },
                      isPassword: true,
                      textEditingController: confirmPassController,
                      readOnly: false,
                      hintText: AppStaticStrings.reTypepassword,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
