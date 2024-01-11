import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matrimony/utils/app_static_strings.dart';
import 'package:matrimony/view/screens/auth/sign_up/all_pop_up/pop_up.dart';
import 'package:matrimony/view/screens/user_profile_details/family_details/family_details_controller/family_details_controller.dart';
import 'package:matrimony/view/widget/button/button.dart';
import 'package:matrimony/view/widget/customText/custom_text.dart';
import 'package:matrimony/view/widget/custom_appbar_pink/custom_appbar_pink.dart';
import 'package:matrimony/view/widget/text_editingField/textediting_field.dart';

class FamilyDetails extends StatefulWidget {
  const FamilyDetails({super.key});

  @override
  State<FamilyDetails> createState() => _FamilyDetailsState();
}

class _FamilyDetailsState extends State<FamilyDetails> {
  String title = "";
  bool isUpdate = false;

  FamilyDetailsController familyDetailsController =
      Get.find<FamilyDetailsController>();

  @override
  void initState() {
    title = Get.arguments[0];
    familyDetailsController.familyStatusController.text = Get.arguments[1];
    familyDetailsController.familyValueController.text = Get.arguments[2];
    familyDetailsController.familyTypeController.text = Get.arguments[3];
    familyDetailsController.familyIncomeController.text = Get.arguments[4];
    familyDetailsController.fatherOccupationController.text = Get.arguments[5];
    familyDetailsController.motherOccupationController.text = Get.arguments[6];
    familyDetailsController.brothersController.text = Get.arguments[7];
    familyDetailsController.sisterController.text = Get.arguments[8];
    isUpdate = Get.arguments[9];
    super.initState();
  }

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FamilyDetailsController>(builder: (controller) {
      return CustomAppBarPink(
          bottomNavBar: CustomButton(
              text:
                  isUpdate ? AppStaticStrings.save : AppStaticStrings.continuee,
              bottom: 24,
              left: 20,
              right: 20,
              ontap: () {
                if (formKey.currentState!.validate()) {
                  controller.updateFamilyDetails(isUpdate: isUpdate);
                }
              }),
          title: title,
          onBack: () {
            Get.back();
          },
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.only(top: 24, left: 20, right: 20),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // if (!isUpdate)
                    //   Container(
                    //     padding: const EdgeInsets.all(16),
                    //     decoration: ShapeDecoration(
                    //       color: AppColors.pink5,
                    //       shape: RoundedRectangleBorder(
                    //           borderRadius: BorderRadius.circular(8)),
                    //       shadows: const [
                    //         BoxShadow(
                    //           color: AppColors.black10,
                    //           blurRadius: 10,
                    //         )
                    //       ],
                    //     ),
                    //     child: const Column(
                    //       crossAxisAlignment: CrossAxisAlignment.start,
                    //       children: [
                    //         CustomText(
                    //           maxLines: 2,
                    //           textAlign: TextAlign.left,
                    //           fontSize: 16,
                    //           text: AppStaticStrings
                    //               .youHaveCreatedYourAccountSuccessfully,
                    //         ),
                    //         CustomText(
                    //           maxLines: 2,
                    //           textAlign: TextAlign.left,
                    //           text: AppStaticStrings.nowyoucanfill,
                    //           color: AppColors.black40,
                    //         ),
                    //       ],
                    //     ),
                    //   ),
                    //Family Status

                    const CustomText(
                      top: 16,
                      bottom: 8,
                      text: AppStaticStrings.familyStatus,
                    ),
                    CustomTextField(
                      validator: (value) {
                        if (value == null || value.toString().isEmpty) {
                          return AppStaticStrings.fieldCantBeEmpty;
                        }
                        return null;
                      },
                      textEditingController: controller.familyStatusController,
                      hintText: AppStaticStrings.familyStatus,
                      onTapClick: () {
                        PersonalDetailsPopUps.generateListOfText(
                          context: context,
                          list: PopUpValueLists.familyStatusList,
                          onCountrySelected: (value) {
                            controller.familyStatusController.text = value;
                          },
                        );
                      },
                    ),

                    //Family Value

                    const CustomText(
                      top: 16,
                      bottom: 8,
                      text: AppStaticStrings.familyValues,
                    ),
                    CustomTextField(
                      onTapClick: () {
                        PersonalDetailsPopUps.generateListOfText(
                          context: context,
                          list: PopUpValueLists.familyValuesList,
                          onCountrySelected: (value) {
                            controller.familyValueController.text = value;
                          },
                        );
                      },
                      validator: (value) {
                        if (value == null || value.toString().isEmpty) {
                          return AppStaticStrings.fieldCantBeEmpty;
                        }
                        return null;
                      },
                      textEditingController: controller.familyValueController,
                      hintText: AppStaticStrings.liberal,
                    ),
                    //Family Type

                    const CustomText(
                      top: 16,
                      bottom: 8,
                      text: AppStaticStrings.familyType,
                    ),
                    CustomTextField(
                      onTapClick: () {
                        PersonalDetailsPopUps.generateListOfText(
                          context: context,
                          list: PopUpValueLists.familyTypeList,
                          onCountrySelected: (value) {
                            controller.familyTypeController.text = value;
                          },
                        );
                      },
                      validator: (value) {
                        if (value == null || value.toString().isEmpty) {
                          return AppStaticStrings.fieldCantBeEmpty;
                        }
                        return null;
                      },
                      textEditingController: controller.familyTypeController,
                      hintText: AppStaticStrings.jointFamily,
                    ),

                    //Family Income

                    const CustomText(
                      top: 16,
                      bottom: 8,
                      text: AppStaticStrings.familyIncome,
                    ),
                    CustomTextField(
                      onTapClick: () {
                        PersonalDetailsPopUps.generateListOfText(
                          context: context,
                          list: PopUpValueLists.familyIncome,
                          onCountrySelected: (value) {
                            controller.familyIncomeController.text = value;
                          },
                        );
                      },
                      validator: (value) {
                        if (value == null || value.toString().isEmpty) {
                          return AppStaticStrings.fieldCantBeEmpty;
                        }
                        return null;
                      },
                      textEditingController: controller.familyIncomeController,
                      hintText: AppStaticStrings.enterfamilyincome,
                    ),

                    //Father Occupation

                    const CustomText(
                      top: 16,
                      bottom: 8,
                      text: AppStaticStrings.fatherOccupation,
                    ),
                    CustomTextField(
                      onTapClick: () {
                        PersonalDetailsPopUps.generateListOfText(
                          context: context,
                          list: PopUpValueLists.occupationList,
                          onCountrySelected: (value) {
                            controller.fatherOccupationController.text = value;
                          },
                        );
                      },
                      validator: (value) {
                        if (value == null || value.toString().isEmpty) {
                          return AppStaticStrings.fieldCantBeEmpty;
                        }
                        return null;
                      },
                      textEditingController:
                          controller.fatherOccupationController,
                      hintText: AppStaticStrings.fatherOccupation,
                    ),

                    //Mother Occupation

                    const CustomText(
                      top: 16,
                      bottom: 8,
                      text: AppStaticStrings.motherOccupation,
                    ),
                    CustomTextField(
                      onTapClick: () {
                        PersonalDetailsPopUps.generateListOfText(
                          context: context,
                          list: PopUpValueLists.motherOccupationList,
                          onCountrySelected: (value) {
                            controller.motherOccupationController.text = value;
                          },
                        );
                      },
                      validator: (value) {
                        if (value == null || value.toString().isEmpty) {
                          return AppStaticStrings.fieldCantBeEmpty;
                        }
                        return null;
                      },
                      textEditingController:
                          controller.motherOccupationController,
                      hintText: AppStaticStrings.motherOccupation,
                    ),

                    //Brothers

                    const CustomText(
                      top: 16,
                      bottom: 8,
                      text: AppStaticStrings.brothers,
                    ),
                    CustomTextField(
                      onTapClick: () {
                        PersonalDetailsPopUps.generateListOfText(
                          context: context,
                          list: PopUpValueLists.numOfSiblings,
                          onCountrySelected: (value) {
                            controller.brothersController.text = value;
                          },
                        );
                      },
                      validator: (value) {
                        if (value == null || value.toString().isEmpty) {
                          return AppStaticStrings.fieldCantBeEmpty;
                        }
                        return null;
                      },
                      textEditingController: controller.brothersController,
                      hintText: AppStaticStrings.noofBrothers,
                    ),

                    //Sister

                    const CustomText(
                      top: 16,
                      bottom: 8,
                      text: AppStaticStrings.sisters,
                    ),
                    CustomTextField(
                      onTapClick: () {
                        PersonalDetailsPopUps.generateListOfText(
                          context: context,
                          list: PopUpValueLists.numOfSiblings,
                          onCountrySelected: (value) {
                            controller.sisterController.text = value;
                          },
                        );
                      },
                      validator: (value) {
                        if (value == null || value.toString().isEmpty) {
                          return AppStaticStrings.fieldCantBeEmpty;
                        }
                        return null;
                      },
                      textEditingController: controller.sisterController,
                      hintText: AppStaticStrings.noofSisters,
                    ),

                    const SizedBox(
                      height: 30,
                    )
                  ],
                ),
              ),
            ),
          ));
    });
  }
}
