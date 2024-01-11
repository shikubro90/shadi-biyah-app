import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:matrimony/utils/app_colors.dart';
import 'package:matrimony/utils/app_icons.dart';
import 'package:matrimony/utils/app_images.dart';
import 'package:matrimony/utils/app_static_strings.dart';
import 'package:matrimony/utils/app_utils.dart';
import 'package:matrimony/view/screens/auth/sign_up/screens/upload_photo/upload_photo_controller/upload_photo_controller.dart.dart';
import 'package:matrimony/view/widget/button/button.dart';
import 'package:matrimony/view/widget/button/loading_button.dart';
import 'package:matrimony/view/widget/customText/custom_text.dart';
import 'package:matrimony/view/widget/custom_appbar_pink/custom_appbar_pink.dart';
import 'package:matrimony/view/widget/custom_img/custom_img.dart';
import 'package:matrimony/view/widget/pop_up/all_pop_up.dart';

class UploadPhoto extends StatefulWidget {
  const UploadPhoto({super.key});

  @override
  State<UploadPhoto> createState() => _UploadPhotoState();
}

class _UploadPhotoState extends State<UploadPhoto> {
  @override
  void initState() {
    super.initState();
  }

  bool isUpdate = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Show the exit confirmation dialog
        bool exit = await showDialog(
          context: context,
          builder: (BuildContext context) {
            return const ExitConfirmationDialog();
          },
        );

        // Return true if the user wants to exit, false otherwise
        return exit;
      },
      child: GetBuilder<UploadImageController>(builder: (controller) {
        return CustomAppBarPink(
            bottomNavBar: controller.isLoading
                ? const CustomLoadingButton(
                    bottom: 24,
                    left: 20,
                    right: 20,
                  )
                : CustomButton(
                    text: AppStaticStrings.upload,
                    bottom: 24,
                    left: 20,
                    right: 20,
                    ontap: () {
                      //Check if Image is null
                      if (controller.proImage != null) {
                        controller.uploadImage(isUpdate: isUpdate);
                      } else {
                        TostMessage.toastMessage(
                            message: AppStaticStrings.uploadPictures);
                      }
                    }),
            title: AppStaticStrings.uploadPictures,
            onBack: () {
              Get.back();
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Stack(
                  children: [
                    //Image Design
                    GestureDetector(
                      onTap: () {
                        controller.openGallery();
                      },
                      child: Container(
                          margin: EdgeInsets.symmetric(
                              vertical: controller.proImage == null ? 0 : 24),
                          padding: const EdgeInsets.all(16),
                          width: 200,
                          height: 200,
                          decoration: const ShapeDecoration(
                            color: Colors.white,
                            shape: OvalBorder(
                              side:
                                  BorderSide(width: 1, color: AppColors.pink40),
                            ),
                          ),
                          child: controller.proImage != null
                              ? Container(
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: FileImage(File(
                                              controller.proImage!.path)))),
                                )
                              : const CustomImage(
                                  imageSrc: AppImages.uploadImg,
                                )),
                    ),

                    //Camera Icon
                    Positioned(
                        bottom: 15,
                        right: 15,
                        child: GestureDetector(
                          onTap: () {
                            controller.openCamera();
                            // controller.proImage = null;
                            // controller.selectedImagesMulti = [];
                          },
                          child: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: const BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: AppColors.black20,
                                      blurRadius: 18,
                                      offset: Offset(0, 0),
                                      spreadRadius: 0,
                                    )
                                  ],
                                  shape: BoxShape.circle,
                                  color: AppColors.white100),
                              child: const CustomImage(
                                  imageSrc: AppIcons.camera2)),
                        ))
                  ],
                ),

                //Multiple Image Picker
                if (controller.proImage != null)
                  InkWell(
                    onTap: () {
                      controller.pickMultiImage();
                    },
                    child: const CustomText(
                      color: AppColors.pink100,
                      bottom: 24,
                      text: AppStaticStrings.addMore,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                //Text
                if (controller.proImage == null)
                  const CustomText(
                    bottom: 8,
                    top: 24,
                    text: AppStaticStrings.uploadPictures,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                //Text

                if (controller.proImage == null)
                  const CustomText(
                    text: AppStaticStrings.youCanUpload,
                    color: AppColors.black60,
                  ),

                if (controller.selectedImagesMulti.isNotEmpty)
                  Expanded(
                      child: GridView.builder(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    itemCount: controller.selectedImagesMulti.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisSpacing: 20,
                            mainAxisSpacing: 20,
                            mainAxisExtent: 200,
                            crossAxisCount: 2),
                    itemBuilder: (context, index) {
                      return Image.file(controller.selectedImagesMulti[index]);
                    },
                  ))
              ],
            ));
      }),
    );
  }
}
