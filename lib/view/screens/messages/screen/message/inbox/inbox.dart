import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matrimony/core/helper/sharedpreference_helper.dart';
import 'package:matrimony/utils/app_colors.dart';
import 'package:matrimony/view/screens/messages/screen/message/inbox/inbox_controller.dart/inbox_controller.dart';
import 'package:matrimony/view/screens/messages/screen/message/inbox/inner_widget/chat_appbar/chat_appbar.dart';
import 'package:matrimony/view/screens/messages/screen/message/inbox/inner_widget/chat_bubble/chat_bubble.dart';
import 'package:matrimony/view/screens/messages/screen/message/inbox/inner_widget/chat_input_field/chat_input_field.dart';

import 'package:matrimony/view/screens/messages/screen/message/inbox/inner_widget/more_field/more_field.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Inbox extends StatefulWidget {
  const Inbox({super.key});

  @override
  State<Inbox> createState() => _InboxState();
}

class _InboxState extends State<Inbox> {
  bool isMuted = false;
  int currentIndex = 0;
  bool isInputField = true;

  String name = Get.arguments[0];
  String imgUrl = Get.arguments[1];
  String partnerID = Get.arguments[2];
  Map parmeter = Get.parameters;

  InboxController inboxController = Get.find<InboxController>();

  String? myImg = "";

  getMyImg() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      myImg = prefs.getString(SharedPreferenceHelper.myImgUrl);
    });

    print("img========$myImg");
  }

  @override
  void initState() {
    inboxController.getChatID(partnerID: partnerID);
    debugPrint("Chat Id ---------z.${parmeter["chatId"]}");
    inboxController.listenSocketNewMessage(parmeter["chatId"]);
    super.initState();

    getMyImg();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        top: false,
        child: Scaffold(

            //Chat Bottom Input Fields
            bottomNavigationBar:
                GetBuilder<InboxController>(builder: (controller) {
              return Container(
                color: AppColors.white100,
                child: isInputField
                    ? ChatInputField(
                        receiver: partnerID,
                      )
                    : const ChatMoreField(),
              );
            }),
            body: Column(
              children: [
                Expanded(
                  flex: 7,
                  child: Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height,
                    color: AppColors.pink100,
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          isInputField = true;
                        });
                      },
                      child: Column(
                        children: [
                          //App Bar
                          ChatAppBar(
                            partnerImg: imgUrl,
                            partnerName: name,
                            partnerId: partnerID,
                            chatId: parmeter["chatId"],
                          ),
                          //Chat Body
                          Expanded(
                            child: Container(
                                decoration: const BoxDecoration(
                                    color: AppColors.white100,
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(16),
                                        topRight: Radius.circular(16))),
                                child: ChatBubbleMessage(
                                  myImg: myImg!,
                                  partnerImg: imgUrl,
                                  isEmoji: !isInputField,
                                  onpress: () {
                                    setState(() {
                                      isInputField = !isInputField;
                                    });
                                  },
                                )),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            )));
  }
}
