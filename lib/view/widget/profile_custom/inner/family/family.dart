import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matrimony/core/route/app_route.dart';
import 'package:matrimony/utils/app_colors.dart';
import 'package:matrimony/utils/app_static_strings.dart';
import 'package:matrimony/view/widget/profile_custom/inner/const_file/const_file.dart';

class Family extends StatelessWidget {
  final dynamic data;
  final bool myProfile;
  const Family({super.key, this.myProfile = false, required this.data});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //Family Row

        CustomRowProfile(
            isMyProfile: myProfile,
            text: AppStaticStrings.familyDetails,
            ontap: () {
              Get.toNamed(AppRoute.familyDetails, arguments: [
                AppStaticStrings.editFamilyDetails,
                data.familyStatus,
                data.familyValues,
                data.familyType,
                data.familyIncome,
                data.fathersOccupation,
                data.mothersOccupation,
                data.brothers,
                data.sisters,
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
                    title: AppStaticStrings.familyStatus,
                    value: data.familyStatus),
                TitleRow(
                    title: AppStaticStrings.familyValues,
                    value: data.familyValues),
                TitleRow(
                    title: AppStaticStrings.familyType, value: data.familyType),
                TitleRow(
                    title: AppStaticStrings.familyIncome,
                    value: data.familyIncome),
                TitleRow(
                    title: AppStaticStrings.fatherOccupation,
                    value: data.fathersOccupation),
                TitleRow(
                    title: AppStaticStrings.motherOccupation,
                    value: data.mothersOccupation),
                TitleRow(
                    title: AppStaticStrings.noofBrothers, value: data.brothers),
                TitleRow(
                    title: AppStaticStrings.noofSisters, value: data.sisters),
              ],
            )),

        const SizedBox(
          height: 20,
        )
      ],
    );
  }
}
