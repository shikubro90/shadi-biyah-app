import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matrimony/core/helper/date_converter.dart';
import 'package:matrimony/utils/app_colors.dart';
import 'package:matrimony/utils/app_icons.dart';
import 'package:matrimony/utils/app_static_strings.dart';
import 'package:matrimony/view/screens/settings/login_activity/log_out_repo/log_out_repo.dart';
import 'package:matrimony/view/screens/settings/login_activity/login_activity_controller/login_activity_controller.dart';
import 'package:matrimony/view/widget/button/button.dart';
import 'package:matrimony/view/widget/customText/custom_text.dart';
import 'package:matrimony/view/widget/custom_appbar/custom_appbar.dart';
import 'package:matrimony/view/widget/custom_img/custom_img.dart';

class LoginActivity extends StatefulWidget {
  const LoginActivity({super.key});

  @override
  State<LoginActivity> createState() => _LoginActivityState();
}

class _LoginActivityState extends State<LoginActivity> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        top: false,
        child: Scaffold(
          appBar: const CustomAppBar(
            title: AppStaticStrings.loginActivity,
          ),
          body: GetBuilder<LogInActivityController>(builder: (controller) {
            return controller.isLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : controller.results.isEmpty
                    ? const Center(
                        child: CustomText(
                          text: AppStaticStrings.noLoginActivity,
                        ),
                      )
                    : RefreshIndicator(
                        color: AppColors.pink100,
                        onRefresh: () async {
                          controller.refreshData();
                        },
                        child: Padding(
                            padding: const EdgeInsets.only(left: 20, right: 20),
                            child: ListView.builder(
                              itemCount: controller.results.length,
                              physics: const AlwaysScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                var data = controller.results[index];
                                return LogIndeviceDetails(
                                    onTap: () {
                                      LogOutUser.logOut(id: data.id.toString());
                                    },
                                    deviceName: data.operatingSystem.toString(),
                                    locationName: data.location.toString(),
                                    timeName: DateConverter.formatValidityDate(
                                        data.createdAt.toString()));
                              },
                            )),
                      );
          }),
        ));
  }
}

class LogIndeviceDetails extends StatelessWidget {
  final String deviceName;
  final String locationName;
  final String timeName;
  final VoidCallback onTap;

  const LogIndeviceDetails(
      {super.key,
      required this.deviceName,
      required this.locationName,
      required this.timeName,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white100,
        borderRadius: BorderRadius.circular(8),
        boxShadow: const [
          BoxShadow(
            color: AppColors.black10,
            blurRadius: 18,
            offset: Offset(0, 0),
            spreadRadius: 0,
          )
        ],
      ),
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          //First Row (Device-Icon and Device name , Location-Icon and Location , Clock-Icon and Time)
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.only(right: 4),
              child: Column(
                children: [
                  //Decive Icon and Name
                  Row(
                    children: [
                      const CustomImage(
                          size: 14, imageSrc: AppIcons.deviceMobile),
                      const SizedBox(
                        width: 4,
                      ),
                      Flexible(
                        child: CustomText(
                          textAlign: TextAlign.left,
                          maxLines: 2,
                          fontSize: 12,
                          text: deviceName,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Row(
                    children: [
                      //Location Icon and name

                      Row(
                        children: [
                          const CustomImage(imageSrc: AppIcons.location),
                          const SizedBox(
                            width: 4,
                          ),
                          CustomText(
                            fontSize: 10,
                            text: locationName,
                          ),
                        ],
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      //Time Icon and name

                      Row(
                        children: [
                          const CustomImage(imageSrc: AppIcons.clock),
                          const SizedBox(
                            width: 4,
                          ),
                          CustomText(
                            fontSize: 8,
                            text: timeName,
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),

          //Log Out Button
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: CustomButton(
                    height: 30,
                    ontap: () {
                      onTap();
                    },
                    text: AppStaticStrings.logOut,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
