import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:matrimony/core/route/app_route.dart';
import 'package:matrimony/utils/app_colors.dart';
import 'package:matrimony/utils/app_icons.dart';
import 'package:matrimony/utils/app_static_strings.dart';
import 'package:matrimony/view/screens/auth/sign_up/sign_up_controller/sign_up_controller.dart';
import 'package:matrimony/view/widget/button/button.dart';
import 'package:matrimony/view/widget/customText/custom_text.dart';
import 'package:matrimony/view/widget/custom_appbar_pink/custom_appbar_pink.dart';
import 'package:matrimony/view/widget/custom_img/custom_img.dart';

class CreateProfileFor extends StatefulWidget {
  const CreateProfileFor({super.key});

  @override
  State<CreateProfileFor> createState() => _CreateProfileForState();
}

class _CreateProfileForState extends State<CreateProfileFor> {
  List<String> choicesText = [
    AppStaticStrings.self,
    AppStaticStrings.son,
    AppStaticStrings.daughter,
    AppStaticStrings.brother,
    AppStaticStrings.sister,
    AppStaticStrings.relative,
    AppStaticStrings.friend,
  ];

  List<String> choicesImage = [
    AppIcons.self,
    AppIcons.sonsvg,
    AppIcons.doughtersvg,
    AppIcons.brothersvg,
    AppIcons.sister,
    AppIcons.relative,
    AppIcons.friend,
  ];

  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return CustomAppBarPink(
      bottomNavBar: CustomButton(
          text: AppStaticStrings.continuee,
          bottom: 10,
          left: 20,
          right: 20,
          ontap: () {
            Get.toNamed(AppRoute.personalDetails);
          }),
      title: AppStaticStrings.createProfileFor,
      onBack: () {
        Get.back();
      },
      child: GetBuilder<SignUpController>(builder: (controller) {
        return Padding(
          padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 24),
          child: Wrap(
            alignment: WrapAlignment.center,
            children: List.generate(
                choicesText.length,
                (index) => GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedIndex = index;
                          controller.updateCreateProFor(
                              getCreateProFor: choicesText[index]);
                        });
                      },
                      child: Container(
                          height: 112.h,
                          width: index == 0 ? double.maxFinite : 160.w,
                          margin: EdgeInsets.only(
                              bottom: 10.h, right: index / 2 != 0 ? 10 : 0),
                          decoration: ShapeDecoration(
                            color: selectedIndex == index
                                ? AppColors.pink5
                                : AppColors.white100,
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                  width: 1,
                                  color: selectedIndex == index
                                      ? AppColors.pink100
                                      : AppColors.white100),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            shadows: const [
                              BoxShadow(
                                color: AppColors.black10,
                                blurRadius: 18,
                                offset: Offset(0, 0),
                                spreadRadius: 0,
                              )
                            ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CustomImage(imageSrc: choicesImage[index]),
                              const SizedBox(
                                height: 8,
                              ),
                              CustomText(
                                fontWeight: FontWeight.w500,
                                color: AppColors.pink100,
                                text: choicesText[index],
                              ),
                            ],
                          )),
                    )),
          ),
        );
      }),
    );
  }
}
