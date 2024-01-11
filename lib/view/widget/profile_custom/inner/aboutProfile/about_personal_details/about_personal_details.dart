import 'package:csc_picker/csc_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matrimony/utils/app_colors.dart';
import 'package:matrimony/utils/app_static_strings.dart';
import 'package:matrimony/view/screens/auth/sign_up/all_pop_up/pop_up.dart';
import 'package:matrimony/view/widget/button/button.dart';
import 'package:matrimony/view/widget/button/loading_button.dart';
import 'package:matrimony/view/widget/customText/custom_text.dart';
import 'package:matrimony/view/widget/custom_appbar_pink/custom_appbar_pink.dart';
import 'package:matrimony/view/widget/profile_custom/inner/aboutProfile/personal_details_controller/personal_details_controller.dart';
import 'package:matrimony/view/widget/text_editingField/textediting_field.dart';

class AboutEditPersonalDetails extends StatefulWidget {
  const AboutEditPersonalDetails({super.key});

  @override
  State<AboutEditPersonalDetails> createState() =>
      _AboutEditPersonalDetailsState();
}

class _AboutEditPersonalDetailsState extends State<AboutEditPersonalDetails> {
  PersonalDetailsController personalDetailsController =
      Get.find<PersonalDetailsController>();

  @override
  void initState() {
    personalDetailsController.nameController.text = Get.arguments[0];
    personalDetailsController.genderController.text = Get.arguments[1];
    personalDetailsController.maritalStatusController.text = Get.arguments[2];
    //DOB
    personalDetailsController.datesController.text = Get.arguments[3];
    personalDetailsController.monthController.text = Get.arguments[4];
    personalDetailsController.yearController.text = Get.arguments[5];
    //Height
    personalDetailsController.fitController.text = Get.arguments[6];
    personalDetailsController.incController.text = Get.arguments[7];
    //Religion
    personalDetailsController.religionController.text = Get.arguments[8];
    personalDetailsController.casteController.text = Get.arguments[9];
    personalDetailsController.sectController.text = Get.arguments[10];
    //
    personalDetailsController.motherTounghController.text = Get.arguments[11];
    personalDetailsController.countryValue = Get.arguments[12];
    personalDetailsController.stateValue = Get.arguments[13];
    personalDetailsController.cityValue = Get.arguments[14];
    personalDetailsController.residentialStatusController.text =
        Get.arguments[15];

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PersonalDetailsController>(builder: (controller) {
      return CustomAppBarPink(
          bottomNavBar: controller.isLoading
              ? const CustomLoadingButton(
                  bottom: 24,
                  left: 20,
                  right: 20,
                )
              : CustomButton(
                  text: AppStaticStrings.save,
                  bottom: 24,
                  left: 20,
                  right: 20,
                  ontap: () {
                    controller.updatePersonalDetails();
                  }),
          title: AppStaticStrings.editPersonalDetails,
          onBack: () {
            Get.back();
          },
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //Name

                  const CustomText(
                    top: 16,
                    bottom: 8,
                    text: AppStaticStrings.name,
                  ),
                  CustomTextField(
                    textEditingController: controller.nameController,
                    hintText: AppStaticStrings.name,
                    readOnly: false,
                  ),
                  //Gender

                  const CustomText(
                    top: 16,
                    bottom: 8,
                    text: AppStaticStrings.gender,
                  ),
                  CustomTextField(
                    onTapClick: () {
                      PersonalDetailsPopUps.generateListOfText(
                        context: context,
                        list: PopUpValueLists.gender,
                        onCountrySelected: (value) {
                          controller.genderController.text = value;
                        },
                      );
                    },
                    textEditingController: controller.genderController,
                    hintText: AppStaticStrings.name,
                  ),
                  //Marital Status

                  const CustomText(
                    top: 16,
                    bottom: 8,
                    text: AppStaticStrings.maritalStatus,
                  ),
                  CustomTextField(
                    onTapClick: () {
                      PersonalDetailsPopUps.generateListOfText(
                        context: context,
                        list: PopUpValueLists.maritalList,
                        onCountrySelected: (value) {
                          controller.maritalStatusController.text = value;
                        },
                      );
                    },
                    textEditingController: controller.maritalStatusController,
                    hintText: AppStaticStrings.maritalStatus,
                  ),

                  //Select Date Of Birth

                  const CustomText(
                    top: 20,
                    bottom: 8,
                    text: AppStaticStrings.dateofBirth,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //Date
                      Expanded(
                          child: CustomTextField(
                        validator: (value) {
                          if (value == null || value.toString().isEmpty) {
                            return AppStaticStrings.cantBeEmpty;
                          }
                          return null;
                        },
                        onTapClick: () {
                          PersonalDetailsPopUps.generateIndex(
                            context: context,
                            startingValue: 1,
                            indexNumber: 31,
                            onSelected: (date) {
                              controller.datesController.text = date.toString();
                            },
                          );
                        },
                        hintText: AppStaticStrings.dD,
                        textEditingController: controller.datesController,
                      )),
                      const SizedBox(
                        width: 10,
                      ),
                      //Month

                      Expanded(
                          child: CustomTextField(
                        validator: (value) {
                          if (value == null || value.toString().isEmpty) {
                            return AppStaticStrings.cantBeEmpty;
                          }
                          return null;
                        },
                        onTapClick: () {
                          PersonalDetailsPopUps.generateListOfText(
                            context: context,
                            list: PopUpValueLists.months,
                            onCountrySelected: (value) {
                              controller.monthController.text = value;
                            },
                          );
                        },
                        hintText: AppStaticStrings.mM,
                        textEditingController: controller.monthController,
                      )),
                      const SizedBox(
                        width: 10,
                      ),
                      //Year

                      Expanded(
                          child: CustomTextField(
                        validator: (value) {
                          if (value == null || value.toString().isEmpty) {
                            return AppStaticStrings.cantBeEmpty;
                          }
                          return null;
                        },
                        onTapClick: () {
                          PersonalDetailsPopUps.showYearDialog(
                              context: context,
                              onYearSelected: (date) {
                                controller.yearController.text =
                                    date.toString();
                              });
                        },
                        hintText: AppStaticStrings.yYYY,
                        textEditingController: controller.yearController,
                      )),
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
                      //Fit
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
                              list: PopUpValueLists.ft,
                              onCountrySelected: (value) {
                                controller.fitController.text = value;
                              },
                            );
                          },
                          hintText: AppStaticStrings.ft,
                          textEditingController: controller.fitController,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      //Inch

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
                              list: PopUpValueLists.inchValues,
                              onCountrySelected: (value) {
                                controller.incController.text =
                                    value.toString();
                              },
                              context: context);
                        },
                        hintText: AppStaticStrings.inc,
                        textEditingController: controller.incController,
                      )),
                    ],
                  ),
                  //Religion

                  const CustomText(
                    top: 16,
                    bottom: 8,
                    text: AppStaticStrings.religion,
                  ),
                  CustomTextField(
                    onTapClick: () {
                      PersonalDetailsPopUps.generateListOfText(
                        context: context,
                        list: PopUpValueLists.religionList,
                        onCountrySelected: (value) {
                          controller.religionController.text = value;
                        },
                      );
                    },
                    textEditingController: controller.religionController,
                    hintText: AppStaticStrings.religion,
                  ),
                  //Mother Tongue

                  const CustomText(
                    top: 16,
                    bottom: 8,
                    text: AppStaticStrings.motherTongue,
                  ),
                  CustomTextField(
                    onTapClick: () {
                      PersonalDetailsPopUps.generateListOfText(
                        context: context,
                        list: PopUpValueLists.motherTongueList,
                        onCountrySelected: (value) {
                          controller.motherTounghController.text = value;
                        },
                      );
                    },
                    textEditingController: controller.motherTounghController,
                    hintText: AppStaticStrings.motherTongue,
                  ),
                  //

                  //Select Country and Country
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
                    flagState: CountryFlag.DISABLE,

                    ///Dropdown box decoration to style your dropdown selector [OPTIONAL PARAMETER] (USE with disabledDropdownDecoration)
                    dropdownDecoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                        color: Colors.white,
                        border:
                            Border.all(color: Colors.grey.shade300, width: 1)),

                    ///Disabled Dropdown box decoration to style your dropdown selector [OPTIONAL PARAMETER]  (USE with disabled dropdownDecoration)
                    disabledDropdownDecoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                        color: Colors.grey.shade300,
                        border:
                            Border.all(color: Colors.grey.shade300, width: 1)),

                    ///placeholders for dropdown search field
                    countrySearchPlaceholder: "Country",
                    stateSearchPlaceholder: "State",
                    citySearchPlaceholder: "City",

                    ///labels for dropdown
                    countryDropdownLabel: "Country",
                    stateDropdownLabel: "State",
                    cityDropdownLabel: "City",

                    ///Default Country
                    //defaultCountry: CscCountry.India,

                    ///Disable country dropdown (Note: use it with default country)
                    //disableCountry: true,

                    ///Country Filter [OPTIONAL PARAMETER]
                    // countryFilter: [
                    //   CscCountry.India,
                    //   CscCountry.United_States,
                    //   CscCountry.Canada
                    // ],

                    ///selected item style [OPTIONAL PARAMETER]
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
                        controller.countryValue = value;
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

                  //Residential Status

                  const CustomText(
                    top: 16,
                    bottom: 8,
                    text: AppStaticStrings.residentialStatus,
                  ),
                  CustomTextField(
                    onTapClick: () {
                      PersonalDetailsPopUps.generateListOfText(
                        context: context,
                        list: PopUpValueLists.residentialStatusList,
                        onCountrySelected: (value) {
                          controller.residentialStatusController.text = value;
                        },
                      );
                    },
                    textEditingController:
                        controller.residentialStatusController,
                    hintText: AppStaticStrings.residentialStatus,
                  ),
                  const SizedBox(
                    height: 20,
                  )
                ],
              ),
            ),
          ));
    });
  }
}
