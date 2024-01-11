import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matrimony/utils/app_colors.dart';
import 'package:matrimony/utils/app_static_strings.dart';
import 'package:matrimony/view/widget/button/button.dart';
import 'package:matrimony/view/widget/customText/custom_text.dart';

import 'package:matrimony/view/widget/text_editingField/textediting_field.dart';

class Payment extends StatefulWidget {
  const Payment({super.key});

  @override
  State<Payment> createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        top: false,
        child: Scaffold(
          bottomNavigationBar: CustomButton(
            text: AppStaticStrings.makepayment,
            bottom: 24,
            left: 20,
            right: 20,
            ontap: () {
              //   AllPopUp.paymentSuccessfull(context: context);
            },
          ),
          body: Padding(
            padding: const EdgeInsets.only(top: 44, left: 20, right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //App Bar
                Padding(
                  padding: const EdgeInsets.only(bottom: 24),
                  child: Row(
                    children: [
                      GestureDetector(
                          onTap: () {
                            Get.back();
                          },
                          child: const Icon(
                              color: AppColors.black60,
                              size: 18,
                              Icons.arrow_back_ios_rounded)),
                      const SizedBox(
                        width: 8,
                      ),
                      const CustomText(
                        text: AppStaticStrings.payment,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ],
                  ),
                ),

                //Content
                const Expanded(
                    child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //Card Number
                      CustomText(
                        text: AppStaticStrings.cardNumber,
                        bottom: 8,
                      ),

                      CustomTextField(
                        readOnly: false,
                        hintText: AppStaticStrings.entercardnumber,
                      ),

                      //Expire Date
                      CustomText(
                        top: 16,
                        text: AppStaticStrings.expiredDate,
                        bottom: 8,
                      ),

                      CustomTextField(
                        readOnly: false,
                        hintText: AppStaticStrings.mMYY,
                      ),

                      //CVV/CVC
                      CustomText(
                        top: 16,
                        text: AppStaticStrings.cVVCVC,
                        bottom: 8,
                      ),

                      CustomTextField(
                        readOnly: false,
                        hintText: AppStaticStrings.cVVCVC,
                      ),

                      //Card Holder name

                      CustomText(
                        top: 16,
                        text: AppStaticStrings.cardHolderName,
                        bottom: 8,
                      ),

                      CustomTextField(
                        readOnly: false,
                        hintText: AppStaticStrings.entercardholdername,
                      ),

                      //Enter Ammount

                      CustomText(
                        top: 16,
                        text: AppStaticStrings.amount,
                        bottom: 8,
                      ),

                      CustomTextField(
                        readOnly: false,
                        hintText: "\$",
                      ),
                    ],
                  ),
                )),
              ],
            ),
          ),
        ));
  }
}
