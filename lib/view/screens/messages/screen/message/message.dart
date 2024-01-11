import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:matrimony/core/route/app_route.dart';
import 'package:matrimony/utils/app_colors.dart';
import 'package:matrimony/view/screens/messages/delete_message_repo/delete_message_repo.dart';
import 'package:matrimony/view/screens/messages/message_controller/message_controller.dart';
import 'package:matrimony/view/screens/messages/message_model/message_model.dart';
import 'package:matrimony/view/screens/messages/screen/message/inbox/inbox_controller.dart/inbox_controller.dart';
import 'package:matrimony/view/widget/customText/custom_text.dart';

class Message extends StatefulWidget {
  const Message({super.key});

  @override
  State<Message> createState() => _MessageState();
}

MessageController messageController = Get.find<MessageController>();

class _MessageState extends State<Message> {
  @override
  void initState() {
    messageController.listenSocketNewChat();
    super.initState();
  }

  @override
  void dispose() {
    messageController.socketOff();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: GetBuilder<MessageController>(builder: (controller) {
          return controller.isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : RefreshIndicator(
                  color: AppColors.pink100,
                  onRefresh: () async {
                    controller.refreshData();
                  },
                  child: ListView.builder(
                      itemCount: controller.dataLoading
                          ? controller.msgList.length + 1
                          : controller.msgList.length,
                      itemBuilder: (context, index) {
                        Participant data =
                            controller.msgList[index].chat!.participants![0];
                        Content content =
                            controller.msgList[index].message!.content!;
                        if (index < controller.msgList.length) {
                          return Slidable(
                            endActionPane: ActionPane(
                                motion: const ScrollMotion(),
                                children: [
                                  SlidableAction(
                                    flex: 2,
                                    onPressed: (context) {
                                      DeleteChatRepo.deleteChat(
                                          chatId: controller
                                              .msgList[index].chat!.id!);
                                    },
                                    backgroundColor:
                                        const Color.fromARGB(255, 207, 53, 53),
                                    foregroundColor: AppColors.white100,
                                    icon: Icons.delete,
                                    //  label: 'Delete',
                                  ),
                                ]),
                            child: GestureDetector(
                              onTap: () {
                                debugPrint(
                                    "id======${controller.msgList[index].chat!.participants![0].id}");
                                Get.toNamed(AppRoute.inbox, arguments: [
                                  data.name,
                                  data.photo![0].publicFileUrl,
                                  data.id
                                ], parameters: {
                                  "chatId": controller.msgList[index].chat!.id!
                                });
                              },
                              child: ChatCard(
                                  image: "${data.photo![0].publicFileUrl}",
                                  name: "${data.name}",
                                  lastMsg:
                                      content.messageType == MessageType.text
                                          ? "${content.message}"
                                          : MessageType.file),
                            ),
                          );
                        } else {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                      }),
                );
        }),
      ),
    );
  }
}

class ChatCard extends StatelessWidget {
  final String image;
  final String name;
  final String lastMsg;

  const ChatCard(
      {super.key,
      required this.image,
      required this.name,
      required this.lastMsg});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: AppColors.white100,
        boxShadow: const [
          BoxShadow(
            color: AppColors.black10,
            blurRadius: 18,
            offset: Offset(0, 0),
            spreadRadius: 0,
          )
        ],
      ),
      child: Row(
        children: [
          //Image
          Container(
            height: 42,
            width: 42,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                      image,
                    ))),
          ),
          const SizedBox(
            width: 8,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //Name

                CustomText(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  text: name,
                ),
                //Last Message

                CustomText(
                  //maxLines: 2,
                  fontSize: 12,
                  text: lastMsg,
                  color: AppColors.black40,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
