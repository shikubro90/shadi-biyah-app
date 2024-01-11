import 'package:flutter/material.dart';
import 'package:matrimony/utils/app_colors.dart';
import 'package:matrimony/view/widget/customText/custom_text.dart';

class TabBarButton extends StatelessWidget {
  final VoidCallback ontap;
  final bool isSelected;
  final String text;
  const TabBarButton(
      {super.key,
      required this.ontap,
      required this.isSelected,
      required this.text});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          ontap();
        },
        child: Column(
          children: [
            Container(
              width: double.infinity,
              decoration: const BoxDecoration(boxShadow: [
                BoxShadow(
                  color: AppColors.black10,
                  blurRadius: 18,
                  offset: Offset(0, 0),
                  spreadRadius: 0,
                )
              ], gradient: AppColors.whiteBG),
              padding: const EdgeInsets.symmetric(
                vertical: 10,
              ),
              child: CustomText(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                text: text,
              ),
            ),
            Container(
              height: 2,
              color: isSelected ? AppColors.pink100 : null,
            )
          ],
        ),
      ),
    );
  }
}
