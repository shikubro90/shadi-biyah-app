import 'package:csc_picker/csc_picker.dart';
import 'package:currency_picker/currency_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matrimony/core/global/height_calculator/height_calculator.dart';
import 'package:matrimony/core/global/religion_caste_sect.dart';

import 'package:matrimony/utils/app_colors.dart';
import 'package:matrimony/utils/app_static_strings.dart';
import 'package:matrimony/utils/app_utils.dart';
import 'package:matrimony/view/screens/auth/sign_up/all_pop_up/pop_up.dart';
import 'package:matrimony/view/screens/user_profile_details/partner%E2%80%99s_preferences/partner_pre_controller/partner_pre_controller.dart';
import 'package:matrimony/view/widget/button/button.dart';
import 'package:matrimony/view/widget/button/loading_button.dart';
import 'package:matrimony/view/widget/customText/custom_text.dart';
import 'package:matrimony/view/widget/custom_appbar_pink/custom_appbar_pink.dart';
import 'package:matrimony/view/widget/religion_model/religion_model.dart';
import 'package:matrimony/view/widget/text_editingField/textediting_field.dart';

class PartnerPreferences extends StatefulWidget {
  const PartnerPreferences({super.key});

  @override
  State<PartnerPreferences> createState() => _PartnerPreferencesState();
}

class _PartnerPreferencesState extends State<PartnerPreferences> {
  PartnerPreController partnerPreController = Get.find<PartnerPreController>();

  //
  String title = "";
  bool isUpdate = false;

  @override
  void initState() {
    ReligionSectCaste.getReligions();
    title = Get.arguments[0];
    //
    partnerPreController.ageMinController.text = Get.arguments[1];
    partnerPreController.ageMaxController.text = Get.arguments[2];
    partnerPreController.heightMinController.text = Get.arguments[3];
    partnerPreController.heightMaxController.text = Get.arguments[4];
    //
    partnerPreController.countryValue = Get.arguments[5];
    partnerPreController.stateValue = Get.arguments[6];
    partnerPreController.cityValue = Get.arguments[7];

    //
    partnerPreController.maritalStatusController.text = Get.arguments[8];
    //
    partnerPreController.religionController.text = Get.arguments[9];
    partnerPreController.castController.text = Get.arguments[10];
    partnerPreController.sectController.text = Get.arguments[11];

    //
    partnerPreController.motherTongueController.text = Get.arguments[12];

    partnerPreController.higherEducationController.text = Get.arguments[13];
    partnerPreController.occupationController.text = Get.arguments[14];
    partnerPreController.minIncomeController.text = Get.arguments[15];
    partnerPreController.maxIncomeController.text = Get.arguments[16];
    partnerPreController.residenceController.text = Get.arguments[17];

    isUpdate = Get.arguments[18];

    super.initState();
  }

  final formKey = GlobalKey<FormState>();

  String countryCurrency = "USD";

  String heightValidator = "";
  String ageValidator = AppStaticStrings.maximunAgeMustBeGreter;
  showMsg() {
    TostMessage.toastMessage(message: AppStaticStrings.countryCantBeEmpty);
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PartnerPreController>(builder: (controller) {
      return CustomAppBarPink(
          bottomNavBar: controller.isLoading
              ? const CustomLoadingButton(
                  bottom: 24,
                  left: 20,
                  right: 20,
                )
              : CustomButton(
                  text: isUpdate
                      ? AppStaticStrings.save
                      : AppStaticStrings.savePreferences,
                  bottom: 24,
                  left: 20,
                  right: 20,
                  ontap: () {
                    if (controller.countryValue.isEmpty ||
                        controller.stateValue == "null") {
                      showMsg();
                    } else if (controller.stateValue == "null" ||
                        controller.stateValue == "State") {
                      showMsg();
                    } else if (controller.cityValue == "null" ||
                        controller.cityValue == "City") {
                      showMsg();
                    } else if (formKey.currentState!.validate()) {
                      controller.updatePartnerPre(isUpdate: isUpdate);
                    }
                  }),
          title: isUpdate
              ? AppStaticStrings.editPartnerPreferences
              : AppStaticStrings.partnerPreferences,
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
                    //Select Age

                    const CustomText(
                      top: 20,
                      bottom: 8,
                      text: AppStaticStrings.age,
                    ),

                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //Min Age

                        Expanded(
                            child: CustomTextField(
                          validator: (value) {
                            if (value == null || value.toString().isEmpty) {
                              return AppStaticStrings.fieldCantBeEmpty;
                            } else {
                              int ageMin = int.tryParse(
                                      controller.ageMinController.text) ??
                                  0;
                              int ageMax = int.tryParse(
                                      controller.ageMaxController.text) ??
                                  0;

                              if (ageMax <= ageMin) {
                                return AppStaticStrings.maximunAgeMustBeGreter;
                              }
                            }
                            return null;
                          },
                          onTapClick: () {
                            PersonalDetailsPopUps.generateIndex(
                                startingValue: 18,
                                context: context,
                                indexNumber: 53,
                                onSelected: (date) {
                                  controller.ageMinController.text =
                                      date.toString();
                                });
                          },
                          hintText: AppStaticStrings.min,
                          textEditingController: controller.ageMinController,
                        )),
                        const SizedBox(
                          width: 10,
                        ),

                        //Max Age
                        Expanded(
                          child: CustomTextField(
                            validator: (value) {
                              if (value == null || value.toString().isEmpty) {
                                return AppStaticStrings.fieldCantBeEmpty;
                              }
                              return null;
                            },
                            onTapClick: () {
                              PersonalDetailsPopUps.generateIndex(
                                  startingValue: 18,
                                  context: context,
                                  indexNumber: 53,
                                  onSelected: (date) {
                                    controller.ageMaxController.text =
                                        date.toString();
                                  });
                            },
                            hintText: AppStaticStrings.max,
                            textEditingController: controller.ageMaxController,
                          ),
                        ),
                      ],
                    ),
                    //Select Height

                    const CustomText(
                      top: 20,
                      bottom: 8,
                      text: AppStaticStrings.height,
                    ),

                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //Min height

                        Expanded(
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
                                list: PopUpValueLists.heightList,
                                onCountrySelected: (value) {
                                  controller.heightMinController.text = value;
                                },
                              );
                            },
                            hintText: AppStaticStrings.min,
                            textEditingController:
                                controller.heightMinController,
                          ),
                        ),

                        const SizedBox(
                          width: 10,
                        ),

                        //Max height
                        Expanded(
                          child: CustomTextField(
                            validator: (value) {
                              if (value == null || value.toString().isEmpty) {
                                return AppStaticStrings.fieldCantBeEmpty;
                              } else if (controller
                                  .heightMinController.text.isNotEmpty) {
                                double minHeight = double.parse(
                                    HeightConverter.feetAndInchesToCentimeters(
                                        controller.heightMinController.text));

                                double maxHeight = double.parse(
                                    HeightConverter.feetAndInchesToCentimeters(
                                        controller.heightMaxController.text));

                                if (maxHeight < minHeight ||
                                    (maxHeight == minHeight)) {
                                  return AppStaticStrings
                                      .maximunHeightMustBeGreter;
                                }
                              }
                              return null;
                            },
                            onTapClick: () {
                              PersonalDetailsPopUps.generateListOfText(
                                context: context,
                                list: PopUpValueLists.heightList,
                                onCountrySelected: (value) {
                                  controller.heightMaxController.text = value;
                                },
                              );
                            },
                            hintText: AppStaticStrings.max,
                            textEditingController:
                                controller.heightMaxController,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(
                      height: 20,
                    ),

                    CSCPicker(
                      currentCountry: controller.countryValue,
                      currentState: controller.stateValue,
                      currentCity: controller.cityValue,

                      ///Enable disable state dropdown [OPTIONAL PARAMETER]
                      showStates: true,

                      /// Enable disable city drop down [OPTIONAL PARAMETER]
                      showCities: true,

                      ///Enable (get flag with country name) / Disable (Disable flag) / ShowInDropdownOnly (display flag in dropdown only) [OPTIONAL PARAMETER]
                      flagState: CountryFlag.ENABLE,

                      ///Dropdown box decoration to style your dropdown selector [OPTIONAL PARAMETER] (USE with disabledDropdownDecoration)
                      dropdownDecoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                          color: Colors.white,
                          border: Border.all(
                              color: Colors.grey.shade300, width: 1)),

                      ///Disabled Dropdown box decoration to style your dropdown selector [OPTIONAL PARAMETER]  (USE with disabled dropdownDecoration)
                      disabledDropdownDecoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                          color: Colors.grey.shade300,
                          border: Border.all(
                              color: Colors.grey.shade300, width: 1)),

                      ///placeholders for dropdown search field
                      countrySearchPlaceholder: "Country",
                      stateSearchPlaceholder: "State",
                      citySearchPlaceholder: "City",

                      ///labels for dropdown
                      countryDropdownLabel: "Country",
                      stateDropdownLabel: "State",
                      cityDropdownLabel: "City",

                      selectedItemStyle: const TextStyle(
                        color: AppColors.black100,
                        fontSize: 14,
                      ),

                      ///DropdownDialog Heading style [OPTIONAL PARAMETER]
                      dropdownHeadingStyle: const TextStyle(
                          color: AppColors.black100,
                          fontSize: 17,
                          fontWeight: FontWeight.bold),

                      ///DropdownDialog Item style [OPTIONAL PARAMETER]
                      dropdownItemStyle: const TextStyle(
                        color: AppColors.black100,
                        fontSize: 14,
                      ),

                      ///Dialog box radius [OPTIONAL PARAMETER]
                      dropdownDialogRadius: 10.0,

                      ///Search bar radius [OPTIONAL PARAMETER]
                      searchBarRadius: 10.0,

                      ///triggers once country selected in dropdown
                      onCountryChanged: (value) {
                        setState(() {
                          ///store value in country variable
                          String data = value.substring(2);

                          controller.countryValue =
                              data.substring(2).removeAllWhitespace;
                        });
                      },

                      ///triggers once state selected in dropdown
                      onStateChanged: (value) {
                        setState(() {
                          ///store value in state variable
                          controller.stateValue = value.toString();
                        });
                      },

                      ///triggers once city selected in dropdown
                      onCityChanged: (value) {
                        setState(() {
                          ///store value in city variable
                          controller.cityValue = value.toString();
                        });
                      },
                    ),

                    //Select Residence

                    const CustomText(
                      top: 20,
                      bottom: 8,
                      text: AppStaticStrings.residentialStatus,
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
                          list: PopUpValueLists.residentialStatusList,
                          onCountrySelected: (value) {
                            controller.residenceController.text = value;
                          },
                        );
                      },
                      hintText: AppStaticStrings.residentialStatus,
                      textEditingController: controller.residenceController,
                    ),

                    //Marital Status

                    const CustomText(
                      top: 20,
                      bottom: 8,
                      text: AppStaticStrings.maritalStatus,
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
                          list: PopUpValueLists.maritalList,
                          onCountrySelected: (value) {
                            controller.maritalStatusController.text = value;
                          },
                        );
                      },
                      hintText: AppStaticStrings.motherTongue,
                      textEditingController: controller.maritalStatusController,
                    ),
                    //Mother Tongue

                    const CustomText(
                      top: 20,
                      bottom: 8,
                      text: AppStaticStrings.motherTongue,
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
                          list: PopUpValueLists.motherTongueList,
                          onCountrySelected: (value) {
                            controller.motherTongueController.text = value;
                          },
                        );
                      },
                      hintText: AppStaticStrings.motherTongue,
                      textEditingController: controller.motherTongueController,
                    ),

                    //Religion

                    const CustomText(
                      top: 20,
                      bottom: 8,
                      text: AppStaticStrings.religion,
                    ),

                    CustomTextField(
                      validator: (value) {
                        if (value == null || value.toString().isEmpty) {
                          return AppStaticStrings.fieldCantBeEmpty;
                        }
                        return null;
                      },
                      onTapClick: () {
                        List<Religion>? religionList = ReligionSectCaste
                            .religions.data!.attributes!.religion!;

                        // Sort the list based on the 'name' property
                        religionList.sort(
                            (a, b) => a.name!.compareTo(b.name.toString()));

                        PersonalDetailsPopUps.generateReligionList(
                          onCasteSectSelected: (value) {
                            setState(() {
                              controller.castController.clear();
                              ReligionSectCaste.casteSect = value;
                            });
                          },
                          castes: ReligionSectCaste.castes,
                          context: context,
                          list: religionList,
                          onItemSelected: (value) {
                            controller.religionController.text = value;
                          },
                        );
                      },
                      hintText: AppStaticStrings.religion,
                      textEditingController: controller.religionController,
                    ),

                    //Cast/Sect

                    if (ReligionSectCaste.casteSect.isNotEmpty)
                      CustomText(
                        top: 20,
                        bottom: 8,
                        text: ReligionSectCaste.casteSect,
                      ),

                    if (ReligionSectCaste.casteSect.isNotEmpty)
                      CustomTextField(
                        validator: (value) {
                          if (value == null || value.toString().isEmpty) {
                            return AppStaticStrings.fieldCantBeEmpty;
                          }
                          return null;
                        },
                        onTapClick: () {
                          PersonalDetailsPopUps.generateCasteSectList(
                            castes: ReligionSectCaste.castes,
                            context: context,
                            onItemSelected: (value) {
                              controller.castController.text = value;
                            },
                          );
                        },
                        hintText: ReligionSectCaste.casteSect,
                        textEditingController: controller.castController,
                      ),
                    // Education

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

                    //Income Range

                    const CustomText(
                      top: 20,
                      bottom: 8,
                      text: AppStaticStrings.incomeRange,
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
                                    countryCurrency = currency.code;
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
                                  text: countryCurrency,
                                )),
                          ),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Expanded(
                          flex: 4,
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
                                  controller.maxIncomeController.text = value;
                                },
                              );
                            },
                            hintText: AppStaticStrings.maxIncome,
                            textEditingController:
                                controller.maxIncomeController,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(
                      height: 24,
                    ),
                  ],
                ),
              ),
            ),
          ));
    });
  }
}
