import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matrimony/core/global/status.dart';
import 'package:matrimony/core/route/app_route.dart';
import 'package:matrimony/utils/app_colors.dart';
import 'package:matrimony/utils/app_static_strings.dart';
import 'package:matrimony/view/screens/send_request/send_reminder_repo/send_reminder_repo.dart';
import 'package:matrimony/view/screens/send_request/send_request_controller/send_request_controller.dart';
import 'package:matrimony/view/widget/all_multiple_used_repos/accept_reject_match_repo/accept_reject_match_repo.dart';
import 'package:matrimony/view/widget/customText/custom_text.dart';
import 'package:matrimony/view/widget/custom_appbar/custom_appbar.dart';
import 'package:matrimony/view/widget/request_card/request_card.dart';

class SentRequest extends StatefulWidget {
  const SentRequest({super.key});

  @override
  State<SentRequest> createState() => _SentRequestState();
}

class _SentRequestState extends State<SentRequest> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        appBar: const CustomAppBar(
          title: AppStaticStrings.sentRequest,
        ),
        body: GetBuilder<SendMatchReqController>(builder: (controller) {
          return controller.isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : controller.data.isEmpty
                  ? const Center(
                      child: CustomText(
                        text: AppStaticStrings.noSentRequest,
                      ),
                    )
                  : RefreshIndicator(
                      color: AppColors.pink100,
                      onRefresh: () async {
                        controller.refreshData();
                      },
                      child: Padding(
                          padding: const EdgeInsets.only(
                              top: 0, left: 20, right: 20),
                          child: ListView.builder(
                            physics: const AlwaysScrollableScrollPhysics(),
                            itemCount: controller.dataLoading
                                ? controller.data.length + 1
                                : controller.data.length,
                            itemBuilder: (context, index) {
                              String userId =
                                  controller.data[index].id!.toString();
                              if (index < controller.data.length) {
                                int? count = controller.data[index].count;

                                return GestureDetector(
                                  onTap: () {
                                    Get.toNamed(AppRoute.profileDetails,
                                        arguments: controller
                                            .data[index].participants![0]);
                                  },
                                  child: RequestCard(
                                      isTwoButton: true,
                                      button1BgColor: count == 0
                                          ? AppColors.pink60
                                          : AppColors.pink100,
                                      button1Ontap: () {
                                        setState(() {
                                          SendReminderRepo.sendReminderRepo(
                                              userId: userId);
                                        });
                                      },
                                      button2Ontap: () {
                                        AcceptRejectReqRepo.acceptMatchReqRepo(
                                            id: userId,
                                            status: Status.rejected);
                                      },
                                      button1Title: AppStaticStrings.reminder,
                                      button2Title: AppStaticStrings.decline,
                                      name: controller
                                          .data[index].participants![0].name
                                          .toString(),
                                      title:
                                          "${controller.data[index].participants![0].occupation} ${controller.data[index].participants![0].age}",
                                      subTitle:
                                          "${controller.data[index].participants![0].country} ${controller.data[index].participants![0].city}",
                                      proPic: controller
                                          .data[index]
                                          .participants![0]
                                          .photo![0]
                                          .publicFileUrl
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
