import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:matrimony/core/route/app_route.dart';
import 'package:matrimony/utils/app_colors.dart';
import 'package:matrimony/utils/app_icons.dart';
import 'package:matrimony/utils/app_images.dart';
import 'package:matrimony/utils/app_static_strings.dart';
import 'package:matrimony/view/widget/customText/custom_text.dart';
import 'package:matrimony/view/widget/custom_img/custom_img.dart';

class PackageCardDesign extends StatelessWidget {
  final dynamic package;
  final String country;
  // final PackageModel package;
  final bool showButton;

  const PackageCardDesign(
      {super.key,
      // required this.package,

      this.showButton = true,
      required this.package,
      required this.country});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 60,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [
            BoxShadow(
              color: AppColors.black10,
              blurRadius: 18,
              offset: Offset(0, 0),
              spreadRadius: 0,
            )
          ],
          color: AppColors.white100),
      margin: const EdgeInsets.only(left: 24, right: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          //Top Section
          SizedBox(
            width: double.infinity,
            height: 120,
            child: Stack(
              alignment: Alignment.center,
              children: [
                //Left Side Design
                Positioned(
                  top: 0,
                  left: 0,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      //Design
                      const CustomImage(
                        size: 100,
                        imageSrc: AppImages.cardDesign,
                        imageType: ImageType.png,
                      ),

                      //Month
                      Positioned(
                        left: 15,
                        child: CustomText(
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                          color: AppColors.white100,
                          text: "${package.duration} ${AppStaticStrings.month}",
                        ),
                      )
                    ],
                  ),
                ),

                Positioned(
                  top: 24,
                  child: Column(
                    children: [
                      //Package Name
                      SizedBox(
                        width: 130.w,
                        child: CustomText(
                          fontSize: 20,
                          maxLines: 2,
                          fontWeight: FontWeight.w500,
                          text: package.name.toString(),
                        ),
                      ),
                      //Package Price

                      CustomText(
                        fontSize: 24,
                        color: AppColors.pink100,
                        fontWeight: FontWeight.w500,
                        text: country == "PK"
                            ? "${package.pkCountryPrice} PkR"
                            : "\$${package.otherCountryPrice}",
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //Match Request

                Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Row(
                    children: [
                      const CustomImage(imageSrc: AppIcons.roundCheck),
                      const SizedBox(
                        width: 8,
                      ),
                      CustomText(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        text:
                            "${AppStaticStrings.send} ${package.matchRequests} ${AppStaticStrings.matchRequest}",
                      ),
                    ],
                  ),
                ),
                //Reminder

                Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Row(
                    children: [
                      const CustomImage(imageSrc: AppIcons.roundCheck),
                      const SizedBox(
                        width: 8,
                      ),
                      Expanded(
                        child: CustomText(
                          textAlign: TextAlign.left,
                          maxLines: 2,
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          text:
                              "${AppStaticStrings.sendReminderUp} ${package.reminders} ${AppStaticStrings.member}",
                        ),
                      ),
                    ],
                  ),
                ),
                //Message

                Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomImage(
                          imageSrc: package.message != 0
                              ? AppIcons.roundCheck
                              : AppIcons.roundClose),
                      const SizedBox(
                        width: 8,
                      ),
                      Expanded(
                        child: CustomText(
                          textAlign: TextAlign.left,
                          maxLines: 2,
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          text:
                              "${AppStaticStrings.sendReminderUp} ${package.message} ${AppStaticStrings.messagesToPreferredMatches}",
                        ),
                      ),
                    ],
                  ),
                ),
                //Premium badge

                const Padding(
                  padding: EdgeInsets.only(bottom: 24),
                  child: Row(
                    children: [
                      CustomImage(imageSrc: AppIcons.premium),
                      SizedBox(
                        width: 8,
                      ),
                      CustomText(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        text: AppStaticStrings.getapremiumbadgeonprofile,
                      ),
                    ],
                  ),
                ),

                //Update Button

                if (showButton)
                  GestureDetector(
                    onTap: () {
                      Get.toNamed(AppRoute.upgradePackageCard,
                          arguments: [package, true, country]);
                    },
                    child: Container(
                      height: 44,
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: AppColors.pink100),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomImage(imageSrc: AppIcons.premium),
                          CustomText(
                            left: 4,
                            color: AppColors.white100,
                            text: AppStaticStrings.upgradeNow,
                          )
                        ],
                      ),
                    ),
                  ),
                const SizedBox(
                  height: 24,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
