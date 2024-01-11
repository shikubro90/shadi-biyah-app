import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matrimony/core/global/api_response_model.dart';
import 'package:matrimony/utils/app_utils.dart';
import 'package:matrimony/view/screens/match_request/match_req_model/match_req_model.dart';
import 'package:matrimony/view/screens/match_request/match_req_repo/match_req_repo.dart';

class MatchReqController extends GetxController with GetxServiceMixin {
  MatchReqRepo matchReqRepo = MatchReqRepo();

  MatchReqModel matchReqModel = MatchReqModel();
  bool isLoading = false;
  bool dataLoading = false;

  List<Datum> attributes = [];

  ScrollController scrollController = ScrollController();

  int pageNum = 1;

  Future<void> addScrollListener() async {
    if (dataLoading) return;

    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      dataLoading = true;
      update();

      pageNum = pageNum + 1;
      await matchReq();

      dataLoading = false;
      update();
    }
  }

  Future<void> matchReq() async {
    isLoading = true;
    update();
    ApiResponseModel responseModel =
        await matchReqRepo.matchReqRepo(pageNum: pageNum.toString());

    if (responseModel.statusCode == 200) {
      attributes.clear();
      matchReqModel =
          MatchReqModel.fromJson(jsonDecode(responseModel.responseJson));

      List<Datum>? rawData = matchReqModel.data!.attributes!.data;

      if (rawData != null) {
        //  results.addAll(rawData);

        attributes.addAll(rawData);
      }
    } else {
      TostMessage.toastMessage(message: responseModel.message);
    }

    isLoading = false;
    update();
  }

  @override
  void onInit() {
    matchReq();
    scrollController.addListener(addScrollListener);
    super.onInit();
  }
}
