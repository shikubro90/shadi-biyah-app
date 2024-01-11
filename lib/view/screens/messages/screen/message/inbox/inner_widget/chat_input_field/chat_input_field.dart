import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:matrimony/utils/app_colors.dart';
import 'package:matrimony/utils/app_icons.dart';
import 'package:matrimony/utils/app_static_strings.dart';
import 'package:matrimony/view/screens/messages/screen/message/inbox/inbox_controller.dart/inbox_controller.dart';
import 'package:matrimony/view/widget/customText/custom_text.dart';
import 'package:matrimony/view/widget/custom_img/custom_img.dart';
import 'package:matrimony/view/widget/text_editingField/textediting_field.dart';
import 'package:flutter/foundation.dart' as foundation;

class ChatInputField extends StatefulWidget {
  const ChatInputField({
    super.key,
    required this.receiver,
  });
  final String receiver;
  @override
  State<ChatInputField> createState() => _ChatInputFieldState();
}

class _ChatInputFieldState extends State<ChatInputField> {
  //final TextEditingController _controller = TextEditingController();
  bool emojiShowing = false;

  _onBackspacePressed(TextEditingController controller) {
    controller
      ..text = controller.text.characters.toString()
      ..selection = TextSelection.fromPosition(
          TextPosition(offset: controller.text.length));
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<InboxController>(builder: (controller) {
      return AnimatedPadding(
        padding: MediaQuery.of(context).viewInsets,
        duration: const Duration(milliseconds: 100),
        curve: Curves.decelerate,
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.white100),
            color: AppColors.white100,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 4, left: 20, right: 20),
                child: Row(
                  children: [
                    // Camera Icon
                    InkWell(
                      onTap: () {
                        controller.openCamera();
                      },
                      child: const Padding(
                        padding: EdgeInsets.only(right: 20),
                        child: CustomImage(imageSrc: AppIcons.camera),
                      ),
                    ),

                    // Attactment Icon

                    InkWell(
                      onTap: () {
                        controller.openFile();
                      },
                      child: const Padding(
                        padding: EdgeInsets.only(right: 20),
                        child: CustomImage(imageSrc: AppIcons.attachment),
                      ),
                    ),

                    // Microphone Icon

                    // const Padding(
                    //   padding: EdgeInsets.only(right: 12),
                    //   child: CustomImage(
                    //     imageSrc: AppIcons.microphone,
                    //     size: 22,
                    //   ),
                    // ),

                    // Text Field and Emoji Icon

                    controller.pickedImg == null &&
                            controller.pickedFile == null
                        ? Expanded(
                            child: CustomTextField(
                            onTapClick: () {
                              setState(() {
                                emojiShowing = false;
                              });
                            },
                            readOnly: emojiShowing ? true : false,
                            textEditingController: controller.sendMsgController,
                            hintText: AppStaticStrings.writeYourMessage,
                            suffixIcon: Padding(
                              padding: const EdgeInsets.all(12),
                              child: GestureDetector(
                                onTap: () async {
                                  FocusManager.instance.primaryFocus?.unfocus();

                                  Future.delayed(
                                      const Duration(milliseconds: 150), () {
                                    setState(() {
                                      emojiShowing = !emojiShowing;
                                    });
                                  });
                                },
                                child: const CustomImage(
                                  size: 8,
                                  imageType: ImageType.png,
                                  imageSrc: AppIcons.senti,
                                ),
                              ),
                            ),
                          ))
                        : Expanded(
                            child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 5.w),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.r),
                                border: Border.all(color: AppColors.black20)),
                            height: 48.h,
                            child: Row(children: [
                              const Icon(
                                Icons.file_copy,
                                color: AppColors.pink100,
                              ),
                              Expanded(
                                child: CustomText(
                                  text: controller.pickedFileName.isEmpty
                                      ? controller.pickedImgName
                                      : controller.pickedFileName,
                                ),
                              ),
                              IconButton(
                                  onPressed: () {
                                    controller.clearImgFile();
                                  },
                                  icon: const Icon(Icons.close))
                            ]),
                          )),

                    //Send Button

                    controller.chatIDLoading || controller.isSending
                        ? Container(
                            margin: const EdgeInsets.only(left: 16),
                            height: 20,
                            width: 20,
                            child: const CircularProgressIndicator(),
                          )
                        : Padding(
                            padding: const EdgeInsets.only(left: 16),
                            child: GestureDetector(
                              onTap: () {
                                controller.sendMsg(widget.receiver);
                              },
                              child: const CustomImage(imageSrc: AppIcons.send),
                            ),
                          ),
                  ],
                ),
              ),

              //All Emoji's
              Offstage(
                offstage: !emojiShowing,
                child: SizedBox(
                    height: 300,
                    child: EmojiPicker(
                      textEditingController: controller.sendMsgController,
                      onBackspacePressed:
                          _onBackspacePressed(controller.sendMsgController),
                      config: Config(
                        columns: 7,
                        emojiSizeMax: 32 *
                            (foundation.defaultTargetPlatform ==
                                    TargetPlatform.iOS
                                ? 1.30
                                : 1.0),
                        verticalSpacing: 0,
                        horizontalSpacing: 0,
                        gridPadding: EdgeInsets.zero,
                        initCategory: Category.RECENT,
                        bgColor: AppColors.black5,
                        indicatorColor: AppColors.pink60,
                        iconColor: AppColors.black40,
                        iconColorSelected: AppColors.pink60,
                        backspaceColor: AppColors.pink60,
                        skinToneDialogBgColor: Colors.white,
                        skinToneIndicatorColor: AppColors.green100,
                        enableSkinTones: true,
                        recentTabBehavior: RecentTabBehavior.RECENT,
                        recentsLimit: 28,
                        replaceEmojiOnLimitExceed: false,
                        noRecents: const Text(
                          'No Recents',
                          style: TextStyle(fontSize: 20, color: Colors.black26),
                          textAlign: TextAlign.center,
                        ),
                        loadingIndicator: const SizedBox.shrink(),
                        tabIndicatorAnimDuration: kTabScrollDuration,
                        categoryIcons: const CategoryIcons(),
                        buttonMode: ButtonMode.MATERIAL,
                        checkPlatformCompatibility: true,
                      ),
                    )),
              ),
            ],
          ),
        ),
      );
    });
  }
}
