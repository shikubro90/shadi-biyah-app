import 'package:csc_picker/csc_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matrimony/core/global/height_calculator/height_calculator.dart';
import 'package:matrimony/core/global/religion_caste_sect.dart';
import 'package:matrimony/core/route/app_route.dart';
import 'package:matrimony/utils/app_colors.dart';
import 'package:matrimony/utils/app_static_strings.dart';
import 'package:matrimony/view/screens/auth/sign_up/all_pop_up/pop_up.dart';
import 'package:matrimony/view/screens/messages/screen/message/inbox/all_inbox_repo/all_inbox_repo.dart';
import 'package:matrimony/view/screens/search/search_controller/search_controller.dart';
import 'package:matrimony/view/widget/customText/custom_text.dart';
import 'package:matrimony/view/widget/religion_model/religion_model.dart';
import 'package:matrimony/view/widget/request_card/request_card.dart';
import 'package:matrimony/view/widget/text_editingField/textediting_field.dart';

class SearchByCriteria extends StatefulWidget {
  final bool isSearch;

  const SearchByCriteria({
    super.key,
    required this.isSearch,
  });

  @override
  State<SearchByCriteria> createState() => _SearchByCriteriaState();
}

class _SearchByCriteriaState extends State<SearchByCriteria> {
  //
  String title = "";

  @override
  void initState() {
    ReligionSectCaste.getReligions();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SearchUserController>(builder: (controller) {
      return widget.isSearch
          ? controller.isLoading && controller.dataLoading == false
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : controller.results.isEmpty
                  ? const CustomText(
                      top: 60,
                      text: AppStaticStrings.noProfileFound,
                    )
                  : RefreshIndicator(
                      color: AppColors.pink100,
                      onRefresh: () async {
                        controller.refreshData();
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(top: 24),
                        child: ListView.builder(
                          controller: controller.scrollController,
                          physics: const AlwaysScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: controller.dataLoading
                              ? controller.results.length + 1
                              : controller.results.length,
                          itemBuilder: (context, index) {
                            var data = controller.results[index];

                            if (index < controller.results.length) {
                              return GestureDetector(
                                onTap: () {
                                  Get.toNamed(AppRoute.profileDetails,
                                      arguments: controller.results[index]);
                                },
                                child: RequestCard(
                                    button0Ontap: () async {
                                      String getChatID =
                                          await AllInboxRepo.createChat(
                                        partnerID: data.id!,
                                      );
                                      debugPrint(
                                          "Chat Id Profile Screen : $getChatID");
                                      Get.toNamed(AppRoute.inbox, arguments: [
                                        data.name.toString(),
                                        data.photo![0].publicFileUrl,
                                        data.id
                                      ], parameters: {
                                        "chatId": getChatID
                                      });
                                    },
                                    name: data.name.toString(),
                                    title: "${data.occupation} ${data.age}",
                                    subTitle: data.country.toString(),
                                    proPic: data.photo![0].publicFileUrl
                                        .toString()),
                              );
                            } else {
                              return const Center(
                                  child: CircularProgressIndicator());
                            }
                          },
                        ),
                      ),
                    )
          : SingleChildScrollView(
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
                          textEditingController: controller.heightMinController,
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
                          textEditingController: controller.heightMaxController,
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
                      religionList
                          .sort((a, b) => a.name!.compareTo(b.name.toString()));

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
                  // // Education

                  // const CustomText(
                  //   top: 20,
                  //   bottom: 8,
                  //   text: AppStaticStrings.education,
                  // ),

                  // CustomTextField(
                  //   validator: (value) {
                  //     if (value == null || value.toString().isEmpty) {
                  //       return AppStaticStrings.fieldCantBeEmpty;
                  //     }
                  //     return null;
                  //   },
                  //   onTapClick: () {
                  //     PersonalDetailsPopUps.generateListOfText(
                  //       context: context,
                  //       list: PopUpValueLists.educationList,
                  //       onCountrySelected: (value) {
                  //         controller.higherEducationController.text = value;
                  //       },
                  //     );
                  //   },
                  //   hintText: AppStaticStrings.education,
                  //   textEditingController: controller.higherEducationController,
                  // ),
                  // //Occupation

                  // const CustomText(
                  //   top: 20,
                  //   bottom: 8,
                  //   text: AppStaticStrings.occupation,
                  // ),

                  // CustomTextField(
                  //   validator: (value) {
                  //     if (value == null || value.toString().isEmpty) {
                  //       return AppStaticStrings.fieldCantBeEmpty;
                  //     }
                  //     return null;
                  //   },
                  //   onTapClick: () {
                  //     PersonalDetailsPopUps.generateListOfText(
                  //       context: context,
                  //       list: PopUpValueLists.occupationList,
                  //       onCountrySelected: (value) {
                  //         controller.occupationController.text = value;
                  //       },
                  //     );
                  //   },
                  //   hintText: AppStaticStrings.occupation,
                  //   textEditingController: controller.occupationController,
                  // ),

                  const SizedBox(
                    height: 24,
                  ),
                ],
              ),
            );
    });
  }
}
