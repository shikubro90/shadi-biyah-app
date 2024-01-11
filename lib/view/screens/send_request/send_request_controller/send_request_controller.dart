import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:matrimony/core/global/api_response_model.dart';
import 'package:matrimony/core/helper/sharedpreference_helper.dart';
import 'package:matrimony/utils/app_utils.dart';
import 'package:matrimony/view/screens/send_request/send_request_model/send_request_model.dart';
import 'package:matrimony/view/screens/send_request/send_request_repo/send_request_repo.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SendMatchReqController extends GetxController with GetxServiceMixin {
  SendReqRepo sendReqRepo = SendReqRepo(apiService: Get.find());

  bool isLoading = false;

  List<Datum> data = [];

  SendReqModel sendReqModel = SendReqModel();

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
      await sendReq();

      dataLoading = false;
      update();
    }
  }

  Future<void> sendReq() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? userIdKey = prefs.getString(SharedPreferenceHelper.userIdKey);

    isLoading = true;
    update();
    ApiResponseModel responseModel =
        await sendReqRepo.sendReqRepo(pageNum: pageNum.toString());

    if (responseModel.statusCode == 200) {
      data.clear();
      sendReqModel =
          SendReqModel.fromJson(jsonDecode(responseModel.responseJson));

      List<Datum>? rawData = sendReqModel.data?.attributes!.data;

      if (rawData != null) {
        //Filter the Participants. Only getting other user information

        List<Datum> otherParticipants = rawData.map((request) {
          List<Participant> filteredParticipants = request.participants!
              .where((participant) => participant.id != userIdKey)
              .toList();

          return Datum(
              participants: filteredParticipants,
              id: request.id,
              count: request.count);
        }).toList();

        data.addAll(otherParticipants);
      }
    } else {
      TostMessage.toastMessage(message: responseModel.message);
    }

    isLoading = false;
    update();
  }

  refreshData() {
    pageNum = 1;
    data.clear();
    sendReq();
  }

  @override
  void onInit() {
    scrollController.addListener(addScrollListener);
    sendReq();
    super.onInit();
  }
}
