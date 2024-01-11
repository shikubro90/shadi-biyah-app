import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matrimony/core/route/app_route.dart';
import 'package:matrimony/utils/app_colors.dart';
import 'package:matrimony/utils/app_static_strings.dart';
import 'package:matrimony/view/widget/button/button.dart';
import 'package:matrimony/view/widget/customText/custom_text.dart';
import 'package:matrimony/view/widget/custom_appbar/custom_appbar.dart';
import 'package:matrimony/view/widget/text_editingField/textediting_field.dart';

class ForgetPassSetting extends StatefulWidget {
  const ForgetPassSetting({super.key});

  @override
  State<ForgetPassSetting> createState() => _ForgetPassSettingState();
}

class _ForgetPassSettingState extends State<ForgetPassSetting> {
  TextEditingController emailController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        top: false,
        child: Scaffold(
          appBar: const CustomAppBar(
            title: AppStaticStrings.forgetPasswordQuestion,
          ),
          bottomNavigationBar: CustomButton(
            text: AppStaticStrings.continuee,
            left: 20,
            right: 20,
            bottom: 24,
            ontap: () {
              if (formKey.currentState!.validate()) {
                Get.toNamed(AppRoute.otpSettings,
                    arguments: emailController.text);
              }
            },
          ),
          body: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //Current Password

                const CustomText(
                  maxLines: 2,
                  bottom: 16,
                  textAlign: TextAlign.left,
                  color: AppColors.black100,
                  text: AppStaticStrings.pleaseEnterYourEmail,
                ),
                Form(
                  key: formKey,
                  child: CustomTextField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return AppStaticStrings.pleaseEnterYourEmail;
                      } else if (!AppStaticStrings.emailRegexp
                          .hasMatch(emailController.text)) {
                        return AppStaticStrings.enterValidEmail;
                      } else {
                        return null;
                      }
                    },
                    textEditingController: emailController,
                    readOnly: false,
                    hintText: AppStaticStrings.enterYourEmail,
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
