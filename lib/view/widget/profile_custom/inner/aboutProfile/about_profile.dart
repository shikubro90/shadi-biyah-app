import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:matrimony/core/global/height_calculator/height_calculator.dart';
import 'package:matrimony/core/route/app_route.dart';
import 'package:matrimony/utils/app_colors.dart';
import 'package:matrimony/utils/app_icons.dart';
import 'package:matrimony/utils/app_static_strings.dart';
import 'package:matrimony/view/widget/customText/custom_text.dart';
import 'package:matrimony/view/widget/custom_img/custom_img.dart';
import 'package:matrimony/view/widget/profile_custom/inner/const_file/const_file.dart';

class AboutProfile extends StatefulWidget {
  final dynamic data;
  final bool myProfile;
  final bool isPremium;
  const AboutProfile(
      {super.key, this.myProfile = false, this.isPremium = true, this.data});

  @override
  State<AboutProfile> createState() => _AboutProfileState();
}

class _AboutProfileState extends State<AboutProfile> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //About Row

        CustomRowProfile(
            isMyProfile: widget.myProfile,
            text: AppStaticStrings.about,
            ontap: () {
              Get.toNamed(AppRoute.aboutYourSelf, arguments: [
                AppStaticStrings.editAboutMe,
                widget.data!.aboutMe,
                true
              ]);
            }),

        //About Text

        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: ShapeDecoration(
            color: Colors.white,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            shadows: const [
              BoxShadow(
                color: AppColors.black20,
                blurRadius: 18,
                offset: Offset(0, 0),
                spreadRadius: 0,
              )
            ],
          ),
          child: CustomText(
            color: AppColors.black80,
            textAlign: TextAlign.start,
            maxLines: 12,
            text: widget.data!.aboutMe.toString(),
          ),
        ),

        //Personal Details Row

        CustomRowProfile(
            isMyProfile: widget.myProfile,
            text: AppStaticStrings.personalDetails,
            ontap: () {
              //Converting height
              Map<String, String> heightParts = HeightConverter.splitHeight(
                  HeightConverter.centimetersToFeetAndInches(
                      "${widget.data!.height}"));

              //Converting Date of birth

              String dateOfBirth = widget.data!.dataOfBirth;

              String day = '';
              String month = '';
              String year = '';

              List<String> parts2 = dateOfBirth.split(' ');

              if (parts2.length == 3) {
                day = parts2[0].trim();
                month = parts2[1].trim();
                year = parts2[2].trim();
              }

              Get.toNamed(AppRoute.aboutProfileDetails, arguments: [
                widget.data.name,
                widget.data!.gender,
                widget.data!.maritalStatus,
                day,
                month,
                year,
                heightParts['feet'],
                heightParts['inches'],
                widget.data!.religion,
                widget.data!.caste,
                widget.data!.sect,
                widget.data!.motherTongue,
                widget.data!.country,
                widget.data!.state,
                widget.data!.city,
                widget.data!.residentialStatus,
              ]);
            }),

        //Personal Details

        Container(
            padding: const EdgeInsets.all(12),
            decoration: ShapeDecoration(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              shadows: const [
                BoxShadow(
                  color: AppColors.black20,
                  blurRadius: 18,
                  offset: Offset(0, 0),
                  spreadRadius: 0,
                )
              ],
            ),
            child: Column(
              children: [
                TitleRow(
                    title: AppStaticStrings.name, value: widget.data!.name),
                TitleRow(
                    title: AppStaticStrings.gender, value: widget.data!.gender),
                TitleRow(
                    title: AppStaticStrings.maritalStatus,
                    value: widget.data!.maritalStatus),
                TitleRow(
                    title: AppStaticStrings.age,
                    value: widget.data!.age.toString()),
                TitleRow(
                    title: AppStaticStrings.height,
                    value: HeightConverter.centimetersToFeetAndInches(
                        "${widget.data!.height}")),
                TitleRow(
                    title: AppStaticStrings.religion,
                    value: widget.data!.religion),
                TitleRow(
                    title: AppStaticStrings.motherTongue,
                    value: widget.data!.motherTongue),
                TitleRow(
                    title: AppStaticStrings.country,
                    value: widget.data!.country),
                TitleRow(
                    title: AppStaticStrings.city, value: widget.data!.city),
                TitleRow(
                    title: AppStaticStrings.residentialStatus,
                    value: widget.data!.residentialStatus),
              ],
            )),

        //Carrier Details Row

        CustomRowProfile(
            isMyProfile: widget.myProfile,
            text: AppStaticStrings.career,
            ontap: () {
              Get.toNamed(AppRoute.carrerDetails, arguments: [
                AppStaticStrings.editCarrerDetails,
                widget.data!.education,
                widget.data!.workExperience,
                widget.data!.occupation,
                widget.data!.income,
                true
              ]);
            }),

        //Carrier Details

        Container(
            padding: const EdgeInsets.all(12),
            decoration: ShapeDecoration(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              shadows: const [
                BoxShadow(
                  color: AppColors.black20,
                  blurRadius: 18,
                  offset: Offset(0, 0),
                  spreadRadius: 0,
                )
              ],
            ),
            child: Column(
              children: [
                TitleRow(
                    title: AppStaticStrings.education,
                    value: widget.data!.education),
                TitleRow(
                    title: AppStaticStrings.workExperience,
                    value: widget.data!.workExperience),
                TitleRow(
                    title: AppStaticStrings.occupation,
                    value: widget.data!.occupation),
                TitleRow(
                    title: AppStaticStrings.income, value: widget.data!.income),
              ],
            )),

        //Life Style Row

        CustomRowProfile(
            isMyProfile: widget.myProfile,
            text: AppStaticStrings.lifeStyle,
            ontap: () {
              Get.toNamed(AppRoute.lifeStyle, arguments: [
                AppStaticStrings.editLifeStyle,
                widget.data!.habits,
                widget.data!.hobbies,
                widget.data!.favouriteMovies,
                widget.data!.favouriteMusic,
                widget.data!.sports,
                widget.data!.tvShows,
                true
              ]);
            }),

        //Life Style Details

        Container(
            padding: const EdgeInsets.all(12),
            decoration: ShapeDecoration(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              shadows: const [
                BoxShadow(
                  color: AppColors.black20,
                  blurRadius: 18,
                  offset: Offset(0, 0),
                  spreadRadius: 0,
                )
              ],
            ),
            child: Column(
              children: [
                TitleRow(
                    title: AppStaticStrings.habits, value: widget.data!.habits),
                TitleRow(
                    title: AppStaticStrings.hobbies,
                    value: widget.data!.hobbies),
                TitleRow(
                    title: AppStaticStrings.favouriteMusic,
                    value: widget.data!.favouriteMusic),
                TitleRow(
                    title: AppStaticStrings.favouriteMovies,
                    value: widget.data!.favouriteMovies),
                TitleRow(
                    title: AppStaticStrings.sports, value: widget.data!.sports),
                TitleRow(
                    title: AppStaticStrings.tvshows,
                    value: widget.data!.tvShows),
              ],
            )),

        //Contact Info

        CustomRowProfile(
            isMyProfile: false,
            text: AppStaticStrings.contactInformation,
            ontap: () {
              Get.toNamed(AppRoute.aboutContactInformation, arguments: [
                widget.data!.phoneNumber,
                widget.data!.email,
                widget.data!.isPhoneNumberVerified
              ]);
            }),

        //Contact Info
        widget.isPremium
            ? Container(
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.all(12),
                decoration: ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  shadows: const [
                    BoxShadow(
                      color: AppColors.black20,
                      blurRadius: 18,
                      offset: Offset(0, 0),
                      spreadRadius: 0,
                    )
                  ],
                ),
                child: Column(
                  children: [
                    TitleRow(
                        warrning: widget.data!.isPhoneNumberVerified == false
                            ? true
                            : false,
                        title: AppStaticStrings.contactNo,
                        value: widget.data!.phoneNumber),
                    TitleRow(
                        title: AppStaticStrings.mailAddress,
                        value: widget.data!.email),
                  ],
                ))
            : Container(
                height: 140,
                margin: const EdgeInsets.symmetric(vertical: 12),
                padding: const EdgeInsets.all(16),
                decoration: ShapeDecoration(
                  color: AppColors.pink5,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CustomText(
                      maxLines: 2,
                      textAlign: TextAlign.left,
                      fontSize: 16,
                      text: AppStaticStrings.contactDetailsArelocked,
                    ),
                    const CustomText(
                      maxLines: 2,
                      bottom: 4,
                      textAlign: TextAlign.left,
                      text: AppStaticStrings.becomeAArPemiumMember,
                      color: AppColors.black40,
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.toNamed(AppRoute.premiumPackages);
                      },
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          CustomImage(
                            imageSrc: AppIcons.premium,
                            size: 16,
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          CustomText(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: AppColors.pink100,
                            text: AppStaticStrings.upgradeAccount,
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
      ],
    );
  }
}

//Its a class which consist 2 Text inside a Row
class TitleRow extends StatelessWidget {
  final String title;
  final String? value;

  final bool warrning;

  const TitleRow(
      {super.key,
      required this.title,
      required this.value,
      this.warrning = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: Row(
        children: [
          SizedBox(
            width: 150,
            child: CustomText(
              fontSize: 16.sp,
              textAlign: TextAlign.start,
              text: title,
              color: AppColors.black60,
            ),
          ),
          Expanded(
              child: Row(
            children: [
              Expanded(
                child: CustomText(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  textAlign: TextAlign.end,
                  text: value.toString(),
                ),
              ),
              if (warrning)
                CustomImage(
                  left: 5,
                  imageType: ImageType.png,
                  imageSrc: AppIcons.warrning,
                  size: 14.sp,
                ),
            ],
          )),
        ],
      ),
    );
  }
}
