import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:matrimony/utils/app_colors.dart';
import 'package:matrimony/utils/app_static_strings.dart';
import 'package:matrimony/view/widget/customText/custom_text.dart';

class NoMessage extends StatefulWidget {
  const NoMessage({super.key});

  @override
  State<NoMessage> createState() => _NoMessageState();
}

class _NoMessageState extends State<NoMessage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        // floatingActionButton: FloatingActionButton(
        //   backgroundColor: AppColors.pink100,
        //   onPressed: () {
        //     Get.toNamed(AppRoute.messageSuggest);
        //   },
        //   child: const Icon(
        //     Icons.add,
        //   ),
        // ),
        body: Padding(
          padding: const EdgeInsets.only(
            left: 20,
            right: 20,
          ),
          child: Container(
            height: 130.h,
            margin: const EdgeInsets.only(bottom: 24),
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
                CustomText(
                  maxLines: 2,
                  textAlign: TextAlign.left,
                  fontSize: 16,
                  bottom: 10,
                  text: AppStaticStrings.messageListIsEmpty,
                ),
                CustomText(
                  maxLines: 2,
                  bottom: 4,
                  textAlign: TextAlign.left,
                  text: AppStaticStrings.youDontHaveAnyChat,
                  color: AppColors.black40,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
