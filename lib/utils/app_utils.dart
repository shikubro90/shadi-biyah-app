import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matrimony/utils/app_colors.dart';
import 'package:matrimony/view/widget/customText/custom_text.dart';
import 'package:fluttertoast/fluttertoast.dart';

class TostMessage {
  static warningSnakbar(
      {required BuildContext context,
      required title,
      int duration = 4,
      IconData icon = Icons.error}) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: SizedBox(
          height: 30,
          child: Row(
            children: [
              Icon(icon, color: Colors.white),
              Expanded(
                  child: CustomText(
                text: title,
                color: AppColors.white100,
              )),
            ],
          ),
        ),
        behavior: SnackBarBehavior.floating,
        dismissDirection: DismissDirection.up,
        backgroundColor: AppColors.pink100,
        duration: Duration(seconds: duration),
      ),
    );
  }

  static void fieldFocusChange(
      BuildContext context, FocusNode current, FocusNode nextFocus) {
    current.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  static toastMessage({required String message}) {
    Fluttertoast.showToast(
      msg: message,
      backgroundColor: AppColors.pink100,
      textColor: AppColors.white100,
      gravity: ToastGravity.BOTTOM,
      toastLength: Toast.LENGTH_LONG,
    );
  }

  // static toastMessageCenter({required String message}) {
  //   Fluttertoast.showToast(
  //     msg: message,
  //     backgroundColor: AppColors.pink100,
  //     gravity: ToastGravity.CENTER,
  //     toastLength: Toast.LENGTH_LONG,
  //     textColor: AppColors.white100,
  //   );
  // }

  static snackBar({required String title, required String message}) {
    Get.snackbar(title, message,
        snackPosition: SnackPosition.TOP,
        backgroundColor: AppColors.pink100,
        colorText: AppColors.white100,
        duration: const Duration(seconds: 3));
  }
}
