import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matrimony/core/global/status.dart';
import 'package:matrimony/core/route/app_route.dart';
import 'package:matrimony/utils/app_colors.dart';
import 'package:matrimony/utils/app_static_strings.dart';
import 'package:matrimony/view/screens/match_request/match_req_controller/match_req_controller.dart';
import 'package:matrimony/view/widget/all_multiple_used_repos/accept_reject_match_repo/accept_reject_match_repo.dart';
import 'package:matrimony/view/widget/customText/custom_text.dart';
import 'package:matrimony/view/widget/custom_appbar/custom_appbar.dart';
import 'package:matrimony/view/widget/request_card/request_card.dart';

class MatchRequest extends StatefulWidget {
  const MatchRequest({super.key});

  @override
  State<MatchRequest> createState() => _MatchRequestState();
}

class _MatchRequestState extends State<MatchRequest> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        appBar: const CustomAppBar(title: AppStaticStrings.matchRequest),
        body: GetBuilder<MatchReqController>(builder: (controller) {
          return controller.isLoading && controller.dataLoading == false
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : controller.attributes.isEmpty
                  ? const Center(
                      child: CustomText(
                        text: AppStaticStrings.noMatchRequest,
                      ),
                    )
                  : RefreshIndicator(
                      color: AppColors.pink100,
                      onRefresh: () async {
                        controller.attributes = [];
                        controller.pageNum = 1;
                        controller.matchReq();
                      },
                      child: Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: ListView.builder(
                            physics: const AlwaysScrollableScrollPhysics(),
                            controller: controller.scrollController,
                            itemCount: controller.dataLoading
                                ? controller.attributes.length + 1
                                : controller.attributes.length,
                            itemBuilder: (context, index) {
                              var data =
                                  controller.attributes[index].participants![0];
                              String id =
                                  controller.attributes[index].id.toString();

                              if (index < controller.attributes.length) {
                                return GestureDetector(
                                  onTap: () {
                                    Get.toNamed(AppRoute.profileDetails,
                                        arguments: controller.attributes[index]
                                            .participants![0]);
                                  },
                                  child: RequestCard(
                                      isTwoButton: true,
                                      button1Ontap: () {
                                        AcceptRejectReqRepo.acceptMatchReqRepo(
                                            status: Status.accepted, id: id);
                                      },
                                      button2Ontap: () {
                                        AcceptRejectReqRepo.acceptMatchReqRepo(
                                            status: Status.rejected, id: id);
                                      },
                                      name: data.name.toString(),
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
