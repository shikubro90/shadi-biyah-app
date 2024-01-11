import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matrimony/core/global/resend_otp/resend_otp.dart';
import 'package:matrimony/core/route/app_route.dart';
import 'package:matrimony/utils/app_colors.dart';
import 'package:matrimony/utils/app_static_strings.dart';
import 'package:matrimony/view/screens/settings/otp_settings/verify_otp_setting_controller/verify_otp_setting_controller.dart';
import 'package:matrimony/view/widget/button/button.dart';
import 'package:matrimony/view/widget/customText/custom_text.dart';
import 'package:matrimony/view/widget/custom_appbar/custom_appbar.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OTPSettings extends StatefulWidget {
  const OTPSettings({super.key});

  @override
  State<OTPSettings> createState() => _OTPSettingsState();
}

class _OTPSettingsState extends State<OTPSettings> {
  final TextEditingController pinController = TextEditingController();
  int _secondsRemaining = 60;
  late Timer _timer;

  String email = Get.arguments;
  String oneTimeCode = "";
  bool isLoading = false;

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
    ResendOtp.resendOTP(email: email);
    startTimer();
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        top: false,
        child: Scaffold(
          appBar: const CustomAppBar(
            title: AppStaticStrings.otp,
          ),
          bottomNavigationBar: CustomButton(
            text: AppStaticStrings.verify,
            left: 20,
            right: 20,
            bottom: 24,
            ontap: () {
              setState(() {
                isLoading = true;
                VerifySettingOTP.verifySettingOtp(
                        email: email, oneTimeCode: oneTimeCode)
                    .then((value) {
                  setState(() {
                    isLoading = false;
                  });
                  if (value == true) {
                    Get.toNamed(AppRoute.resetPasswordSetting,
                        arguments: email);
                  }
                });
              });
            },
          ),
          body: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const CustomText(
                    maxLines: 2,
                    bottom: 16,
                    textAlign: TextAlign.left,
                    fontSize: 16,
                    color: AppColors.black100,
                    text: AppStaticStrings.pleaseentertheOTpEmail,
                  ),

                  //Pin field
                  SizedBox(
                    height: 60,
                    child: PinCodeTextField(
                      onCompleted: (value) {
                        setState(() {
                          oneTimeCode = value.toString();
                        });
                      },
                      cursorColor: AppColors.black40,
                      keyboardType: TextInputType.number,
                      controller: pinController,
                      appContext: (context),
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
                        //Text
                        const CustomText(
                          color: AppColors.black80,
                          text: AppStaticStrings.didNotGet,
                        ),
                        //Resend OTP button

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
          ),
        ));
  }
}
