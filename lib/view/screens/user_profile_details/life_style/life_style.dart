import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matrimony/utils/app_static_strings.dart';
import 'package:matrimony/view/screens/user_profile_details/life_style/life_style_controller/life_style_controller.dart';
import 'package:matrimony/view/widget/button/button.dart';
import 'package:matrimony/view/widget/button/loading_button.dart';
import 'package:matrimony/view/widget/customText/custom_text.dart';
import 'package:matrimony/view/widget/custom_appbar_pink/custom_appbar_pink.dart';
import 'package:matrimony/view/widget/text_editingField/textediting_field.dart';

class LifeStyle extends StatefulWidget {
  const LifeStyle({super.key});

  @override
  State<LifeStyle> createState() => _LifeStyleState();
}

class _LifeStyleState extends State<LifeStyle> {
  LifeStyleController lifeStyleController = Get.find<LifeStyleController>();

  String title = "";
  bool isUpdate = false;

  @override
  void initState() {
    title = Get.arguments[0];

//
    lifeStyleController.habbitsController.text = Get.arguments[1];
    lifeStyleController.hobbiesController.text = Get.arguments[2];
    lifeStyleController.movieController.text = Get.arguments[3];
    lifeStyleController.musicController.text = Get.arguments[4];
    lifeStyleController.sportsController.text = Get.arguments[5];
    lifeStyleController.tvShowController.text = Get.arguments[6];

    isUpdate = Get.arguments[7];
    super.initState();
  }

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    //

    return GetBuilder<LifeStyleController>(builder: (controller) {
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
                      : AppStaticStrings.continuee,
                  bottom: 24,
                  left: 20,
                  right: 20,
                  ontap: () {
                    if (formKey.currentState!.validate()) {
                      controller.updateLifeStyle(isUpdate: isUpdate);
                    }
                  }),
          title: title,
          onBack: () {
            Get.back();
          },
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //Habbit

                    const CustomText(
                      top: 16,
                      bottom: 8,
                      text: AppStaticStrings.habits,
                    ),
                    CustomTextField(
                      validator: (value) {
                        if (value == null || value.toString().isEmpty) {
                          return AppStaticStrings.fieldCantBeEmpty;
                        }
                        return null;
                      },
                      textEditingController: controller.habbitsController,
                      hintText: AppStaticStrings.fiveTimesPrayer,
                      readOnly: false,
                    ),

                    //Hobbis

                    const CustomText(
                      top: 16,
                      bottom: 8,
                      text: AppStaticStrings.hobbies,
                    ),
                    CustomTextField(
                      validator: (value) {
                        if (value == null || value.toString().isEmpty) {
                          return AppStaticStrings.fieldCantBeEmpty;
                        }
                        return null;
                      },
                      textEditingController: controller.hobbiesController,
                      hintText: AppStaticStrings.traveling,
                      readOnly: false,
                    ),
                    //Favourite Music

                    const CustomText(
                      top: 16,
                      bottom: 8,
                      text: AppStaticStrings.favouriteMusic,
                    ),
                    CustomTextField(
                      validator: (value) {
                        if (value == null || value.toString().isEmpty) {
                          return AppStaticStrings.fieldCantBeEmpty;
                        }
                        return null;
                      },
                      textEditingController: controller.musicController,
                      hintText: AppStaticStrings.favouriteMusic,
                      readOnly: false,
                    ),
                    //Movie

                    const CustomText(
                      top: 16,
                      bottom: 8,
                      text: AppStaticStrings.favouriteMovies,
                    ),
                    CustomTextField(
                      validator: (value) {
                        if (value == null || value.toString().isEmpty) {
                          return AppStaticStrings.fieldCantBeEmpty;
                        }
                        return null;
                      },
                      textEditingController: controller.movieController,
                      hintText: AppStaticStrings.romantic,
                      readOnly: false,
                    ),

                    //Sports

                    const CustomText(
                      top: 16,
                      bottom: 8,
                      text: AppStaticStrings.sports,
                    ),
                    CustomTextField(
                      validator: (value) {
                        if (value == null || value.toString().isEmpty) {
                          return AppStaticStrings.fieldCantBeEmpty;
                        }
                        return null;
                      },
                      textEditingController: controller.sportsController,
                      hintText: AppStaticStrings.cricket,
                      readOnly: false,
                    ),

                    //Tv Show

                    const CustomText(
                      top: 16,
                      bottom: 8,
                      text: AppStaticStrings.tvshows,
                    ),
                    CustomTextField(
                      textInputAction: TextInputAction.done,
                      validator: (value) {
                        if (value == null || value.toString().isEmpty) {
                          return AppStaticStrings.fieldCantBeEmpty;
                        }
                        return null;
                      },
                      textEditingController: controller.tvShowController,
                      hintText: AppStaticStrings.thriller,
                      readOnly: false,
                    ),
                  ],
                ),
              ),
            ),
          ));
    });
  }
}
