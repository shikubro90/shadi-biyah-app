import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matrimony/core/global/religion_caste_sect.dart';
import 'package:matrimony/core/route/app_route.dart';
import 'package:matrimony/utils/app_colors.dart';
import 'package:matrimony/utils/app_static_strings.dart';
import 'package:matrimony/view/screens/auth/sign_up/all_pop_up/pop_up.dart';
import 'package:matrimony/view/screens/auth/sign_up/sign_up_controller/sign_up_controller.dart';
import 'package:matrimony/view/widget/button/button.dart';
import 'package:matrimony/view/widget/customText/custom_text.dart';
import 'package:matrimony/view/widget/custom_appbar_pink/custom_appbar_pink.dart';
import 'package:matrimony/view/widget/religion_model/religion_model.dart';
import 'package:matrimony/view/widget/text_editingField/textediting_field.dart';

class SocialDetails extends StatefulWidget {
  const SocialDetails({super.key});

  @override
  State<SocialDetails> createState() => _SocialDetailsState();
}

class _SocialDetailsState extends State<SocialDetails> {
  int selectedMaritalStatus = 0;
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    ReligionSectCaste.getReligions();
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
              if (formKey.currentState!.validate()) {
                Get.toNamed(AppRoute.logInDetails);
              }
            }),
        title: AppStaticStrings.socialDetails,
        onBack: () {
          Get.back();
        },
        child: GetBuilder<SignUpController>(builder: (controller) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //Marital  Status
                    const CustomText(
                      top: 18,
                      text: AppStaticStrings.maritalStatus,
                    ),

                    SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: PopUpValueLists.maritalList
                            .asMap()
                            .entries
                            .map((entry) {
                          int index = entry.key;
                          String maritalStatus = entry.value;

                          return Row(
                            children: [
                              Radio(
                                activeColor: AppColors.pink100,
                                value: index,
                                groupValue: selectedMaritalStatus,
                                onChanged: (value) {
                                  setState(() {
                                    selectedMaritalStatus = value!;
                                    controller.maritalStatus = maritalStatus;
                                  });
                                },
                              ),
                              CustomText(
                                fontSize: 12,
                                text: maritalStatus,
                              ),
                            ],
                          );
                        }).toList(),
                      ),
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
                              ReligionSectCaste.casteSect = value;
                              controller.castSectController.clear();
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
                              controller.castSectController.text = value;
                            },
                          );
                        },
                        hintText: ReligionSectCaste.casteSect,
                        textEditingController: controller.castSectController,
                      ),

                    const SizedBox(
                      height: 20,
                    )
                  ],
                ),
              ),
            ),
          );
        }));
  }
}
