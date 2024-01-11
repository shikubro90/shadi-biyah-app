import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matrimony/core/route/app_route.dart';
import 'package:matrimony/utils/app_colors.dart';
import 'package:matrimony/utils/app_static_strings.dart';
import 'package:matrimony/view/screens/messages/screen/message/inbox/all_inbox_repo/all_inbox_repo.dart';
import 'package:matrimony/view/screens/my_matches/my_match_controller/my_match_controller.dart';
import 'package:matrimony/view/screens/my_matches/my_match_model/my_match_model.dart';
import 'package:matrimony/view/widget/customText/custom_text.dart';
import 'package:matrimony/view/widget/request_card/request_card.dart';

class MatchesHome extends StatefulWidget {
  final List<Datum> data;
  const MatchesHome({super.key, required this.data});

  @override
  State<MatchesHome> createState() => _MatchesHomeState();
}

class _MatchesHomeState extends State<MatchesHome> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 44, left: 20, right: 20),
      child: GetBuilder<MyMatchController>(builder: (controller) {
        return RefreshIndicator(
          color: AppColors.pink100,
          onRefresh: () async {
            controller.refreshData();
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CustomText(
                bottom: 24,
                text: AppStaticStrings.myMatches,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),

              //User profile list of Matches
              Expanded(
                  child: ListView.builder(
                physics: const AlwaysScrollableScrollPhysics(),
                controller: controller.scrollController,
                itemCount: controller.dataLoading
                    ? controller.attributes.length + 1
                    : controller.attributes.length,
                itemBuilder: (context, index) {
                  if (index < controller.attributes.length) {
                    var value = controller.attributes[index].participants![0];
                    return GestureDetector(
                      onTap: () {
                        Get.toNamed(AppRoute.profileDetails,
                            arguments:
                                controller.attributes[index].participants![0]);
                      },
                      child: RequestCard(
                          button0Ontap: () async {
                            String getChatID = await AllInboxRepo.createChat(
                              partnerID: value.id!,
                            );
                            debugPrint("Chat Id Profile Screen : $getChatID");
                            Get.toNamed(AppRoute.inbox, arguments: [
                              value.name.toString(),
                              value.photo![0].publicFileUrl,
                              value.id
                            ], parameters: {
                              "chatId": getChatID
                            });
                          },
                          name: value.name.toString(),
                          title: "${value.occupation} ${value.age}",
                          subTitle: "${value.country}",
                          proPic: value.photo![0].publicFileUrl.toString()),
                    );
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              )),
            ],
          ),
        );
      }),
    );
  }
}
