import 'package:flutter/material.dart';
import 'package:matrimony/utils/app_colors.dart';
import 'package:matrimony/utils/app_icons.dart';
import 'package:matrimony/utils/app_static_strings.dart';
import 'package:matrimony/view/widget/customText/custom_text.dart';
import 'package:matrimony/view/widget/custom_img/custom_img.dart';

class ChatMoreField extends StatefulWidget {
  const ChatMoreField({super.key});

  @override
  State<ChatMoreField> createState() => _ChatMoreFieldState();
}

class _ChatMoreFieldState extends State<ChatMoreField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 30),
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
          color: AppColors.pink60),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          //reply

          GestureDetector(
            onTap: () {},
            child: const Column(
              children: [
                CustomImage(
                  size: 16,
                  imageSrc: AppIcons.reply,
                ),
                CustomText(
                  fontSize: 12,
                  color: AppColors.white100,
                  top: 8,
                  text: AppStaticStrings.reply,
                )
              ],
            ),
          ),

          //copy

          GestureDetector(
            onTap: () {},
            child: const Column(
              children: [
                CustomImage(
                  size: 16,
                  imageSrc: AppIcons.copy,
                ),
                CustomText(
                  fontSize: 12,
                  color: AppColors.white100,
                  top: 8,
                  text: AppStaticStrings.copy,
                )
              ],
            ),
          ),

          //Forward

          GestureDetector(
            onTap: () {},
            child: const Column(
              children: [
                CustomImage(
                  size: 16,
                  imageSrc: AppIcons.forward,
                ),
                CustomText(
                  fontSize: 12,
                  color: AppColors.white100,
                  top: 8,
                  text: AppStaticStrings.forward,
                )
              ],
            ),
          ),

          //Delete

          GestureDetector(
            onTap: () {},
            child: const Column(
              children: [
                CustomImage(
                  size: 16,
                  imageSrc: AppIcons.delete,
                ),
                CustomText(
                  fontSize: 12,
                  color: AppColors.white100,
                  top: 8,
                  text: AppStaticStrings.delete,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
