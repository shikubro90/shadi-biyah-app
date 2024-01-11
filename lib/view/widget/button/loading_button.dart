import 'package:flutter/material.dart';
import 'package:matrimony/utils/app_colors.dart';

class CustomLoadingButton extends StatelessWidget {
  final Color backgroundColor;
  final Color textColor;

  final String text;
  final double height;
  final double width;
  final double top;
  final double left;
  final double right;
  final double bottom;
  final double elevation;
  final bool isfillColor;

  const CustomLoadingButton({
    super.key,
    this.backgroundColor = AppColors.pink100,
    this.textColor = AppColors.white100,
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
    return Container(
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
        child: const SizedBox(
          height: 16,
          width: 16,
          child: CircularProgressIndicator(
            color: Colors.white,
            strokeWidth: 2,
          ),
        ));
  }
}
