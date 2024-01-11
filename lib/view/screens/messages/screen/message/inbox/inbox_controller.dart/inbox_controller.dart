import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:matrimony/core/global/api_response_model.dart';
import 'package:matrimony/core/helper/sharedpreference_helper.dart';
import 'package:matrimony/core/service/socket_service.dart';
import 'package:matrimony/utils/app_utils.dart';
import 'package:matrimony/view/screens/messages/message_controller/message_controller.dart';
import 'package:matrimony/view/screens/messages/screen/message/inbox/all_inbox_repo/all_inbox_repo.dart';
import 'package:matrimony/view/screens/messages/screen/message/inbox/inbox_model/inbox_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InboxController extends GetxController {
  //Pick Image

  final picker = ImagePicker();
  File? pickedImg;
  String pickedImgName = "";
  File? pickedFile;
  String pickedFileName = "";

  //Select image From Camera

  void openCamera() async {
    final pickedFile = await ImagePicker()
        .pickImage(source: ImageSource.camera, imageQuality: 50);

    if (pickedFile != null) {
      pickedImg = File(pickedFile.path);
      pickedImgName = pickedFile.name;

      update();
    }
  }

//Pick File and Select
  void openFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      pickedFile = File(result.files.single.path!);
      pickedFileName = result.files.single.name;

      print("Picked File =============$pickedFile");
      update();
    }
  }

  //Select image From Gallery
  // void openGallery() async {
  //   final pickedFile = await ImagePicker()
  //       .pickImage(source: ImageSource.gallery, imageQuality: 50);

  //   if (pickedFile != null) {
  //     pickedImg = File(pickedFile.path);
  //     update();
  //   }
  // }

  clearImgFile() {
    pickedFile = null;
    pickedImg = null;
    update();
  }

  //Pagenation
  ScrollController scrollController = ScrollController();
  int pageNum = 1;
  bool dataLoading = false;

  Future<void> addScrollListener() async {
    if (dataLoading) return;

    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      dataLoading = true;
      update();

      pageNum = pageNum + 1;
      await getInboxChatList();

      dataLoading = false;
      update();
    }
  }

//Get the Chat ID
  String chatID = "";
  bool chatIDLoading = false;
  bool isSending = false;

  getChatID({
    required String partnerID,
  }) async {
    chatIDLoading = true;
    update();
    String getChatID = await AllInboxRepo.createChat(
      partnerID: partnerID,
    );

    chatID = getChatID;
    chatIDLoading = false;
    getInboxChatList();
    update();
  }

//Send Message

  void scrollToBottom() {
    scrollController.animateTo(
      scrollController.position.minScrollExtent,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  TextEditingController sendMsgController = TextEditingController();
  MessageController messageController = Get.find<MessageController>();

  sendMsg(String receiver) async {
    isSending = true;
    update();
    if (sendMsgController.text.isNotEmpty ||
        pickedImg != null && pickedImg!.existsSync() ||
        pickedFile != null && pickedFile!.existsSync()) {
      StreamedResponse response = await AllInboxRepo.addMessage(
          chatID: chatID,
          msg: sendMsgController.text,
          file: pickedImg ?? pickedFile,
          receiver: receiver);

      String getMsg = await response.stream.bytesToString();

      Map<String, dynamic> decodeMSG = jsonDecode(getMsg);

      if (response.statusCode == 201) {
        //Refresh Data
        refreshGetInboxChatLis();

        //Clear image and text
        sendMsgController.clear();
        clearImgFile();

        if (pickedImg != null && pickedImg!.existsSync()) {
          await pickedImg!.delete();
        }

        //   messageController.refreshData();
      } else {
        TostMessage.toastMessage(message: decodeMSG["message"]);
        sendMsgController.clear();
      }
      isSending = false;
      update();
    }
  }

  //Get Inbox Chat List
  InboxModel inboxModel = InboxModel();
  List<Datum> inboxChat = [];

  getInboxChatList() async {
    ApiResponseModel inboxChatResponse = await AllInboxRepo.inboxChatListRepo(
        chatID: chatID, pageNum: pageNum.toString());

    if (inboxChatResponse.statusCode == 200) {
      inboxModel =
          InboxModel.fromJson(jsonDecode(inboxChatResponse.responseJson));

      List<Datum>? rawData = inboxModel.data!.attributes!.data;

      if (rawData != null) {
        print("RawData===========${rawData}");
        inboxChat.addAll(rawData);

        print("InboxChat===========${inboxChat}");

        update();
      }
    }
  }

  ///  Listen New message Socket

  listenSocketNewMessage(String chatId) {
    SocketApi.socket.on("new-message::$chatId", (data) {
      Datum demodata = Datum.fromJson(data);

      //inboxChat.add(demodata);

      inboxChat.insert(0, demodata);

      update();
      debugPrint("New message response : $data");
    });
  }

  disposeListen(String chatId) {
    SocketApi.socket.off("new-message::$chatID");
  }

//New Inbox Msg

  //Refresh Data and get latest value
  refreshGetInboxChatLis() {
    pageNum = 1;
    inboxChat = [];
    scrollToBottom();
    getInboxChatList();
  }

  //Save my ID
  String myID = "";
  getmyID() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? getMyID = prefs.getString(SharedPreferenceHelper.userIdKey);
    myID = getMyID!;
  }

  @override
  void onInit() {
    getmyID();
    getInboxChatList();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      scrollToBottom();
    });
    scrollController.addListener(addScrollListener);
    super.onInit();
  }
}

class MessageType {
  static const String img = "image";
  static const String text = "text";
  static const String video = "video";
  static const String audio = "audio";
  static const String application = "application";
  static const String unknown = "unknown";
  static const String file = "File";
}
