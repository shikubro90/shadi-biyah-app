import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:matrimony/utils/app_colors.dart';
import 'package:matrimony/utils/app_icons.dart';
import 'package:matrimony/utils/app_static_strings.dart';
import 'package:matrimony/utils/device_utils.dart';
import 'package:matrimony/view/screens/home/home.dart';
import 'package:matrimony/view/screens/my_matches/matches_navigate.dart';
import 'package:matrimony/view/screens/messages/screen/message_navigator.dart';
import 'package:matrimony/view/screens/profile/profile.dart';
import 'package:matrimony/view/widget/customText/custom_text.dart';

class NavBar extends StatefulWidget {
  final int currentIndex;

  const NavBar({required this.currentIndex, super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  var bottomNavIndex = 0;

  List<String> selectedIcon = [
    AppIcons.home,
    AppIcons.message,
    AppIcons.heart,
    AppIcons.profile,
  ];

  List<String> selectedText = [
    AppStaticStrings.home,
    AppStaticStrings.messages,
    AppStaticStrings.matches,
    AppStaticStrings.profile,
  ];

  List<String> unselectedIcon = [
    AppIcons.home2,
    AppIcons.message2,
    AppIcons.heart2,
    AppIcons.profile2,
  ];

  @override
  void initState() {
    DeviceUtils.systemNavigationBarColor();
    bottomNavIndex = widget.currentIndex;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      width: MediaQuery.of(context).size.width,
      padding:
          const EdgeInsetsDirectional.symmetric(horizontal: 20, vertical: 16),
      alignment: Alignment.center,
      color: AppColors.pink100,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(
          unselectedIcon.length,
          (index) => InkWell(
            onTap: () => onTap(index),
            child: Padding(
              padding: const EdgeInsetsDirectional.all(2),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  index != bottomNavIndex
                      ? SvgPicture.asset(selectedIcon[index],
                          height: 24, width: 24)
                      : SvgPicture.asset(unselectedIcon[index],
                          height: 24, width: 24),
                  CustomText(
                    color: index == bottomNavIndex
                        ? AppColors.white100
                        : AppColors.white100.withOpacity(.8),
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    text: selectedText[index],
                  ),
                  index == bottomNavIndex
                      ? Container(
                          width: 8,
                          height: 8,
                          decoration: const ShapeDecoration(
                            color: Colors.white,
                            shape: OvalBorder(),
                          ),
                        )
                      : const SizedBox()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void onTap(int index) {
    // HomeController homeController = Get.find<HomeController>();
    // homeController.scrollController.dispose();
    if (index == 0) {
      if (!(widget.currentIndex == 0)) {
        Get.offAll(() => const HomeScreen());
      }
    } else if (index == 1) {
      if (!(widget.currentIndex == 1)) {
        Get.offAll(() => const MessageNavigator());
      }
    } else if (index == 2) {
      if (!(widget.currentIndex == 2)) {
        Get.offAll(() => const MatchesNavigate());
      }
    } else if (index == 3) {
      if (!(widget.currentIndex == 3)) {
        Get.offAll(() => const Profile());
      }
    }
  }
}
