import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matrimony/core/route/app_route.dart';
import 'package:matrimony/utils/app_colors.dart';
import 'package:matrimony/utils/app_images.dart';
import 'package:matrimony/utils/app_static_strings.dart';
import 'package:matrimony/view/screens/auth/sign_in/screens/reset_pass/reset_pass_controller/reset_pass_controller.dart';
import 'package:matrimony/view/widget/button/button.dart';
import 'package:matrimony/view/widget/customText/custom_text.dart';
import 'package:matrimony/view/widget/custom_appbar_pink/custom_appbar_pink.dart';
import 'package:matrimony/view/widget/custom_img/custom_img.dart';
import 'package:matrimony/view/widget/text_editingField/textediting_field.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final formKey = GlobalKey<FormState>();
  TextEditingController newPassController = TextEditingController();
  TextEditingController confirmPassController = TextEditingController();

  String email = Get.arguments;

  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return CustomAppBarPink(
        bottomNavBar: CustomButton(
            text: AppStaticStrings.resetPassword,
            bottom: 24,
            left: 20,
            right: 20,
            ontap: () {
              setState(() {
                isLoading = true;
                if (formKey.currentState!.validate()) {
                  ResetPassController.resetPass(
                          email: email, newPassword: confirmPassController.text)
                      .then((value) {
                    setState(() {
                      isLoading = false;
                    });
                    if (value == true) {
                      Get.offAllNamed(AppRoute.signIn);
                    }
                  });
                }
              });
            }),
        title: AppStaticStrings.resetPassword,
        onBack: () {
          Get.back();
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                const CustomImage(top: 24, imageSrc: AppImages.resetPass),
                const CustomText(
                  maxLines: 2,
                  top: 44,
                  bottom: 24,
                  textAlign: TextAlign.left,
                  fontSize: 16,
                  color: AppColors.black100,
                  text: AppStaticStrings.yourPassMustBe,
                ),
                Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //New PassWord
                        const CustomText(
                          bottom: 8,
                          textAlign: TextAlign.left,
                          color: AppColors.black100,
                          text: AppStaticStrings.setaNewPassword,
                        ),
                        CustomTextField(
                          textEditingController: newPassController,
                          validator: (value) {
                            if (value.isEmpty) {
                              return AppStaticStrings.fieldCantBeEmpty;
                            } else if (value.length < 8) {
                              return AppStaticStrings.passwordLength;
                            } else if (!RegExp(r'(?=.*[a-zA-Z])(?=.*\d)')
                                .hasMatch(value)) {
                              return 'Password must contain both alphabets and numerics';
                            } else {
                              return null;
                            }
                          },
                          readOnly: false,
                          hintText: AppStaticStrings.enterNewPassword,
                        ),
                        //Confirm PassWord
                        const CustomText(
                          top: 16,
                          bottom: 8,
                          textAlign: TextAlign.left,
                          color: AppColors.black100,
                          text: AppStaticStrings.confirmNewPassword,
                        ),
                        CustomTextField(
                          textEditingController: confirmPassController,
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
                          readOnly: false,
                          hintText: AppStaticStrings.reEnterYourPassword,
                        ),
                      ],
                    )),
              ],
            ),
          ),
        ));
  }
}
