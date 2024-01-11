import 'package:flutter/material.dart';
import 'package:matrimony/utils/app_colors.dart';
import 'package:matrimony/utils/app_icons.dart';
import 'package:matrimony/utils/app_static_strings.dart';
import 'package:matrimony/view/widget/button/button.dart';
import 'package:matrimony/view/widget/customText/custom_text.dart';
import 'package:matrimony/view/widget/custom_img/custom_img.dart';

class RequestCard extends StatelessWidget {
  final String proPic;

  final bool isTwoButton;
  final String name;
  final String title;
  final String subTitle;
  final String button0Title;
  final String button1Title;
  final String button2Title;
  final VoidCallback? button0Ontap;
  final VoidCallback? button1Ontap;
  final VoidCallback? button2Ontap;
  final Color button1BgColor;

  const RequestCard({
    super.key,
    required this.name,
    required this.title,
    required this.subTitle,
    required this.proPic,
    this.isTwoButton = false,
    this.button0Title = AppStaticStrings.message,
    this.button1Title = AppStaticStrings.accept,
    this.button2Title = AppStaticStrings.decline,
    this.button0Ontap,
    this.button1Ontap,
    this.button2Ontap,
    this.button1BgColor = AppColors.pink100,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      //height: 130,
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(boxShadow: const [
        BoxShadow(
          color: AppColors.black10,
          blurRadius: 18,
          offset: Offset(0, 0),
          spreadRadius: 0,
        )
      ], borderRadius: BorderRadius.circular(8), color: AppColors.white100),
      child: Row(
        children: [
          //Image
          Expanded(
            child: Row(
              children: [
                SizedBox(
                  height: 130,
                  width: 100,
                  child: Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(proPic), fit: BoxFit.cover)),
                  ),
                ),
              ],
            ),
          ),
          //Name ,Occopation , location

          Expanded(
            flex: 2,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //Name
                      CustomText(
                        textAlign: TextAlign.left,
                        maxLines: 1,
                        fontWeight: FontWeight.w500,
                        color: AppColors.pink100,
                        text: name,
                      ),
                      //Occopation
                      CustomText(
                        textAlign: TextAlign.left,
                        maxLines: 1,
                        fontSize: 12,
                        color: AppColors.black40,
                        text: title,
                      ),
                      //Location
                      Row(
                        children: [
                          const CustomImage(imageSrc: AppIcons.location),
                          CustomText(
                            textAlign: TextAlign.left,
                            maxLines: 1,
                            left: 4,
                            fontSize: 12,
                            color: AppColors.black40,
                            text: subTitle,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 8,
                      ),

                      //Button

                      isTwoButton
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: CustomButton(
                                    backgroundColor: button1BgColor,
                                    height: 36,
                                    text: button1Title,
                                    ontap: () {
                                      button1Ontap!();
                                    },
                                  ),
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                Expanded(
                                  child: CustomButton(
                                    height: 36,
                                    textColor: AppColors.pink100,
                                    text: button2Title,
                                    isfillColor: false,
                                    ontap: () {
                                      button2Ontap!();
                                    },
                                  ),
                                ),
                              ],
                            )
                          : CustomButton(
                              text: button0Title,
                              height: 36,
                              ontap: () {
                                button0Ontap!();
                              },
                            ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
