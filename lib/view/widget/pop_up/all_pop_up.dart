import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matrimony/core/route/app_route.dart';
import 'package:matrimony/utils/app_colors.dart';
import 'package:matrimony/utils/app_icons.dart';
import 'package:matrimony/utils/app_static_strings.dart';
import 'package:matrimony/view/screens/auth/sign_up/all_pop_up/pop_up.dart';
import 'package:matrimony/view/widget/all_multiple_used_repos/report_profile_repo/report_profile_repo.dart';

import 'package:matrimony/view/widget/button/button.dart';
import 'package:matrimony/view/widget/customText/custom_text.dart';
import 'package:matrimony/view/widget/custom_img/custom_img.dart';
import 'package:matrimony/view/widget/text_editingField/textediting_field.dart';

class AllPopUp {
  //Diolog With a title and 2 Button
  static void showDialogWith2Button({
    required BuildContext context,
    required String title,
    required String button1Title,
    required String button2Title,
    VoidCallback? button1ontap,
    VoidCallback? button2ontap,
  }) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
            side: const BorderSide(
              color: AppColors.pink100,
              width: 2.0,
            ),
          ),
          child: SizedBox(
            height: 130,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                    fontWeight: FontWeight.w500,
                    text: title,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: CustomButton(
                          height: 36,
                          textColor: AppColors.pink100,
                          isfillColor: false,
                          text: button1Title,
                          ontap: () {
                            navigator!.pop();
                            button1ontap!();
                          },
                        ),
                      ),
                      const SizedBox(
                        width: 24,
                      ),
                      Expanded(
                        child: CustomButton(
                          height: 36,
                          text: button2Title,
                          ontap: () {
                            navigator!.pop();
                            button2ontap!();
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  static final scrollController = ScrollController();

//Report Pop Up
  static void showReportDiolog(
      {required BuildContext context,
      required int selectedReport,
      required String id}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String reportType = PopUpValueLists.reportList[0];
        TextEditingController descroptionController =
            TextEditingController(text: PopUpValueLists.reportList[0]);

        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
            side: const BorderSide(
              color: AppColors.pink100,
              width: 2.0,
            ),
          ),
          child: SizedBox(
            height: MediaQuery.of(context).size.height / 1.6,
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  // Top Section
                  Expanded(
                    child: SingleChildScrollView(
                      controller: scrollController,
                      child: StatefulBuilder(
                        builder: (BuildContext context, StateSetter setState) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                children: PopUpValueLists.reportList
                                    .asMap()
                                    .entries
                                    .map((entry) {
                                  int index = entry.key;
                                  String status = entry.value;

                                  return Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      CustomText(
                                        fontWeight: FontWeight.w500,
                                        text: status,
                                      ),
                                      Radio(
                                        activeColor: AppColors.pink100,
                                        value: index,
                                        groupValue: selectedReport,
                                        onChanged: (value) {
                                          setState(() {
                                            selectedReport = value!;
                                            reportType = status;
                                          });
                                        },
                                      ),
                                    ],
                                  );
                                }).toList(),
                              ),
                              const CustomText(
                                top: 16,
                                bottom: 12,
                                text: AppStaticStrings.describe,
                              ),
                              CustomTextField(
                                textEditingController: descroptionController,
                                onTapClick: () {},
                                readOnly: false,
                                maxLines: 4,
                                hintText: AppStaticStrings.describeReason,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ),

                  //Action Button
                  Row(
                    children: [
                      Expanded(
                        child: CustomButton(
                          height: 36,
                          text: AppStaticStrings.report,
                          ontap: () {
                            ReportUser.reportUser(
                                id: id,
                                reportType: reportType,
                                reportDescription: descroptionController.text);
                          },
                        ),
                      ),
                      const SizedBox(
                        width: 24,
                      ),
                      Expanded(
                        child: CustomButton(
                          height: 36,
                          textColor: AppColors.pink100,
                          isfillColor: false,
                          text: AppStaticStrings.cancel,
                          ontap: () {
                            navigator!.pop();
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  static void scrollToBottom(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.ease,
      );
    });
  }

//Reached Limit to Match Request

  static reachedLimitDiolog({required BuildContext context}) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
            // side: const BorderSide(
            //   color: AppColors.pink100,
            //   width: 2.0,
            // ),
          ),
          child: SizedBox(
            height: 210,
            //  width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  // Top Section
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(children: [
                        CustomText(
                          text: AppStaticStrings.sorryYouHaveReachedYour,
                          maxLines: 2,
                          fontWeight: FontWeight.w500,
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        CustomText(
                          maxLines: 3,
                          text: AppStaticStrings.forSendingMoreMatch,
                          fontSize: 12,
                        )
                      ]),
                    ],
                  ),
                  const Expanded(child: SizedBox()),

                  //Action Button
                  CustomButton(
                    height: 44,
                    textColor: AppColors.pink100,
                    isfillColor: false,
                    text: AppStaticStrings.purchase,
                    ontap: () {
                      navigator!.pop();
                      Get.toNamed(AppRoute.purchesMoreMatch);
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

//Payment SuccessFull PopUp Message

  static paymentSuccessfull(
      {required BuildContext context, required String packageName}) {
    double height = MediaQuery.of(context).size.height;
    return showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: SizedBox(
            height: height < 800 ? (height / 2) : (height / 2.5),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //Premium Image
                  const CustomImage(
                    imageSrc: AppIcons.premium,
                    size: 80,
                  ),

                  //Text Payment Successful

                  const CustomText(
                    top: 12,
                    text: AppStaticStrings.paymentSuccessful,
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),

                  //Text your account has been upgraded

                  CustomText(
                    left: 40,
                    right: 40,
                    top: 8,
                    bottom: 60,
                    maxLines: 3,
                    text:
                        "${AppStaticStrings.youraccounthasbeenupgraded}$packageName",
                    fontSize: 16,
                    color: AppColors.black60,
                  ),

                  //Button
                  CustomButton(
                    text: AppStaticStrings.backtohome,
                    ontap: () {
                      Get.offAllNamed(AppRoute.home);
                    },
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class ExitConfirmationDialog extends StatelessWidget {
  const ExitConfirmationDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
        side: const BorderSide(
          color: AppColors.pink100,
          width: 2.0,
        ),
      ),
      child: SizedBox(
        height: 130,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const CustomText(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                text: AppStaticStrings.areYouSureWantToLeave,
              ),
              Row(
                children: [
                  Expanded(
                    child: CustomButton(
                      height: 36,
                      textColor: AppColors.pink100,
                      isfillColor: false,
                      text: AppStaticStrings.yes,
                      ontap: () {
                        Navigator.of(context).pop(true);
                      },
                    ),
                  ),
                  const SizedBox(
                    width: 24,
                  ),
                  Expanded(
                    child: CustomButton(
                      height: 36,
                      text: AppStaticStrings.no,
                      ontap: () {
                        Navigator.of(context).pop(false);
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
