import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matrimony/core/route/app_route.dart';
import 'package:matrimony/utils/app_colors.dart';
import 'package:matrimony/utils/app_icons.dart';
import 'package:matrimony/utils/app_static_strings.dart';
import 'package:matrimony/view/screens/profile/profile_controller/profile_controller.dart';
import 'package:matrimony/view/screens/profile/profile_model/profile_model.dart';
import 'package:matrimony/view/widget/customText/custom_text.dart';
import 'package:matrimony/view/widget/custom_img/custom_img.dart';
import 'package:matrimony/view/widget/nav_bar/nav_bar.dart';
import 'package:matrimony/view/widget/profile_custom/inner/aboutProfile/about_profile.dart';
import 'package:matrimony/view/widget/profile_custom/inner/family/family.dart';
import 'package:matrimony/view/widget/profile_custom/inner/preference/preference.dart';
import 'package:matrimony/view/widget/profile_custom/profile_custom.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  void initState() {
    // DeviceUtils.statusBarColor();
    super.initState();
  }

  //Image Design

  Widget imgSection({required String imgUrl, required List<Photo> photos}) {
    return Column(
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              width: 140,
              height: 140,
              decoration: const ShapeDecoration(
                color: Colors.white,
                shape: OvalBorder(
                  side: BorderSide(width: 1, color: AppColors.pink40),
                ),
              ),
              child: Container(
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        fit: BoxFit.cover, image: NetworkImage(imgUrl))),
              ),
            ),
            Positioned(
                bottom: -3,
                right: -3,
                child: Stack(
                  children: [
                    InkWell(
                      onTap: () {
                        Get.toNamed(AppRoute.imageView, arguments: photos);
                      },
                      child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: const BoxDecoration(boxShadow: [
                            BoxShadow(
                              color: AppColors.black20,
                              blurRadius: 18,
                              offset: Offset(0, 0),
                              spreadRadius: 0,
                            )
                          ], shape: BoxShape.circle, color: AppColors.pink100),
                          child:
                              const CustomImage(imageSrc: AppIcons.gallery2)),
                    ),
                    Positioned(
                      top: -7,
                      right: -3,
                      child: Container(
                          padding: const EdgeInsets.all(5),
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.white100),
                          child: CustomText(
                            fontSize: 8,
                            fontWeight: FontWeight.w500,
                            text: photos.length.toString(),
                          )),
                    )
                  ],
                ))
          ],
        ),
        InkWell(
          onTap: () {
            Get.toNamed(AppRoute.uploadPhoto, arguments: true);
          },
          child: const CustomText(
            top: 12,
            color: AppColors.pink100,
            fontWeight: FontWeight.w500,
            text: AppStaticStrings.updatePictures,
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        top: false,
        child: Scaffold(
          bottomNavigationBar: const NavBar(currentIndex: 3),
          body: Padding(
            padding: const EdgeInsets.only(top: 44, left: 20, right: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //App Bar
                const Padding(
                  padding: EdgeInsets.only(bottom: 24),
                  child: CustomText(
                    text: AppStaticStrings.myProfile,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                //Content
                GetBuilder<ProfileController>(builder: (controller) {
                  return controller.isLoading
                      ? const Expanded(
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        )
                      // ignore: unnecessary_null_comparison
                      : controller.attributes == null &&
                              controller.attributes.user == null
                          ? const Center(
                              child: CustomText(
                                text: AppStaticStrings.noData,
                              ),
                            )
                          : ProfileCustom(
                              //Image Section
                              imgSection: imgSection(
                                photos: controller.attributes.user!.photo!,
                                imgUrl: controller
                                    .attributes.user!.photo![0].publicFileUrl
                                    .toString(),
                              ),
                              aboutSection: AboutProfile(
                                data: controller.attributes.user,
                                myProfile: true,
                              ),
                              familySection: Family(
                                  myProfile: true,
                                  data: controller.attributes.user),
                              preferenceSection: Preference(
                                  myProfile: true,
                                  data: controller.attributes.user),
                            );
                })
              ],
            ),
          ),
        ));
  }
}
