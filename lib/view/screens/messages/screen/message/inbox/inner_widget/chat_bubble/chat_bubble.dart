import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:matrimony/utils/app_colors.dart';
import 'package:matrimony/view/screens/messages/screen/message/inbox/inbox_controller.dart/inbox_controller.dart';
import 'package:matrimony/view/widget/customText/custom_text.dart';
import 'package:matrimony/view/widget/messeging_feature/application/application.dart';
import 'package:matrimony/view/widget/messeging_feature/audio_design.dart';
import 'package:matrimony/view/widget/messeging_feature/video_player/video_player.dart';

class ChatBubbleMessage extends StatefulWidget {
  final bool isEmoji;
  final String partnerImg;
  final String myImg;

  final VoidCallback onpress;

  const ChatBubbleMessage({
    super.key,
    required this.onpress,
    this.isEmoji = false,
    required this.partnerImg,
    required this.myImg,
  });

  @override
  State<ChatBubbleMessage> createState() => _ChatBubbleMessageState();
}

class _ChatBubbleMessageState extends State<ChatBubbleMessage> {
  @override
  void dispose() {
    // voiceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GetBuilder<InboxController>(builder: (controller) {
        return RefreshIndicator(
          onRefresh: () async {},
          child: ListView.builder(
              reverse: true,
              controller: controller.scrollController,
              itemCount: controller.dataLoading
                  ? controller.inboxChat.length + 1
                  : controller.inboxChat.length,
              itemBuilder: (context, index) {
                if (index < controller.inboxChat.length) {
                  return Column(
                    crossAxisAlignment:
                        controller.inboxChat[index].sender == controller.myID
                            ? CrossAxisAlignment.end
                            : CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 15),
                        child: Row(
                          mainAxisAlignment:
                              controller.inboxChat[index].sender ==
                                      controller.myID
                                  ? MainAxisAlignment.end
                                  : MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            //Partner profile
                            if (controller.inboxChat[index].sender !=
                                controller.myID)
                              Container(
                                  height: 44,
                                  width: 44,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                          fit: BoxFit.fill,
                                          image: CachedNetworkImageProvider(
                                              widget.partnerImg)))),
                            const SizedBox(
                              width: 8,
                            ),

                            //Image
                            if (controller
                                    .inboxChat[index].content!.messageType ==
                                MessageType.img)
                              Container(
                                  height: 260.h,
                                  width: 260.w,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      image: DecorationImage(
                                          fit: BoxFit.contain,
                                          image: CachedNetworkImageProvider(
                                            controller.inboxChat[index].content!
                                                .message!,
                                          )))),

                            //Message
                            if (controller
                                    .inboxChat[index].content!.messageType ==
                                MessageType.text)
                              Column(
                                crossAxisAlignment:
                                    // ignore: unrelated_type_equality_checks
                                    controller.inboxChat[index].sender ==
                                            controller.myID
                                        ? CrossAxisAlignment.end
                                        : CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  GestureDetector(
                                    onLongPress: () {
                                      widget.onpress();
                                    },
                                    child: Stack(
                                      clipBehavior: Clip.none,
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 16, vertical: 10),
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                color: AppColors.black5,
                                                width: 1),
                                            color: controller.inboxChat[index]
                                                        .sender ==
                                                    controller.myID
                                                ? AppColors.pink60
                                                : AppColors.white100,
                                            borderRadius: BorderRadius.only(
                                              topLeft: controller
                                                          .inboxChat[index]
                                                          .sender! ==
                                                      controller.myID
                                                  ? const Radius.circular(8)
                                                  : const Radius.circular(0),
                                              bottomLeft:
                                                  const Radius.circular(8),
                                              bottomRight:
                                                  const Radius.circular(8),
                                              topRight: controller
                                                          .inboxChat[index]
                                                          .sender! !=
                                                      controller.myID
                                                  ? const Radius.circular(8)
                                                  : const Radius.circular(0),
                                            ),
                                          ),
                                          child: CustomText(
                                            textAlign: TextAlign.left,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                            text: controller.inboxChat[index]
                                                .content!.message!,
                                            color: controller.inboxChat[index]
                                                        .sender! ==
                                                    controller.myID
                                                ? AppColors.white100
                                                : AppColors.black100,
                                          ),
                                        ),
                                        // if (widget.isEmoji &&
                                        //     widget.index == widget.messageIndex)
                                        //   widget.isMe
                                        //       ? const Positioned(
                                        //           bottom: -30, right: 0, child: EmojiDesign())
                                        //       : const Positioned(
                                        //           bottom: -30, left: 0, child: EmojiDesign())
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            const SizedBox(
                              width: 8,
                            ),

                            //Audio
                            if (controller
                                    .inboxChat[index].content!.messageType ==
                                MessageType.audio)
                              MyAudioPlayer(
                                message: controller
                                    .inboxChat[index].content!.message!,
                                isCurrentUser:
                                    controller.inboxChat[index].sender ==
                                        controller.myID,
                                index: index,
                              ),

                            //Video
                            if (controller
                                    .inboxChat[index].content!.messageType ==
                                MessageType.video)
                              Padding(
                                padding: EdgeInsets.only(
                                    right: controller.inboxChat[index].sender ==
                                            controller.myID
                                        ? 15.w
                                        : 0),
                                child: MyVideoPlayer(
                                  videoUrl: controller
                                      .inboxChat[index].content!.message!,
                                ),
                              ),

                            //Application
                            if (controller
                                    .inboxChat[index].content!.messageType ==
                                MessageType.application)
                              MyApplication(
                                url: controller
                                    .inboxChat[index].content!.message!,
                              ),

                            //My Profile Info
                            if (controller.inboxChat[index].sender ==
                                controller.myID)
                              Container(
                                  height: 44,
                                  width: 44,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                          fit: BoxFit.fill,
                                          image: CachedNetworkImageProvider(
                                              widget.myImg)))),
                          ],
                        ),
                      ),
                    ],
                  );
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              }),
        );
      }),
    );
  }
}

// class EmojiDesign extends StatelessWidget {
//   const EmojiDesign({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 18),
//       decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(8), color: AppColors.black80),
//       child: const Row(
//         children: [
//           CustomImage(
//               size: 18, imageType: ImageType.png, imageSrc: AppIcons.heart),
//           CustomImage(
//               size: 18, imageType: ImageType.png, imageSrc: AppIcons.wow),
//           CustomImage(
//               size: 18, imageType: ImageType.png, imageSrc: AppIcons.love),
//           CustomImage(
//               size: 18, imageType: ImageType.png, imageSrc: AppIcons.senti),
//           CustomImage(
//               size: 18, imageType: ImageType.png, imageSrc: AppIcons.sad),
//           CustomImage(
//               size: 18, imageType: ImageType.png, imageSrc: AppIcons.angry),
//         ],
//       ),
//     );
//   }
// }
