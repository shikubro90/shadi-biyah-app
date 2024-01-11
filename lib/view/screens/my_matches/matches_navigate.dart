import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matrimony/utils/device_utils.dart';
import 'package:matrimony/view/screens/my_matches/initial_matche/initial_match.dart';
import 'package:matrimony/view/screens/my_matches/matches_home/matches_home.dart';
import 'package:matrimony/view/screens/my_matches/my_match_controller/my_match_controller.dart';
import 'package:matrimony/view/widget/nav_bar/nav_bar.dart';

class MatchesNavigate extends StatefulWidget {
  const MatchesNavigate({super.key});

  @override
  State<MatchesNavigate> createState() => _MatchesNavigateState();
}

class _MatchesNavigateState extends State<MatchesNavigate> {
  MyMatchController myMatchController = Get.find<MyMatchController>();

  @override
  void initState() {
    DeviceUtils.statusBarColor();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> screens = [
      const InitialMatches(),
      MatchesHome(data: myMatchController.attributes),
    ];
    return SafeArea(
        top: false,
        child: Scaffold(
          bottomNavigationBar: const NavBar(currentIndex: 2),
          body: GetBuilder<MyMatchController>(builder: (controller) {
            return controller.isLoading && controller.dataLoading == false
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : controller.attributes.isEmpty
                    ? screens[0]
                    : screens[1];
          }),
        ));
  }
}
