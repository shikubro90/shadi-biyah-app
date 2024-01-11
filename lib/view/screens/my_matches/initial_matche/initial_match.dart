import 'package:flutter/material.dart';
import 'package:matrimony/utils/app_colors.dart';
import 'package:matrimony/utils/app_static_strings.dart';
import 'package:matrimony/view/widget/customText/custom_text.dart';

class InitialMatches extends StatefulWidget {
  const InitialMatches({super.key});

  @override
  State<InitialMatches> createState() => _InitialMatchesState();
}

class _InitialMatchesState extends State<InitialMatches> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 44, left: 20, right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomText(
            text: AppStaticStrings.message,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),

          //Box Design
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 24, bottom: 18),
                    padding: const EdgeInsets.all(16),
                    decoration: ShapeDecoration(
                      color: AppColors.pink5,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      shadows: const [
                        BoxShadow(
                          color: AppColors.black10,
                          blurRadius: 18,
                          offset: Offset(0, 0),
                          spreadRadius: 0,
                        )
                      ],
                    ),
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //Title 1

                        CustomText(
                          maxLines: 2,
                          textAlign: TextAlign.left,
                          fontSize: 16,
                          bottom: 8,
                          text: AppStaticStrings.nomatchedprofiles,
                        ),

                        //Title 2

                        CustomText(
                          maxLines: 2,
                          bottom: 4,
                          textAlign: TextAlign.left,
                          text: AppStaticStrings.youDontHaveAnyMatched,
                          color: AppColors.black40,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
