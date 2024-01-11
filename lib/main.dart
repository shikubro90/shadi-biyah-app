import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:matrimony/core/di_service/dependency_injection.dart';
import 'package:matrimony/core/route/app_route.dart';
import 'package:matrimony/core/service/socket_service.dart';

import 'package:matrimony/utils/device_utils.dart';

// getIP() async {
//   final ipv4 = await Ipify.ipv4();
//   print("=========================$ipv4"); // 98.207.254.136

//   final ipv6 = await Ipify.ipv64();
//   print("=============$ipv6"); // 98.207.254.136 or 2a00:1450:400f:80d::200e

//   final ipv4json = await Ipify.ipv64(format: Format.JSON);
//   print(
//       "=============$ipv4json"); //{"ip":"98.207.254.136"} or {"ip":"2a00:1450:400f:80d::200e"}

// }

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  DeviceUtils.lockDevicePortrait();
  DeviceUtils.systemNavigationBarColor();
  DependencyInjection dI = DependencyInjection();
  dI.dependencies();
  dI.downloadPermission();
  SocketApi.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        defaultTransition: Transition.noTransition,
        transitionDuration: const Duration(milliseconds: 200),
        initialRoute: AppRoute.splashScreen,
        // initialRoute: AppRoute.noInternet,
        navigatorKey: Get.key,
        getPages: AppRoute.routes,
      ),
    );
  }
}
