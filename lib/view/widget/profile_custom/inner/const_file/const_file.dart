//Its a class which consist 2 Text inside a Row
import 'package:flutter/material.dart';
import 'package:matrimony/utils/app_colors.dart';
import 'package:matrimony/utils/app_icons.dart';
import 'package:matrimony/view/widget/customText/custom_text.dart';
import 'package:matrimony/view/widget/custom_img/custom_img.dart';

class TitleRow extends StatelessWidget {
  final String title;
  final String? value;

  const TitleRow({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomText(
            text: title,
            color: AppColors.black60,
          ),
          CustomText(
            fontWeight: FontWeight.w500,
            textAlign: TextAlign.start,
            text: value.toString(),
          ),
        ],
      ),
    );
  }
}

//Its a class which consist 1 Text and 1 image Button inside a Row

class CustomRowProfile extends StatelessWidget {
  final String text;
  final bool isMyProfile;
  final VoidCallback ontap;

  const CustomRowProfile(
      {super.key,
      required this.text,
      required this.ontap,
      this.isMyProfile = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16, top: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomText(
            text: text,
          ),
          if (isMyProfile)
            GestureDetector(
              onTap: () {
                ontap();
              },
              child: Container(
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.pink100,
                  ),
                  padding: const EdgeInsets.all(5),
                  child: const CustomImage(imageSrc: AppIcons.edit)),
            )
        ],
      ),
    );
  }
}
