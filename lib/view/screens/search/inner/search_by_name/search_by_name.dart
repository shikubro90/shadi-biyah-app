import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:matrimony/core/route/app_route.dart';
import 'package:matrimony/utils/app_colors.dart';
import 'package:matrimony/utils/app_static_strings.dart';
import 'package:matrimony/view/screens/messages/screen/message/inbox/all_inbox_repo/all_inbox_repo.dart';
import 'package:matrimony/view/screens/search/search_controller/search_controller.dart';
import 'package:matrimony/view/widget/customText/custom_text.dart';
import 'package:matrimony/view/widget/request_card/request_card.dart';
import 'package:matrimony/view/widget/text_editingField/textediting_field.dart';

class SearchByName extends StatefulWidget {
  final bool isSearch;

  const SearchByName({
    super.key,
    required this.isSearch,
  });

  @override
  State<SearchByName> createState() => _SearchByNameState();
}

class _SearchByNameState extends State<SearchByName> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: GetBuilder<SearchUserController>(builder: (controller) {
        return Column(
          children: [
            //Search by Profile Name

            CustomTextField(
              textEditingController: controller.nameController,
              readOnly: false,
              hintText: AppStaticStrings.profilename,
            ),
            if (widget.isSearch)
              controller.isLoading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : controller.results.isEmpty
                      ? const CustomText(
                          top: 60,
                          text: AppStaticStrings.noProfileFound,
                        )
                      : Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: RefreshIndicator(
                              color: AppColors.pink100,
                              onRefresh: () async {
                                controller.refreshData();
                              },
                              child: ListView.builder(
                                itemCount: controller.dataLoading
                                    ? controller.results.length + 1
                                    : controller.results.length,
                                itemBuilder: (BuildContext context, int index) {
                                  var data = controller.results[index];

                                  if (index < controller.results.length) {
                                    return GestureDetector(
                                      onTap: () {
                                        Get.toNamed(AppRoute.profileDetails,
                                            arguments:
                                                controller.results[index]);
                                        // print(
                                        //     "object========${controller.results}");
                                      },
                                      child: RequestCard(
                                          button0Ontap: () async {
                                            String getChatID =
                                                await AllInboxRepo.createChat(
                                              partnerID: data.id!,
                                            );
                                            debugPrint(
                                                "Chat Id Profile Screen : $getChatID");
                                            Get.toNamed(AppRoute.inbox,
                                                arguments: [
                                                  data.name.toString(),
                                                  data.photo![0].publicFileUrl,
                                                  data.id
                                                ],
                                                parameters: {
                                                  "chatId": getChatID
                                                });
                                          },
                                          name: data.name.toString(),
                                          title:
                                              "${data.occupation} ${data.age}",
                                          subTitle: data.country.toString(),
                                          proPic: data.photo![0].publicFileUrl
                                              .toString()),
                                    );
                                  } else {
                                    return const Center(
                                        child: CircularProgressIndicator());
                                  }
                                },
                              ),
                            ),
                          ),
                        )
          ],
        );
      }),
    );
  }
}
