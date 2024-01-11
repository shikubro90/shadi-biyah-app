import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matrimony/core/route/app_route.dart';
import 'package:matrimony/utils/app_colors.dart';
import 'package:matrimony/utils/app_static_strings.dart';
import 'package:matrimony/utils/app_utils.dart';
import 'package:matrimony/view/screens/auth/sign_up/all_pop_up/pop_up.dart';
import 'package:matrimony/view/screens/auth/sign_up/sign_up_controller/sign_up_controller.dart';
import 'package:matrimony/view/widget/button/button.dart';
import 'package:matrimony/view/widget/customText/custom_text.dart';
import 'package:matrimony/view/widget/custom_appbar_pink/custom_appbar_pink.dart';
import 'package:matrimony/view/widget/text_editingField/textediting_field.dart';
import 'package:csc_picker/csc_picker.dart';

class PersonalDetails extends StatefulWidget {
  const PersonalDetails({super.key});

  @override
  State<PersonalDetails> createState() => _PersonalDetailsState();
}

class _PersonalDetailsState extends State<PersonalDetails> {
  SignUpController signUpController = Get.find<SignUpController>();
  List<String> genderList = [
    AppStaticStrings.male,
    AppStaticStrings.female,
    AppStaticStrings.other
  ];
  final formKey = GlobalKey<FormState>();

  showMsg() {
    TostMessage.toastMessage(message: AppStaticStrings.countryCantBeEmpty);
  }

  @override
  Widget build(BuildContext context) {
    return CustomAppBarPink(
        bottomNavBar: CustomButton(
            text: AppStaticStrings.continuee,
            bottom: 24,
            left: 20,
            right: 20,
            ontap: () {
              if (signUpController.countryValue.isEmpty ||
                  signUpController.stateValue == "null") {
              } else if (signUpController.stateValue == "null" ||
                  signUpController.stateValue == "State") {
                showMsg();
              } else if (signUpController.cityValue == "null" ||
                  signUpController.cityValue == "City") {
                showMsg();
              } else if (formKey.currentState!.validate()) {
                Get.toNamed(AppRoute.carrerDetails, arguments: [
                  AppStaticStrings.career,
                  "",
                  "",
                  "",
                  "",
                  false
                ]);
              }
            }),
        title: AppStaticStrings.personalDetails,
        onBack: () {
          Get.back();
        },
        child: GetBuilder<SignUpController>(builder: (controller) {
          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //Select Gender
                    const CustomText(
                      top: 16,
                      bottom: 8,
                      text: AppStaticStrings.gender,
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
                          list: PopUpValueLists.gender,
                          onCountrySelected: (value) {
                            controller.genderController.text = value;
                          },
                        );
                      },
                      textEditingController: controller.genderController,
                      hintText: AppStaticStrings.gender,
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
                                controller.datesController.text =
                                    date.toString();
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
                                  controller.selectedYear = date;
                                  controller.yearController.text =
                                      controller.selectedYear.toString();
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
                                  controller.ftController.text = value;
                                },
                              );
                            },
                            hintText: AppStaticStrings.ft,
                            textEditingController: controller.ftController,
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

                    const SizedBox(
                      height: 20,
                    ),

                    // Select Country and Country

                    // CountryStateCityPicker(
                    //     country: countryController,
                    //     state: stateController,
                    //     city: cityController,
                    //     dialogColor: Colors.grey.shade200,
                    //     textFieldDecoration: InputDecoration(
                    //         fillColor: Colors.blueGrey.shade100,
                    //         filled: true,
                    //         suffixIcon: const Icon(Icons.arrow_downward_rounded),
                    //         border: const OutlineInputBorder(
                    //             borderSide: BorderSide.none))),

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
                  ],
                ),
              ),
            ),
          );
        }));
  }
}
