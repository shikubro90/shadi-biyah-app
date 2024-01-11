import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matrimony/core/global/api_response_model.dart';
import 'package:matrimony/core/helper/sharedpreference_helper.dart';
import 'package:matrimony/utils/app_utils.dart';
import 'package:matrimony/view/screens/my_matches/my_match_model/my_match_model.dart';
import 'package:matrimony/view/screens/my_matches/my_match_repo/my_match_repo.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyMatchController extends GetxController with GetxServiceMixin {
  MyMatchRepo myMatchRepo = MyMatchRepo();

  MyMatchModel myMatchModel = MyMatchModel();
  bool isLoading = false;

  List<Datum> attributes = [];

  ScrollController scrollController = ScrollController();
  bool dataLoading = false;

  int pageNum = 1;

  Future<void> addScrollListener() async {
    if (dataLoading) return;

    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      dataLoading = true;
      update();

      pageNum = pageNum + 1;
      await myMatch();

      dataLoading = false;
      update();
    }
  }

  Future<void> myMatch() async {
    isLoading = true;
    update();

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? myId = prefs.getString(SharedPreferenceHelper.userIdKey);

    ApiResponseModel responseModel =
        await myMatchRepo.myMatchRepo(pageNum: pageNum.toString());

    if (responseModel.statusCode == 200) {
      myMatchModel =
          MyMatchModel.fromJson(jsonDecode(responseModel.responseJson));

      List<Datum>? rawData = myMatchModel.data!.attributes!.data;

      if (rawData != null) {
        // Filter out data where your ID is in the participants' IDs
        List<Participant> otherParticipants = rawData
            .expand((datum) => datum.participants!)
            .where((participant) => participant.id != myId)
            .toList();

        // Create new Datum objects with the filtered participants list
        List<Datum> otherData = otherParticipants
            .map((participant) => Datum(
                  participants: [participant],
                  // You can copy other attributes from the original Datum if needed
                ))
            .toList();

        attributes = otherData; // Update the attributes list

        update();
      }
    } else {
      TostMessage.toastMessage(message: responseModel.message);
    }

    isLoading = false;
    update();
  }

  refreshData() {
    pageNum = 1;
    attributes = [];
    myMatch();
  }

  @override
  void onInit() {
    scrollController.addListener(addScrollListener);
    myMatch();
    super.onInit();
  }
}
