import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matrimony/core/route/app_route.dart';
import 'package:matrimony/utils/app_colors.dart';
import 'package:matrimony/utils/app_icons.dart';
import 'package:matrimony/view/screens/home/not_interested_repo/not_interested_repo.dart';
import 'package:matrimony/view/screens/home/add_shortlist_repo/add_shortlist_repo.dart';
import 'package:matrimony/view/widget/all_multiple_used_repos/add_match_request_repo/add_match_request_repo.dart';
import 'package:matrimony/view/widget/customText/custom_text.dart';
import 'package:matrimony/view/widget/custom_img/custom_img.dart';

class CardDesign extends StatefulWidget {
  const CardDesign(
      {super.key,
      required this.name,
      required this.title,
      required this.subTitle,
      required this.isPremium,
      this.imgHeight = 190,
      this.isProfileDetails = false,
      this.ontapGallry,
      required this.photos,
      required this.userID});

  final String name;
  final String userID;

  final String title;
  final String subTitle;
  final bool isPremium;
  final bool isProfileDetails;
  final VoidCallback? ontapGallry;
  final List<dynamic> photos;
  final double imgHeight;

  @override
  State<CardDesign> createState() => _CardDesignState();
}

class _CardDesignState extends State<CardDesign> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(boxShadow: const [
        BoxShadow(
          color: AppColors.black10,
          blurRadius: 18,
          offset: Offset(0, 0),
          spreadRadius: 0,
        )
      ], borderRadius: BorderRadius.circular(8), color: AppColors.white100),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              //Image
              SizedBox(
                  height: widget.imgHeight,
                  width: double.infinity,
                  child: Image.network(
                    widget.photos[0].publicFileUrl.toString(),
                    fit: BoxFit.cover,
                  )),
              //Premium Icon

              if (widget.isPremium)
                Positioned(
                  top: 10,
                  right: widget.isProfileDetails ? null : 10,
                  left: widget.isProfileDetails ? 10 : null,
                  child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle, color: AppColors.white100),
                      child: const CustomImage(imageSrc: AppIcons.premium)),
                ),

              //Gallery Icon

              if (widget.isProfileDetails)
                Positioned(
                  top: 10,
                  right: 10,
                  child: GestureDetector(
                    onTap: () {
                      widget.ontapGallry!();
                    },
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        InkWell(
                          onTap: () {
                            Get.toNamed(AppRoute.imageView,
                                arguments: widget.photos);
                          },
                          child: Container(
                              padding: const EdgeInsets.all(5),
                              decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppColors.pink100),
                              child: const CustomImage(
                                  imageSrc: AppIcons.gallery)),
                        ),
                        Positioned(
                          top: -5,
                          right: -5,
                          child: Container(
                              padding: const EdgeInsets.all(5),
                              decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppColors.white100),
                              child: CustomText(
                                fontSize: 8,
                                fontWeight: FontWeight.w500,
                                text: widget.photos.length.toString(),
                              )),
                        )
                      ],
                    ),
                  ),
                ),

              // Icons

              Positioned(
                  bottom: -15,
                  right: 10,
                  child: Row(
                    children: [
                      // Matche's Icon

                      InkWell(
                        onTap: () {
                          // Get.toNamed(AppRoute.matchesNavigate);

                          AddMatchRequest.matchReq(
                              id: widget.userID, context: context);
                        },
                        child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColors.pink100),
                            child: const CustomImage(
                                size: 16, imageSrc: AppIcons.heart2)),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      // ShortList Icon

                      InkWell(
                        onTap: () {
                          //Get.toNamed(AppRoute.shortListedProfile);

                          AddShortListRepo.addShortListRepo(id: widget.userID);
                        },
                        child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColors.pink100),
                            child: const CustomImage(
                                size: 16, imageSrc: AppIcons.star)),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      // Close Icon

                      InkWell(
                        onTap: () {
                          NotInterestedRepo.notInterestedRepo(
                              id: widget.userID);
                        },
                        child: Container(
                            padding: const EdgeInsets.all(7),
                            decoration: BoxDecoration(
                                border: Border.all(color: AppColors.pink100),
                                shape: BoxShape.circle,
                                color: AppColors.white100),
                            child: const CustomImage(
                                size: 16, imageSrc: AppIcons.x)),
                      ),
                    ],
                  ))
            ],
          ),

          //Giving an height

          if (!widget.isProfileDetails) const Expanded(child: SizedBox()),

          //Name ,Occopation , location
          Container(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //Name
                CustomText(
                  textAlign: TextAlign.left,
                  maxLines: 1,
                  fontWeight: FontWeight.w500,
                  color: AppColors.pink100,
                  text: widget.name,
                ),
                //Occopation
                CustomText(
                  top: 4,
                  bottom: 4,
                  textAlign: TextAlign.left,
                  maxLines: 1,
                  fontSize: 12,
                  color: AppColors.black40,
                  text: widget.title,
                ),
                //Location
                Row(
                  children: [
                    const CustomImage(imageSrc: AppIcons.location),
                    Expanded(
                      child: CustomText(
                        textAlign: TextAlign.left,
                        maxLines: 1,
                        left: 4,
                        fontSize: 12,
                        color: AppColors.black40,
                        text: widget.subTitle,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
