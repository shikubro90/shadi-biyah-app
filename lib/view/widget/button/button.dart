import 'package:flutter/material.dart';
import 'package:matrimony/utils/app_colors.dart';
import 'package:matrimony/view/widget/customText/custom_text.dart';

class CustomButton extends StatelessWidget {
  final Color backgroundColor;
  final Color textColor;
  final VoidCallback ontap;
  final String text;
  final double height;
  final double width;
  final double top;
  final double left;
  final double right;
  final double bottom;
  final double elevation;
  final bool isfillColor;

  const CustomButton({
    super.key,
    this.backgroundColor = AppColors.pink100,
    this.textColor = AppColors.white100,
    required this.ontap,
    this.text = "Get Started",
    this.height = 56,
    this.width = double.infinity,
    this.top = 0,
    this.left = 0,
    this.right = 0,
    this.bottom = 0,
    this.elevation = 0,
    this.isfillColor = true,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        ontap();
      },
      child: Container(
        margin:
            EdgeInsets.only(top: top, left: left, right: right, bottom: bottom),
        alignment: Alignment.center,
        height: height,
        width: width,
        decoration: BoxDecoration(
          border: Border.all(
              color: isfillColor ? Colors.transparent : AppColors.pink100),
          borderRadius: BorderRadius.circular(8),
          color: isfillColor ? backgroundColor : null,
        ),
        child: CustomText(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: textColor,
          text: text,
        ),
      ),
    );
  }
}
