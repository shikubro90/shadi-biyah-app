import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matrimony/core/global/api_response_model.dart';
import 'package:matrimony/core/helper/sharedpreference_helper.dart';
import 'package:matrimony/core/service/socket_service.dart';
import 'package:matrimony/utils/app_utils.dart';
import 'package:matrimony/view/screens/messages/message_model/message_model.dart';
import 'package:matrimony/view/screens/messages/message_repo/message_repo.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MessageController extends GetxController {
  MessageRepo messageRepo = MessageRepo();

  MessageModel messageModel = MessageModel();
  bool isLoading = false;
  bool payment = false;

  List<Datum> msgList = [];

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
      await myMsg();

      dataLoading = false;
      update();
    }
  }

  Future<void> myMsg() async {
    isLoading = true;
    paymentInfo();
    update();
    try {
      ApiResponseModel apiResponseModel = await messageRepo.messageRepo();

      if (apiResponseModel.statusCode == 200) {
        debugPrint("========= MsgList  : ${apiResponseModel.responseJson}");
        messageModel = messageModelFromJson(apiResponseModel.responseJson);

        List<Datum> rawData = messageModel.data ?? [];

        msgList.addAll(rawData);
        debugPrint("========= MsgList Length : ${msgList.length}");
        update();
      } else {
        debugPrint(apiResponseModel.message);
        TostMessage.toastMessage(message: apiResponseModel.message);
      }
      isLoading = false;

      update();
    } catch (e) {
      TostMessage.toastMessage(message: e.toString());
      isLoading = false;
      update();
    }
  }

  Future<bool> paymentInfo() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final bool? isPayment = prefs.getBool(SharedPreferenceHelper.isPayment);
    payment = isPayment!;
    update();
    return isPayment;
  }

  refreshData() {
    pageNum = 1;
    msgList = [];
    myMsg();
  }

  listenSocketNewChat() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    String? myID = prefs.getString(SharedPreferenceHelper.userIdKey);

    print("My ID============$myID");

    SocketApi.socket.on("updated-chat::$myID", (data) {
      debugPrint("-------->  New Chat response : $data");
      Datum demodata = Datum.fromJson(data);

      debugPrint("New Chat response : ${demodata.chat!.participants![0].id}");

      for (var element in msgList) {
        if (element.chat!.id == demodata.chat!.id) {
          msgList.remove(element);
          msgList.insert(0, demodata);
          print("${element.chat!.id}========True========${demodata.chat!.id}");

          break;
        } else if (!msgList.contains(demodata)) {
          msgList.insert(0, demodata);
          print("${element.chat!.id}========False========${demodata.chat!.id}");
          break;
        }
      }
      update();
    });
  }

  socketOff() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? myID = prefs.getString(SharedPreferenceHelper.userIdKey);
    SocketApi.socket.off("updated-chat::$myID");
    print("========= Dispose socket $myID");
  }

  @override
  void onInit() {
    scrollController.addListener(addScrollListener);
    listenSocketNewChat();
    myMsg();
    super.onInit();
  }
}
