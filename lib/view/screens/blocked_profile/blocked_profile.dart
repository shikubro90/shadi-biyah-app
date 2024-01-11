import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matrimony/core/route/app_route.dart';
import 'package:matrimony/utils/app_colors.dart';
import 'package:matrimony/utils/app_static_strings.dart';
import 'package:matrimony/view/screens/blocked_profile/blocked_profile_controller/blocked_profile_controller.dart';
import 'package:matrimony/view/screens/blocked_profile/unblock_profile_repo/unblock_profile_repo.dart';
import 'package:matrimony/view/widget/customText/custom_text.dart';
import 'package:matrimony/view/widget/custom_appbar/custom_appbar.dart';
import 'package:matrimony/view/widget/request_card/request_card.dart';

class BlockedProfile extends StatefulWidget {
  const BlockedProfile({super.key});

  @override
  State<BlockedProfile> createState() => _BlockedProfileState();
}

class _BlockedProfileState extends State<BlockedProfile> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        appBar: const CustomAppBar(
          title: AppStaticStrings.blockedProfiles,
        ),
        body: GetBuilder<BlockedProfileController>(builder: (controller) {
          return controller.isLoading && controller.dataLoading == false
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : controller.results.isEmpty
                  ? const Center(
                      child: CustomText(
                        text: AppStaticStrings.noBlockProfiles,
                      ),
                    )
                  : RefreshIndicator(
                      color: AppColors.pink100,
                      onRefresh: () async {
                        controller.pageNum = 1;
                        controller.results = [];
                        controller.blockedProfile();
                      },
                      child: Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: ListView.builder(
                            controller: controller.scrollController,
                            physics: const AlwaysScrollableScrollPhysics(),
                            itemCount: controller.dataLoading
                                ? controller.results.length + 1
                                : controller.results.length,
                            itemBuilder: (context, index) {
                              var data = controller.results[index].profileId;
                              if (index < controller.results.length) {
                                return GestureDetector(
                                  onTap: () {
                                    Get.toNamed(AppRoute.profileDetails,
                                        arguments: controller
                                            .results[index].profileId);
                                  },
                                  child: RequestCard(
                                      button0Ontap: () {
                                        UnBlockProfileRepo.unBlockProfile(
                                            id: controller.results[index].id
                                                .toString());

                                        // print(controller.results[index].id);
                                      },
                                      button0Title: AppStaticStrings.unblock,
                                      name: data!.name.toString(),
                                      title: "${data.occupation} ${data.age}",
                                      subTitle: "${data.country}",
                                      proPic: data.photo![0].publicFileUrl
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
