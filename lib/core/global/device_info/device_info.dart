import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';

Future<String> getDeviceInfo() async {
  String model = "";
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

  if (Platform.isAndroid) {
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;

    String model = androidInfo.brand;

    return model;
  } else if (Platform.isIOS) {
    IosDeviceInfo iosInfo = await deviceInfo.iosInfo;

    model = iosInfo.utsname.machine;
    return model;
  }

  return model;
}
