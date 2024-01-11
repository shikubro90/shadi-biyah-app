import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matrimony/core/route/app_route.dart';
import 'package:matrimony/utils/app_colors.dart';
import 'package:matrimony/utils/app_images.dart';
import 'package:matrimony/utils/app_static_strings.dart';
import 'package:matrimony/core/global/resend_otp/resend_otp.dart';
import 'package:matrimony/view/widget/button/button.dart';
import 'package:matrimony/view/widget/button/loading_button.dart';
import 'package:matrimony/view/widget/customText/custom_text.dart';
import 'package:matrimony/view/widget/custom_appbar_pink/custom_appbar_pink.dart';
import 'package:matrimony/view/widget/custom_img/custom_img.dart';
import 'package:matrimony/view/widget/text_editingField/textediting_field.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  TextEditingController emailController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  bool isloading = false;
  @override
  Widget build(BuildContext context) {
    return CustomAppBarPink(
        bottomNavBar: isloading
            ? const CustomLoadingButton(
                bottom: 24,
                left: 20,
                right: 20,
              )
            : CustomButton(
                text: AppStaticStrings.continuee,
                bottom: 24,
                left: 20,
                right: 20,
                ontap: () {
                  if (formKey.currentState!.validate()) {
                    setState(() {
                      isloading = true;
                      ResendOtp.resendOTP(email: emailController.text)
                          .then((value) {
                        if (value == true) {
                          setState(() {
                            isloading = false;
                            Get.toNamed(AppRoute.otpSignin,
                                arguments: emailController.text);
                          });
                        }
                      });
                    });
                  }
                }),
        title: AppStaticStrings.forgetPassword,
        onBack: () {
          Get.back();
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                const CustomImage(top: 24, imageSrc: AppImages.forgetpass),
                const CustomText(
                  maxLines: 2,
                  top: 44,
                  bottom: 16,
                  textAlign: TextAlign.left,
                  fontSize: 16,
                  color: AppColors.black100,
                  text: AppStaticStrings.pleaseEnterYourEmail,
                ),
                Form(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  key: formKey,
                  child: CustomTextField(
                    textEditingController: emailController,
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Please enter your email";
                      } else if (!RegExp(
                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          .hasMatch(emailController.text)) {
                        return AppStaticStrings.enterValidEmail;
                      } else {
                        return null;
                      }
                    },
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
