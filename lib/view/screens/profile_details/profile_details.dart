import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matrimony/core/helper/sharedpreference_helper.dart';
import 'package:matrimony/core/route/app_route.dart';
import 'package:matrimony/utils/app_colors.dart';
import 'package:matrimony/utils/app_icons.dart';
import 'package:matrimony/utils/app_static_strings.dart';
import 'package:matrimony/view/screens/home/inner_widgets/cardDesign/card_design.dart';
import 'package:matrimony/view/widget/all_multiple_used_repos/block_profile_repo/block_profile_repo.dart';
import 'package:matrimony/view/widget/customText/custom_text.dart';
import 'package:matrimony/view/widget/custom_img/custom_img.dart';
import 'package:matrimony/view/widget/pop_up/all_pop_up.dart';
import 'package:matrimony/view/widget/profile_custom/inner/aboutProfile/about_profile.dart';
import 'package:matrimony/view/widget/profile_custom/inner/family/family.dart';
import 'package:matrimony/view/widget/profile_custom/inner/preference/preference.dart';
import 'package:matrimony/view/widget/profile_custom/profile_custom.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../messages/screen/message/inbox/all_inbox_repo/all_inbox_repo.dart';

class ProfileDetails extends StatefulWidget {
  const ProfileDetails({super.key});

  @override
  State<ProfileDetails> createState() => _ProfileDetailsState();
}

class _ProfileDetailsState extends State<ProfileDetails> {
  bool ispayment = false;

  getPaymentInfo() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final bool? getPayment = prefs.getBool(SharedPreferenceHelper.isPayment);
    setState(() {
      ispayment = getPayment!;
    });
  }

  @override
  void initState() {
    getPaymentInfo();
    super.initState();
  }

  dynamic data = Get.arguments;

  TextEditingController reportDescriptionController = TextEditingController();
  getChatID() async {
    String getChatID = await AllInboxRepo.createChat(
      partnerID: data.id,
    );
    debugPrint("Chat Id Profile Screen : $getChatID");
    Get.toNamed(AppRoute.inbox, arguments: [
      data.name.toString(),
      data.photo![0].publicFileUrl,
      data.id
    ], parameters: {
      "chatId": getChatID
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        top: false,
        child: Scaffold(
          body: Padding(
            padding: const EdgeInsets.only(top: 44, left: 20, right: 20),
            child: Column(
              children: [
                //App Bar
                Padding(
                  padding: const EdgeInsets.only(bottom: 24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      //Back button and Title
                      Row(
                        children: [
                          IconButton(
                              onPressed: () {
                                Get.back();
                              },
                              icon: const Icon(
                                  color: AppColors.black60,
                                  Icons.arrow_back_ios_rounded)),
                          const SizedBox(
                            width: 8,
                          ),
                          const CustomText(
                            text: AppStaticStrings.profileDetails,
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ],
                      ),

                      Row(
                        children: [
                          //Message Icon

                          GestureDetector(
                            onTap: () {
                              getChatID();
                            },
                            child: Container(
                              padding: const EdgeInsets.all(5),
                              decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppColors.pink100),
                              child: const CustomImage(imageSrc: AppIcons.chat),
                            ),
                          ),

                          //More Button

                          PopupMenuButton(
                            surfaceTintColor: AppColors.green100,
                            color: AppColors.white100,
                            icon: const Icon(
                              Icons.more_vert_outlined,
                              color: AppColors.black100,
                            ),
                            itemBuilder: (context) => [
                              //Report Profile

                              PopupMenuItem<SampleItem>(
                                value: SampleItem.itemOne,
                                child: GestureDetector(
                                    onTap: () {
                                      navigator!.pop();
                                      AllPopUp.showReportDiolog(
                                        id: data.id,
                                        context: context,
                                        selectedReport: 0,
                                      );
                                    },
                                    child: const CustomText(
                                      color: AppColors.black100,
                                      fontSize: 14,
                                      text: AppStaticStrings.reportProfile,
                                    )),
                              ),

                              //Block Profile

                              PopupMenuItem<SampleItem>(
                                value: SampleItem.itemTwo,
                                child: GestureDetector(
                                    onTap: () {
                                      navigator!.pop();
                                      AllPopUp.showDialogWith2Button(
                                          button1ontap: () {
                                            BlockProfileRepo.blockProfile(
                                                id: data.id);
                                          },
                                          button2ontap: () {},
                                          context: context,
                                          title: AppStaticStrings
                                              .yousureWanttoBlockthisProfile,
                                          button1Title: AppStaticStrings.yes,
                                          button2Title: AppStaticStrings.no);
                                    },
                                    child: const CustomText(
                                      color: AppColors.black100,
                                      fontSize: 14,
                                      text: AppStaticStrings.blockProfiles,
                                    )),
                              ),
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                ),
                //Content
                ProfileCustom(
                  imgSection: CardDesign(
                      userID: data.id.toString(),
                      photos: data.photo!,
                      ontapGallry: () {},
                      isProfileDetails: true,
                      imgHeight: 400,
                      name: data.name.toString(),
                      title: "${data.occupation} ${data.dataOfBirth}",
                      subTitle: "${data.country} ${data.city}",
                      isPremium: data.payment),
                  aboutSection: AboutProfile(
                    data: data,
                    isPremium: ispayment,
                  ),
                  familySection: Family(data: data),
                  preferenceSection: Preference(data: data),
                )
              ],
            ),
          ),
        ));
  }
}

enum SampleItem {
  itemOne,
  itemTwo,
}
