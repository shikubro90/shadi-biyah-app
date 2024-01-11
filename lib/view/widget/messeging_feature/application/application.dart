import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:matrimony/utils/app_colors.dart';
import 'package:matrimony/utils/app_static_strings.dart';
import 'package:matrimony/utils/app_utils.dart';
import 'package:matrimony/view/widget/customText/custom_text.dart';
import 'package:path_provider/path_provider.dart';

// ignore: must_be_immutable
class MyApplication extends StatefulWidget {
  const MyApplication({super.key, required this.url});
  final String url;

  @override
  State<MyApplication> createState() => _MyApplicationState();
}

class _MyApplicationState extends State<MyApplication> {
  String? externalStorageDirPath;

  Future<String?> _getSavedDir() async {
    externalStorageDirPath =
        (await getApplicationDocumentsDirectory()).absolute.path;

    return externalStorageDirPath;
  }

  @override
  void initState() {
    _getSavedDir();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150.h,
      width: 150.w,
      child: Column(
        children: [
          Icon(
            Icons.file_copy,
            color: AppColors.pink100,
            size: 80.r,
          ),
          Row(
            children: [
              IconButton(
                  onPressed: () async {
                    await FlutterDownloader.enqueue(
                      saveInPublicStorage: true,

                      url: widget.url,
                      headers: {}, // optional: header send with url (auth token etc)
                      savedDir: '$externalStorageDirPath',
                      showNotification:
                          true, // show download progress in status bar (for Android)
                      openFileFromNotification:
                          true, // click on notification to open downloaded file (for Android)
                    ).then((value) {
                      TostMessage.toastMessage(
                          message: AppStaticStrings.downloadDone);
                    });

                    // print('$externalStorageDirPath/ShaadiBiyaah/zero');
                  },
                  icon: const Icon(Icons.download_for_offline_outlined)),
              const CustomText(
                text: AppStaticStrings.download,
              )
            ],
          )
        ],
      ),
    );
  }
}
