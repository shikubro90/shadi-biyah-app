import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matrimony/utils/app_colors.dart';
import 'package:matrimony/utils/app_static_strings.dart';
import 'package:matrimony/view/screens/auth/sign_up/screens/about_yourself/about_yourself_controller/about_yourself_controller.dart';
import 'package:matrimony/view/widget/button/button.dart';
import 'package:matrimony/view/widget/button/loading_button.dart';
import 'package:matrimony/view/widget/customText/custom_text.dart';
import 'package:matrimony/view/widget/custom_appbar_pink/custom_appbar_pink.dart';
import 'package:matrimony/view/widget/text_editingField/textediting_field.dart';

class AboutYourSelf extends StatefulWidget {
  const AboutYourSelf({super.key});

  @override
  State<AboutYourSelf> createState() => _AboutYourSelfState();
}

class _AboutYourSelfState extends State<AboutYourSelf> {
  String title = Get.arguments[0];
  String description = Get.arguments[1];
  bool isUpdate = Get.arguments[2];

  AboutYourSelfController aboutYourController =
      Get.find<AboutYourSelfController>();

  @override
  void initState() {
    aboutYourController.aboutTextEdiController.text = description;

    super.initState();
  }

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AboutYourSelfController>(builder: (controller) {
      return CustomAppBarPink(
          bottomNavBar: controller.isLoading
              ? const CustomLoadingButton(
                  bottom: 24,
                  left: 20,
                  right: 20,
                )
              : CustomButton(
                  text: isUpdate
                      ? AppStaticStrings.save
                      : AppStaticStrings.createProfile,
                  bottom: 24,
                  left: 20,
                  right: 20,
                  ontap: () {
                    if (formKey.currentState!.validate()) {
                      // isUpdate
                      //     ? {controller.updateAboutMe(), navigator!.pop()}
                      //     : controller.updateAboutMe();
                      controller.updateAboutMe(isUpdate: isUpdate);
                    }
                  }),
          title: title,
          onBack: () {
            Get.back();
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CustomText(
                    bottom: 12,
                    text: AppStaticStrings.aboutYourself,
                  ),
                  Form(
                    key: formKey,
                    child: CustomTextField(
                      validator: (value) {
                        if (value == null || value.toString().isEmpty) {
                          return AppStaticStrings.fieldCantBeEmpty;
                        }
                        return null;
                      },
                      textEditingController:
                          aboutYourController.aboutTextEdiController,
                      readOnly: false,
                      focusBorderColor: AppColors.pink100,
                      maxLines: 10,
                    ),
                  )
                ],
              ),
            ),
          ));
    });
  }
}
