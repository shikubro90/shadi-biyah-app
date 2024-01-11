import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matrimony/core/route/app_route.dart';
import 'package:matrimony/utils/app_colors.dart';
import 'package:matrimony/utils/app_static_strings.dart';
import 'package:matrimony/view/widget/profile_custom/inner/const_file/const_file.dart';

class Preference extends StatefulWidget {
  final dynamic data;
  const Preference({super.key, this.myProfile = false, required this.data});
  final bool myProfile;

  @override
  State<Preference> createState() => _PreferenceState();
}

class _PreferenceState extends State<Preference> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //Family Row

        CustomRowProfile(
            isMyProfile: widget.myProfile,
            text: AppStaticStrings.preferencesDetails,
            ontap: () {
              String partnerCity = widget.data.partnerCity;

              // List<String> parts = partnerCity.split('-');

              String state = "";
              String city = "";

              // Split the string based on spaces or hyphens
              List<String> parts = partnerCity.split(RegExp(r'\s+|-'));

              if (parts.isNotEmpty) {
                setState(() {
                  state = parts[0].trim();
                  city = parts.skip(1).join(' ').trim();
                });
              }

              Get.toNamed(AppRoute.partnerPreferences, arguments: [
                AppStaticStrings.editPartnerPreferences,
                widget.data.partnerMinAge,
                widget.data.partnerMixAge,
                widget.data.partnerMinHeight,
                widget.data.partnerMixHeight,
                widget.data.partnerCountry,
                state,
                city,
                widget.data.partnerMaritalStatus,
                widget.data.partnerReligion,
                widget.data.partnerCaste,
                widget.data.partnerSect,
                widget.data.partnerMotherTongue,
                widget.data.partnerEducation,
                widget.data.partnerOccupation,
                widget.data.partnerMinIncome,
                widget.data.partnerMaxIncome,
                widget.data.partnerResidentialStatus,
                true
              ]);
            }),

        //Family Details

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
                    title: AppStaticStrings.age,
                    value:
                        "Around ${widget.data.partnerMinAge} - ${widget.data.partnerMixAge}"),
                TitleRow(
                    title: AppStaticStrings.height,
                    value:
                        "${widget.data.partnerMinHeight} - ${widget.data.partnerMixHeight}"),
                TitleRow(
                    title: AppStaticStrings.country,
                    value: widget.data.partnerCountry),
                TitleRow(
                    title: AppStaticStrings.city,
                    value: widget.data.partnerCity),
                TitleRow(
                    title: AppStaticStrings.maritalStatus,
                    value: widget.data.partnerMaritalStatus),
                TitleRow(
                    title: AppStaticStrings.religion,
                    value: widget.data.partnerReligion),
                TitleRow(
                    title: AppStaticStrings.motherTongue,
                    value: widget.data.partnerMotherTongue),
                TitleRow(
                    title: AppStaticStrings.education,
                    value: widget.data.partnerEducation),
                TitleRow(
                    title: AppStaticStrings.occupation,
                    value: widget.data.partnerOccupation),
                TitleRow(
                    title: AppStaticStrings.income,
                    value: "${widget.data.partnerMaxIncome}"),
              ],
            )),

        const SizedBox(
          height: 20,
        )
      ],
    );
  }
}
