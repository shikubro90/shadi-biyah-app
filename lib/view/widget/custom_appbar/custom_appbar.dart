import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matrimony/utils/app_colors.dart';
import 'package:matrimony/view/widget/customText/custom_text.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  final double appBarHeight;
  final double? appBarWidth;
  final Color appBarBgColor;
  final String title;
  final bool isBackButton;

  const CustomAppBar(
      {this.appBarHeight = 64,
      this.appBarWidth,
      this.appBarBgColor = Colors.transparent,
      required this.title,
      super.key,
      this.isBackButton = true});

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();

  @override
  Size get preferredSize => Size(appBarWidth ?? double.infinity, appBarHeight);
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: widget.preferredSize,
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsetsDirectional.only(
          start: 12,
          top: 8,
          end: 20,
        ),
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(color: widget.appBarBgColor),
        child: Row(
          children: [
            if (widget.isBackButton)
              IconButton(
                  onPressed: () {
                    navigator!.pop();
                  },
                  icon: const Icon(
                      color: AppColors.black60, Icons.arrow_back_ios_rounded)),
            const SizedBox(
              width: 8,
            ),
            CustomText(
              text: widget.title,
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ],
        ),
      ),
    );
  }
}
