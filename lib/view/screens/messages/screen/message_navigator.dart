import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matrimony/utils/app_static_strings.dart';
import 'package:matrimony/view/screens/messages/message_controller/message_controller.dart';
import 'package:matrimony/view/screens/messages/screen/lock_message/lock_message.dart';
import 'package:matrimony/view/screens/messages/screen/message/message.dart';
import 'package:matrimony/view/screens/messages/screen/no_msg_screen/no_msg_screen.dart';
import 'package:matrimony/view/widget/custom_appbar/custom_appbar.dart';
import 'package:matrimony/view/widget/nav_bar/nav_bar.dart';

class MessageNavigator extends StatefulWidget {
  const MessageNavigator({super.key});

  @override
  State<MessageNavigator> createState() => _MessageNavigatorState();
}

class _MessageNavigatorState extends State<MessageNavigator> {
  List<Widget> messageScreens = [
    const LockMessage(),
    const NoMessage(),
    const Message(),
  ];

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: AppStaticStrings.messages,
        isBackButton: false,
      ),
      bottomNavigationBar: const NavBar(currentIndex: 1),
      body: GetBuilder<MessageController>(builder: (controller) {
        if (controller.isLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          if (controller.payment == true && controller.msgList.isEmpty) {
            return messageScreens[1];
          } else if (controller.payment == false ||
              controller.msgList.isEmpty) {
            return messageScreens[0];
          } else {
            return messageScreens[2];
          }
        }
      }),
    );
  }
}
