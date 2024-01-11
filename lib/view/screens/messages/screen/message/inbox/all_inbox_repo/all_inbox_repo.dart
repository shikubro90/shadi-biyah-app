import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:http_parser/http_parser.dart';
import 'package:matrimony/core/global/api_response_method.dart';
import 'package:matrimony/core/global/api_response_model.dart';
import 'package:matrimony/core/global/api_url_container.dart';
import 'package:matrimony/core/helper/sharedpreference_helper.dart';
import 'package:matrimony/core/service/api_service.dart';
import 'package:mime/mime.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AllInboxRepo {
  static ApiService apiService = ApiService(sharedPreferences: Get.find());

  static Future<String> createChat({
    File? img,
    required String partnerID,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    // SocketService socketService = SocketService();

    String? senderID = prefs.getString(SharedPreferenceHelper.userIdKey);
    String url = "${ApiUrlContainer.baseURL}${ApiUrlContainer.createChat}";
    String responseMethod = ApiResponseMethod.postMethod;

    Map<String, List<String>> body = {
      "participants": [senderID!, partnerID]
    };

    print("MyID=====$senderID");

    print("Body===========$body");

    ApiResponseModel responseModel = await apiService
        .request(url, responseMethod, body, passHeader: true, isRawData: true);

    if (responseModel.statusCode == 201) {
      // Parse the JSON string
      Map<String, dynamic> response = json.decode(responseModel.responseJson);

      // Access the 'id' field
      String chatID = response['data']['attributes']['id'];

      print("ChatID===========$chatID");

      // SocketService socketService = SocketService();
      // socketService.joinRoom(chatID);

      // StreamedResponse streamedResponse =
      //     await addMessage(img: img, chatID: chatID, msg: msg);

      // inboxChatListRepo(chatID: chatID, pageNum: pageNum);

      // socketService.emitGetMessage(chatID);
      // socketService.onGetMessage();

      return chatID;
    } else {
      return "";
    }
  }

  static Future<StreamedResponse> addMessage({
    File? file,
    required String chatID,
    required String msg,
    required String receiver,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString(SharedPreferenceHelper.token);
    String? senderID = prefs.getString(SharedPreferenceHelper.userIdKey);

    var request = http.MultipartRequest(
      "POST",
      Uri.parse("${ApiUrlContainer.baseURL}${ApiUrlContainer.sendMsgInbox}"),
    );

    if (file != null && file.existsSync()) {
      var mimeType = lookupMimeType(file.path);

      print("Mime Type============>>>>>>>>$mimeType");
      var multipartImg = await http.MultipartFile.fromPath(
        'file',
        file.path,
        contentType: MediaType.parse(mimeType!),
      );
      request.files.add(multipartImg);
    }

    Map<String, dynamic> params = {
      "sender": senderID,
      "chat": chatID,
      "message": msg,
      "receiver": receiver
      // "replyTo":
      // "fileType"
    };

    print("Params==============$params");

    params.forEach((key, value) {
      request.fields[key] = value;
    });

    request.headers['Content-Type'] = 'multipart/form-data';
    request.headers['Authorization'] = "Bearer $token";

    // Send the request
    StreamedResponse response = await request.send();

    // if (img != null) {
    //   await img.delete();
    // }

    return response;
  }

  static Future<ApiResponseModel> inboxChatListRepo(
      {required String chatID, required String pageNum}) async {
    String url =
        "${ApiUrlContainer.baseURL}${ApiUrlContainer.inboxChat}$chatID&page=$pageNum";
    String responseMethod = ApiResponseMethod.getMethod;

    ApiResponseModel responseModel = await apiService.request(
      url,
      responseMethod,
      null,
      passHeader: true,
    );

    return responseModel;
  }
}
