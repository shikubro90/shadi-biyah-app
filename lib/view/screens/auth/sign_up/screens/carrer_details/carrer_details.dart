import 'package:currency_picker/currency_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matrimony/core/route/app_route.dart';
import 'package:matrimony/utils/app_colors.dart';
import 'package:matrimony/utils/app_static_strings.dart';
import 'package:matrimony/view/screens/auth/sign_up/all_pop_up/pop_up.dart';
import 'package:matrimony/view/screens/auth/sign_up/screens/carrer_details/carrer_details_controller/carrier_details_controller.dart';
import 'package:matrimony/view/screens/auth/sign_up/sign_up_controller/sign_up_controller.dart';
import 'package:matrimony/view/widget/button/button.dart';
import 'package:matrimony/view/widget/button/loading_button.dart';
import 'package:matrimony/view/widget/customText/custom_text.dart';
import 'package:matrimony/view/widget/custom_appbar_pink/custom_appbar_pink.dart';
import 'package:matrimony/view/widget/text_editingField/textediting_field.dart';

class CarrerDetails extends StatefulWidget {
  const CarrerDetails({super.key});

  @override
  State<CarrerDetails> createState() => _CarrerDetailsState();
}

class _CarrerDetailsState extends State<CarrerDetails> {
  String title = "";
  bool isUpdate = false;
  bool isCarrierLoading = false;

  final formKey = GlobalKey<FormState>();
  late CarrierDetailsController carrierDetails;
  getTextFieldData() {
    SignUpController signUpController = Get.find<SignUpController>();
    carrierDetails = Get.find<CarrierDetailsController>();
    isCarrierLoading = signUpController.isCarrierLoading;

    signUpController.higherEducationController.text = Get.arguments[1];
    signUpController.workExperienceController.text = Get.arguments[2];
    signUpController.occupationController.text = Get.arguments[3];
    signUpController.incomeController.text = Get.arguments[4];
  }

  @override
  void initState() {
    title = Get.arguments[0];
    isUpdate = Get.arguments[5];

    if (isUpdate) {
      getTextFieldData();
    }
    //

    super.initState();
  }

  String countryName = "USD";

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SignUpController>(builder: (controller) {
      return CustomAppBarPink(
          bottomNavBar: controller.isCarrierLoading
              ? const CustomLoadingButton(
                  bottom: 24,
                  left: 20,
                  right: 20,
                )
              : CustomButton(
                  text: isUpdate
                      ? AppStaticStrings.save
                      : AppStaticStrings.continuee,
                  bottom: 24,
                  left: 20,
                  right: 20,
                  ontap: () {
                    if (formKey.currentState!.validate()) {
                      isUpdate
                          ? carrierDetails.updateCarrierDetails()
                          : Get.toNamed(AppRoute.socailaDetails);
                    }
                  }),
          title: title,
          onBack: () {
            Get.back();
          },
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //Education

                    const CustomText(
                      top: 20,
                      bottom: 8,
                      text: AppStaticStrings.education,
                    ),

                    CustomTextField(
                      validator: (value) {
                        if (value == null || value.toString().isEmpty) {
                          return AppStaticStrings.fieldCantBeEmpty;
                        }
                        return null;
                      },
                      onTapClick: () {
                        PersonalDetailsPopUps.generateListOfText(
                          context: context,
                          list: PopUpValueLists.educationList,
                          onCountrySelected: (value) {
                            controller.higherEducationController.text = value;
                          },
                        );
                      },
                      hintText: AppStaticStrings.education,
                      textEditingController:
                          controller.higherEducationController,
                    ),

                    //Occupation

                    const CustomText(
                      top: 20,
                      bottom: 8,
                      text: AppStaticStrings.occupation,
                    ),

                    CustomTextField(
                      validator: (value) {
                        if (value == null || value.toString().isEmpty) {
                          return AppStaticStrings.fieldCantBeEmpty;
                        }
                        return null;
                      },
                      onTapClick: () {
                        PersonalDetailsPopUps.generateListOfText(
                          context: context,
                          list: PopUpValueLists.occupationList,
                          onCountrySelected: (value) {
                            controller.occupationController.text = value;
                          },
                        );
                      },
                      hintText: AppStaticStrings.occupation,
                      textEditingController: controller.occupationController,
                    ),
                    //Work Experience

                    const CustomText(
                      top: 20,
                      bottom: 8,
                      text: AppStaticStrings.workExperience,
                    ),

                    CustomTextField(
                      validator: (value) {
                        if (value == null || value.toString().isEmpty) {
                          return AppStaticStrings.fieldCantBeEmpty;
                        }
                        return null;
                      },
                      onTapClick: () {
                        PersonalDetailsPopUps.generateListOfText(
                          context: context,
                          list: PopUpValueLists.workExperienceList,
                          onCountrySelected: (value) {
                            controller.workExperienceController.text = value;
                          },
                        );
                      },
                      hintText: AppStaticStrings.workExperience,
                      textEditingController:
                          controller.workExperienceController,
                    ),
                    //Income

                    const CustomText(
                      top: 20,
                      bottom: 8,
                      text: AppStaticStrings.monthlyincome,
                    ),

                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //Show Currency

                        Expanded(
                          flex: 2,
                          child: GestureDetector(
                            onTap: () {
                              showCurrencyPicker(
                                context: context,
                                showFlag: true,
                                showCurrencyName: true,
                                showCurrencyCode: true,
                                onSelect: (Currency currency) {
                                  setState(() {
                                    countryName = currency.code;
                                  });
                                },
                              );
                            },
                            child: Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 22, horizontal: 10),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    border:
                                        Border.all(color: AppColors.black10)),
                                child: CustomText(
                                  left: 8,
                                  text: countryName,
                                )),
                          ),
                        ),
                        const SizedBox(
                          width: 8,
                        ),

                        //Show Income
                        Expanded(
                          flex: 3,
                          child: CustomTextField(
                            validator: (value) {
                              if (value == null || value.toString().isEmpty) {
                                return AppStaticStrings.fieldCantBeEmpty;
                              }
                              return null;
                            },
                            onTapClick: () {
                              PersonalDetailsPopUps.generateListOfText(
                                context: context,
                                list: PopUpValueLists.incomeList,
                                onCountrySelected: (value) {
                                  controller.incomeController.text = value;
                                },
                              );
                            },
                            hintText: AppStaticStrings.income,
                            textEditingController: controller.incomeController,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ));
    });
  }
}
