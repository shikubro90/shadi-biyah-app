import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matrimony/core/route/app_route.dart';
import 'package:matrimony/utils/app_colors.dart';
import 'package:matrimony/utils/app_static_strings.dart';
import 'package:matrimony/view/screens/short_listed_profile/short_listed_profile_controller/short_listed_profile_controller.dart';
import 'package:matrimony/view/widget/all_multiple_used_repos/add_match_request_repo/add_match_request_repo.dart';
import 'package:matrimony/view/widget/customText/custom_text.dart';
import 'package:matrimony/view/widget/custom_appbar/custom_appbar.dart';
import 'package:matrimony/view/widget/request_card/request_card.dart';

class ShortListedProfile extends StatefulWidget {
  const ShortListedProfile({super.key});

  @override
  State<ShortListedProfile> createState() => _ShortListedProfileState();
}

class _ShortListedProfileState extends State<ShortListedProfile> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        appBar: const CustomAppBar(
          title: AppStaticStrings.shortlistedProfiles,
        ),
        body: GetBuilder<ShortListProfileController>(builder: (controller) {
          return controller.isLoading && controller.dataLoading == false
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : controller.attributes.isEmpty
                  ? const Center(
                      child: CustomText(
                        text: AppStaticStrings.noShortlistedProfiles,
                      ),
                    )
                  : RefreshIndicator(
                      color: AppColors.pink100,
                      onRefresh: () async {
                        controller.attributes.clear();
                        controller.pageNum = 1;
                        controller.shortListedProfile();
                      },
                      child: Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: ListView.builder(
                            controller: controller.scrollController,
                            itemCount: controller.dataLoading
                                ? controller.attributes.length + 1
                                : controller.attributes.length,
                            itemBuilder: (context, index) {
                              if (index < controller.attributes.length) {
                                return GestureDetector(
                                  onTap: () {
                                    Get.toNamed(AppRoute.profileDetails,
                                        arguments: controller
                                            .attributes[index].profileId);
                                  },
                                  child: RequestCard(
                                      button0Ontap: () {
                                        AddMatchRequest.matchReq(
                                            context: context,
                                            id: controller
                                                .attributes[index].profileId!.id
                                                .toString());
                                      },
                                      button0Title:
                                          AppStaticStrings.matchRequest,
                                      name: controller
                                          .attributes[index].profileId!.name
                                          .toString(),
                                      title:
                                          "${controller.attributes[index].profileId!.occupation}  ${controller.attributes[index].profileId!.age}",
                                      subTitle:
                                          "${controller.attributes[index].profileId!.country}",
                                      proPic: controller.attributes[index]
                                          .profileId!.photo![0].publicFileUrl
                                          .toString()),
                                );
                              } else {
                                return const Center(
                                    child: CircularProgressIndicator());
                              }
                            },
                          )),
                    );
        }),
      ),
    );
  }
}
