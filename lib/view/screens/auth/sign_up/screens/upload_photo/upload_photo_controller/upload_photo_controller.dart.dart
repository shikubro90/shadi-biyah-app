import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:matrimony/core/global/api_url_container.dart';
import 'package:matrimony/core/helper/sharedpreference_helper.dart';
import 'package:matrimony/core/route/app_route.dart';
import 'package:matrimony/utils/app_static_strings.dart';
import 'package:matrimony/utils/app_utils.dart';
import 'package:matrimony/view/screens/auth/sign_up/screens/upload_photo/upload_photo_model/upload_photo_model.dart';
import 'package:matrimony/view/screens/profile/profile_controller/profile_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UploadImageController extends GetxController {
  ProfileController profileController = Get.find<ProfileController>();
  final picker = ImagePicker();
  File? proImage;
  final imagePicker = ImagePicker();
  List<File> selectedImagesMulti = [];
  //Select image From Gallery
  void openGallery() async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      proImage = File(pickedFile.path);
      update();
    }
  }

  void pickMultiImage() async {
    selectedImagesMulti.clear();
    update();

    final pickedFile = await picker.pickMultiImage(
      imageQuality: 80, // To set quality of images
    );

    List<XFile> xfilePick = pickedFile;

    if (xfilePick.length > 5) {
      TostMessage.toastMessage(message: AppStaticStrings.pickOnly5Images);
      return;
    } else if (xfilePick.isNotEmpty) {
      for (var i = 0; i < xfilePick.length; i++) {
        if (selectedImagesMulti.length < 5) {
          selectedImagesMulti.add(File(xfilePick[i].path));
        } else {
          TostMessage.toastMessage(message: AppStaticStrings.youCan5Images);
          break;
        }
      }
      update();
    } else {
      selectedImagesMulti.clear();

      TostMessage.toastMessage(message: AppStaticStrings.noImageSelected);
      update();
    }
  }

  //Select image From Camera

  void openCamera() async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.camera,
    );

    if (pickedFile != null) {
      proImage = File(pickedFile.path);
      update();
    }
  }

  bool isLoading = false;

  Future<void> uploadImage({required bool isUpdate}) async {
    isLoading = true;
    update();

    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString(SharedPreferenceHelper.token);
    String? id = prefs.getString(SharedPreferenceHelper.userIdKey);

    var request = http.MultipartRequest(
      "PATCH",
      Uri.parse(
          "${ApiUrlContainer.baseURL}${ApiUrlContainer.updateProfile}$id"),
    );

    //Add the profile image in index 0

    List<File> allImages = [];

    allImages = selectedImagesMulti;

    allImages.insert(0, File(proImage!.path));

    //Looping the images and sending to API
    for (var img in allImages) {
      if (img.existsSync()) {
        try {
          var multipartImg = await http.MultipartFile.fromPath(
            'photo',
            img.path,
            contentType: MediaType('image', 'jpeg'),
          );
          request.files.add(multipartImg);
        } on Exception catch (e) {
          TostMessage.toastMessage(message: e.toString());
        }
      }
    }

    request.fields["isProfilePictureCompleted"] = "true";

    request.headers['Content-Type'] = 'multipart/form-data';
    request.headers['Authorization'] = "Bearer $token";

    // Send the request
    var response = await request.send();

    String responseBody = await response.stream.bytesToString();

    // Parse the JSON string
    Map<String, dynamic> parsedResponse = jsonDecode(responseBody);

    // Access the "message" field
    String message = parsedResponse['message'];

    if (response.statusCode == 200) {
      UpdateProfileModel model =
          UpdateProfileModel.fromJson(jsonDecode(responseBody));
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString(SharedPreferenceHelper.myImgUrl,
          model.data!.attributes!.photo![0].publicFileUrl!);

      // print(
      //     "ImgUrl========================${img.data!.attributes!.photo![0].publicFileUrl}");

      TostMessage.toastMessage(message: AppStaticStrings.imageUploaded);
      if (isUpdate) {
        profileController.myProfile();
        navigator!.pop();
      } else {
        Get.toNamed(AppRoute.aboutYourSelf,
            arguments: [AppStaticStrings.aboutYourself, "", false]);
      }
    } else {
      TostMessage.toastMessage(message: message);
    }

    isLoading = false;
    update();
  }
}
