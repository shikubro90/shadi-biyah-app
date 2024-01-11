import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:matrimony/utils/app_colors.dart';
import 'package:matrimony/utils/app_static_strings.dart';
import 'package:matrimony/view/screens/messages/delete_message_repo/delete_message_repo.dart';
import 'package:matrimony/view/widget/all_multiple_used_repos/block_profile_repo/block_profile_repo.dart';
import 'package:matrimony/view/widget/customText/custom_text.dart';
import 'package:matrimony/view/widget/pop_up/all_pop_up.dart';

enum SampleItem {
  itemOne,
  itemTwo,
  itemThree,
  itemfour,
}

class ChatAppBar extends StatefulWidget {
  final String partnerImg;
  final String partnerName;
  final String partnerId;
  final String chatId;

  const ChatAppBar(
      {super.key,
      required this.partnerImg,
      required this.partnerName,
      required this.partnerId,
      required this.chatId});

  @override
  State<ChatAppBar> createState() => _ChatAppBarState();
}

class _ChatAppBarState extends State<ChatAppBar> {
  int selectedReportValue = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 15, left: 10, right: 10),
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.only(bottom: 5, top: 24),
      alignment: Alignment.centerLeft,
      decoration: const BoxDecoration(
        color: AppColors.pink100,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                //Back Button
                ClipOval(
                  child: Material(
                    color: Colors.transparent,
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: IconButton(
                        icon: const Icon(
                          Icons.arrow_back_ios_rounded,
                          color: AppColors.white100,
                        ),
                        onPressed: () {
                          Get.back();
                        },
                      ),
                    ),
                  ),
                ),

                //Profile Image
                Padding(
                  padding: const EdgeInsets.only(right: 14),
                  child: Container(
                      height: 44,
                      width: 44,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(widget.partnerImg)))),
                ),
                //Name
                CustomText(
                  color: AppColors.white100,
                  fontWeight: FontWeight.w500,
                  text: widget.partnerName,
                  fontSize: 12,
                  maxLines: 2,
                ),
              ],
            ),

            //Pop up Items

            PopupMenuButton(
              color: AppColors.white100,
              icon: const Icon(
                Icons.more_vert_outlined,
                color: AppColors.white100,
              ),
              itemBuilder: (context) => [
                //View Profile
                // PopupMenuItem<SampleItem>(
                //   value: SampleItem.itemOne,
                //   child: GestureDetector(
                //       onTap: () {
                //         navigator!.pop();
                //         Get.toNamed(AppRoute.profileDetails);
                //       },
                //       child: const CustomText(
                //         fontSize: 14,
                //         text: AppStaticStrings.viewProfile,
                //       )),
                // ),
                //Report Profile

                PopupMenuItem<SampleItem>(
                  value: SampleItem.itemTwo,
                  child: GestureDetector(
                      onTap: () {
                        navigator!.pop();

                        AllPopUp.showReportDiolog(
                            context: context,
                            selectedReport: selectedReportValue,
                            id: widget.partnerId);
                      },
                      child: const CustomText(
                        fontSize: 14,
                        text: AppStaticStrings.reportProfile,
                      )),
                ),

                //Blocked Profile

                PopupMenuItem<SampleItem>(
                  value: SampleItem.itemThree,
                  child: GestureDetector(
                      onTap: () {
                        navigator!.pop();
                        AllPopUp.showDialogWith2Button(
                            button1ontap: () {
                              BlockProfileRepo.blockProfile(
                                  id: widget.partnerId);
                            },
                            button2ontap: () {},
                            context: context,
                            title:
                                AppStaticStrings.youSureWanttoBlockthisProfile,
                            button1Title: AppStaticStrings.yes,
                            button2Title: AppStaticStrings.no);
                      },
                      child: const CustomText(
                        fontSize: 14,
                        text: AppStaticStrings.blockedProfiles,
                      )),
                ),

                //Delete Conversation

                PopupMenuItem<SampleItem>(
                  value: SampleItem.itemfour,
                  child: GestureDetector(
                      onTap: () {
                        navigator!.pop();

                        AllPopUp.showDialogWith2Button(
                            button1ontap: () {
                              DeleteChatRepo.deleteChat(chatId: widget.chatId)
                                  .then((value) => navigator!.pop());
                            },
                            button2ontap: () {},
                            context: context,
                            title: AppStaticStrings
                                .yousureWanttoDeleteConversation,
                            button1Title: AppStaticStrings.yes,
                            button2Title: AppStaticStrings.no);
                      },
                      child: const CustomText(
                        fontSize: 14,
                        text: AppStaticStrings.deleteConversation,
                      )),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
