import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:matrimony/utils/app_colors.dart';
import 'package:matrimony/utils/app_static_strings.dart';
import 'package:matrimony/view/screens/auth/sign_up/screens/mail_otp_verify/otp_controller/otp_controller.dart';
import 'package:matrimony/core/global/resend_otp/resend_otp.dart';
import 'package:matrimony/view/widget/button/button.dart';
import 'package:matrimony/view/widget/button/loading_button.dart';
import 'package:matrimony/view/widget/customText/custom_text.dart';
import 'package:matrimony/view/widget/custom_appbar_pink/custom_appbar_pink.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OtpVerifySignUp extends StatefulWidget {
  const OtpVerifySignUp({
    super.key,
  });

  @override
  State<OtpVerifySignUp> createState() => _OtpVerifySignUpState();
}

class _OtpVerifySignUpState extends State<OtpVerifySignUp> {
  final TextEditingController pinController = TextEditingController();
  int _secondsRemaining = 60;
  late Timer _timer;

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_secondsRemaining > 0) {
          _secondsRemaining--;
        } else {
          _timer.cancel();
        }
      });
    });
  }

  @override
  void initState() {
    startTimer();
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel(); // Cancel the timer to avoid memory leaks
    super.dispose();
  }

  String email = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SignUpOtpController>(builder: (controller) {
      return CustomAppBarPink(
          bottomNavBar: controller.isLoading
              ? const CustomLoadingButton(
                  bottom: 24,
                  left: 20,
                  right: 20,
                )
              : CustomButton(
                  text: AppStaticStrings.verify,
                  bottom: 24,
                  left: 20,
                  right: 20,
                  ontap: () {
                    controller.verifySignUpOtp();
                    //  Get.offAllNamed(AppRoute.uploadPhoto);
                  }),
          title: AppStaticStrings.oTPVerify,
          onBack: () {
            Get.back();
          },
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  const CustomText(
                    maxLines: 2,
                    top: 44,
                    bottom: 16,
                    textAlign: TextAlign.left,
                    fontSize: 16,
                    color: AppColors.black100,
                    text: AppStaticStrings.pleaseentertheOTpEmail,
                  ),
                  SizedBox(
                    height: 60,
                    child: PinCodeTextField(
                      cursorColor: AppColors.black40,
                      keyboardType: TextInputType.number,
                      controller: pinController,
                      appContext: (context),
                      onCompleted: (value) {
                        controller.oneTimeCode = value.toString();
                      },
                      autoFocus: true,
                      pinTheme: PinTheme(
                        shape: PinCodeFieldShape.box,
                        borderRadius: BorderRadius.circular(8),
                        fieldHeight: 56,
                        fieldWidth: 44,
                        activeFillColor: Colors.transparent,
                        selectedFillColor: Colors.transparent,
                        inactiveFillColor: Colors.transparent,
                        borderWidth: 0.5,
                        errorBorderColor: Colors.red,
                        selectedColor: AppColors.black100,
                        activeColor: AppColors.pink60,
                        inactiveColor: AppColors.black10,
                      ),
                      length: 6,
                      enableActiveFill: true,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 18),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const CustomText(
                          color: AppColors.black80,
                          text: AppStaticStrings.didNotGet,
                        ),

                        //Resend OTP
                        InkWell(
                          onTap: () {
                            if (_secondsRemaining == 0) {
                              _secondsRemaining = 60;
                              startTimer();
                              ResendOtp.resendOTP(email: email).then((value) {
                                if (value == false) {
                                  setState(() {
                                    _timer.cancel();
                                    _secondsRemaining = 0;
                                  });
                                }
                              });
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CustomText(
                              //  fontSize: 16,
                              //  fontWeight: FontWeight.w500,
                              color: AppColors.black80,
                              text: _secondsRemaining == 0
                                  ? AppStaticStrings.resetOTP
                                  : "${AppStaticStrings.resetSmsIn} $_secondsRemaining",
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ));
    });
  }
}
