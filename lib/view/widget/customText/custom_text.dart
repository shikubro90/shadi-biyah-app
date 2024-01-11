import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:matrimony/utils/app_colors.dart';

class CustomText extends StatelessWidget {
  const CustomText(
      {super.key,
      this.maxLines,
      this.textAlign = TextAlign.center,
      this.left = 0,
      this.right = 0,
      this.top = 0,
      this.bottom = 0,
      this.fontSize = 14,
      this.fontWeight = FontWeight.w400,
      this.color = AppColors.black100,
      this.text = ""});

  final double left;
  final double right;
  final double top;
  final double bottom;
  final double fontSize;
  final FontWeight fontWeight;
  final Color color;
  final String text;
  final TextAlign textAlign;
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          left: left.w, right: right.w, top: top.h, bottom: bottom.h),
      child: Text(
        textAlign: textAlign,
        text,
        maxLines: maxLines,
        overflow: TextOverflow.ellipsis,
        style: GoogleFonts.poppins(
          fontSize: fontSize.sp,
          fontWeight: fontWeight,
          color: color,
        ),
      ),
    );
  }
}
