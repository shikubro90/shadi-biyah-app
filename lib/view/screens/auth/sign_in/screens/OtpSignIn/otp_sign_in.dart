import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matrimony/core/route/app_route.dart';
import 'package:matrimony/utils/app_colors.dart';
import 'package:matrimony/utils/app_images.dart';
import 'package:matrimony/utils/app_static_strings.dart';
import 'package:matrimony/core/global/resend_otp/resend_otp.dart';
import 'package:matrimony/view/screens/auth/sign_in/screens/OtpSignIn/verify_otp_signin_controller/verify_otp_signin_controller.dart';
import 'package:matrimony/view/widget/button/button.dart';
import 'package:matrimony/view/widget/button/loading_button.dart';
import 'package:matrimony/view/widget/customText/custom_text.dart';
import 'package:matrimony/view/widget/custom_appbar_pink/custom_appbar_pink.dart';
import 'package:matrimony/view/widget/custom_img/custom_img.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OtpSignIn extends StatefulWidget {
  const OtpSignIn({super.key});
  @override
  State<OtpSignIn> createState() => _OtpSignInState();
}

class _OtpSignInState extends State<OtpSignIn> {
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
    _timer.cancel();
    super.dispose();
  }

  String email = Get.arguments;
  String oneTimeCode = "";
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return CustomAppBarPink(
        bottomNavBar: isLoading
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
                  setState(() {
                    isLoading = true;
                    VerifySignInOTP.verifySignInOtp(
                            email: email, oneTimeCode: oneTimeCode)
                        .then((value) {
                      setState(() {
                        isLoading = false;
                      });
                      if (value == true) {
                        Get.toNamed(AppRoute.resetPassSignIn, arguments: email);
                      }
                    });
                  });
                }),
        title: AppStaticStrings.otp,
        onBack: () {
          Get.back();
        },
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                const CustomImage(top: 24, imageSrc: AppImages.otp),
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
                      setState(() {
                        oneTimeCode = value.toString();
                      });
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
                      activeColor: AppColors.pink100,
                      inactiveColor: const Color(0xFFCCCCCC),
                    ),
                    length: 6,
                    enableActiveFill: true,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16),
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
  }
}
