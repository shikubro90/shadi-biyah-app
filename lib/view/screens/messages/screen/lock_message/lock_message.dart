import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matrimony/core/route/app_route.dart';
import 'package:matrimony/utils/app_colors.dart';
import 'package:matrimony/utils/app_icons.dart';
import 'package:matrimony/utils/app_static_strings.dart';
import 'package:matrimony/utils/device_utils.dart';
import 'package:matrimony/view/widget/customText/custom_text.dart';
import 'package:matrimony/view/widget/custom_img/custom_img.dart';

class LockMessage extends StatefulWidget {
  const LockMessage({super.key});

  @override
  State<LockMessage> createState() => _LockMessageState();
}

class _LockMessageState extends State<LockMessage> {
  @override
  void initState() {
    DeviceUtils.statusBarColor();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 24),
          child: Container(
            height: 140,
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CustomText(
                  maxLines: 2,
                  textAlign: TextAlign.left,
                  fontSize: 16,
                  text: AppStaticStrings.messageOptionIsLocked,
                ),
                const CustomText(
                  maxLines: 2,
                  bottom: 4,
                  textAlign: TextAlign.left,
                  text: AppStaticStrings.becomeAArPemiumMember,
                  color: AppColors.black40,
                ),
                GestureDetector(
                  onTap: () {
                    Get.toNamed(AppRoute.premiumPackages);
                  },
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CustomImage(
                        imageSrc: AppIcons.premium,
                        size: 16,
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      CustomText(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppColors.pink100,
                        text: AppStaticStrings.upgradeAccount,
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
