import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:matrimony/core/route/app_route.dart';
import 'package:matrimony/utils/app_static_strings.dart';
import 'package:matrimony/view/widget/button/button.dart';
import 'package:matrimony/view/widget/customText/custom_text.dart';
import 'package:matrimony/view/widget/custom_appbar_pink/custom_appbar_pink.dart';
import 'package:matrimony/view/widget/text_editingField/textediting_field.dart';

class AboutContactInfo extends StatefulWidget {
  const AboutContactInfo({super.key});

  @override
  State<AboutContactInfo> createState() => _AboutContactInfoState();
}

class _AboutContactInfoState extends State<AboutContactInfo> {
  TextEditingController contactController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    contactController.text = Get.arguments[0];
    emailController.text = Get.arguments[1];
    bool phnVerified = Get.arguments[2];

    return CustomAppBarPink(
        bottomNavBar: CustomButton(
          ontap: () {
            navigator!.pop();
          },
          text: AppStaticStrings.save,
          bottom: 24,
          left: 20,
          right: 20,
        ),
        title: AppStaticStrings.editContactInformation,
        onBack: () {
          Get.back();
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //Email Section
              const CustomText(
                top: 16,
                text: AppStaticStrings.email,
                bottom: 8,
              ),

              CustomTextField(
                textEditingController: emailController,
                readOnly: true,
                hintText: AppStaticStrings.enterYourEmail,
              ),
              //Phone Number

              const CustomText(
                top: 16,
                text: AppStaticStrings.phoneNumber,
                bottom: 8,
              ),
              Row(
                children: [
                  // Expanded(
                  //   flex: 2,
                  //   child: Container(
                  //     padding: const EdgeInsets.symmetric(vertical: 2),
                  //     decoration: BoxDecoration(
                  //         borderRadius: BorderRadius.circular(8),
                  //         border: Border.all(color: AppColors.black10)),
                  //     child: const CountryCodePicker(
                  //       onChanged: print,
                  //       initialSelection: 'en',
                  //       favorite: ['+1', 'en'],
                  //       showCountryOnly: false,
                  //       showOnlyCountryWhenClosed: false,
                  //       alignLeft: false,
                  //     ),
                  //   ),
                  // ),
                  // const SizedBox(
                  //   width: 8,
                  // ),
                  Expanded(
                    flex: 4,
                    child: CustomTextField(
                      textEditingController: contactController,
                      // readOnly: false,
                      hintText: AppStaticStrings.phoneNumber,
                    ),
                  )
                ],
              ),

              if (phnVerified == false)
                InkWell(
                  onTap: () {
                    Get.toNamed(AppRoute.otpVerifyPhn);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomText(
                      fontWeight: FontWeight.w500,
                      top: 20.h,
                      text: AppStaticStrings.verifyPhn,
                    ),
                  ),
                )
            ],
          ),
        ));
  }
}
