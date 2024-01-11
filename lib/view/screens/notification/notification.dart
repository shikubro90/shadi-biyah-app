import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matrimony/core/helper/date_converter.dart';
import 'package:matrimony/utils/app_colors.dart';
import 'package:matrimony/utils/app_static_strings.dart';
import 'package:matrimony/utils/device_utils.dart';
import 'package:matrimony/view/screens/notification/notifiaction_controller/notifiaction_controller.dart';
import 'package:matrimony/view/widget/customText/custom_text.dart';
import 'package:matrimony/view/widget/custom_appbar/custom_appbar.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  void initState() {
    DeviceUtils.statusBarColor();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        top: false,
        child: Scaffold(
          appBar: const CustomAppBar(
            title: AppStaticStrings.notification,
          ),
          body: GetBuilder<NotificationController>(builder: (controller) {
            return controller.isLoading && controller.dataLoading == false
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : controller.results.isEmpty
                    ? const Center(
                        child: CustomText(
                          text: AppStaticStrings.noNotification,
                        ),
                      )
                    : RefreshIndicator(
                        color: AppColors.pink100,
                        onRefresh: () async {
                          controller.pageNum = 1;
                          controller.results.clear();
                          controller.notification();
                        },
                        child: Padding(
                            padding: const EdgeInsets.only(
                                left: 20, right: 20, top: 10),
                            child: ListView.builder(
                              physics: const AlwaysScrollableScrollPhysics(),
                              controller: controller.scrollController,
                              itemCount: controller.results.length,
                              itemBuilder: (context, index) {
                                int lastIndex = controller.results.length - 1;
                                if (index < controller.results.length) {
                                  return Column(
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            margin: const EdgeInsets.only(
                                                right: 16),
                                            height: 42,
                                            width: 42,
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                image: DecorationImage(
                                                    fit: BoxFit.fill,
                                                    image: NetworkImage(
                                                        controller
                                                            .results[index]
                                                            .image![0]
                                                            .publicFileUrl
                                                            .toString()))),
                                          ),
                                          Expanded(
                                              child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              CustomText(
                                                fontSize: 12,
                                                text: controller
                                                    .results[index].message
                                                    .toString(),
                                              ),
                                              CustomText(
                                                fontSize: 8,
                                                color: AppColors.black80,
                                                text: DateConverter
                                                    .formatValidityDate(
                                                        controller
                                                            .results[index]
                                                            .createdAt
                                                            .toString()),
                                              ),
                                            ],
                                          ))
                                        ],
                                      ),
                                      lastIndex == index
                                          ? const SizedBox()
                                          : Container(
                                              height: 2,
                                              margin: const EdgeInsets.only(
                                                  top: 16, bottom: 16),
                                              color: AppColors.pink20,
                                            )
                                    ],
                                  );
                                } else {
                                  return const Center(
                                      child: CircularProgressIndicator());
                                }
                              },
                            )),
                      );
          }),
        ));
  }
}
