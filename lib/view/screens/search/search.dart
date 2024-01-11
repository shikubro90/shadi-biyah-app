import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matrimony/utils/app_static_strings.dart';
import 'package:matrimony/view/screens/search/inner/search_by_criteria/search_by_criteria.dart';
import 'package:matrimony/view/screens/search/inner/search_by_name/search_by_name.dart';
import 'package:matrimony/view/screens/search/search_controller/search_controller.dart';
import 'package:matrimony/view/widget/button/button.dart';
import 'package:matrimony/view/widget/customText/custom_text.dart';
import 'package:matrimony/view/widget/tap_bar_button/tap_bar_button.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  bool isCriteria = true;
  bool isSearch = false;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        isSearch
            ? setState(() {
                isSearch = false;
              })
            : Get.back();

        return isSearch;
      },
      child: SafeArea(
          top: false,
          child: Scaffold(
            bottomNavigationBar:
                GetBuilder<SearchUserController>(builder: (controller) {
              return CustomButton(
                text:
                    isSearch ? AppStaticStrings.clear : AppStaticStrings.search,
                bottom: 24,
                left: 20,
                right: 20,
                ontap: () {
                  if (isSearch) {
                    controller.clear();
                    controller.results = [];
                  } else {
                    controller.search();
                  }

                  setState(() {
                    isSearch = !isSearch;
                  });
                },
              );
            }),
            body: Padding(
              padding: const EdgeInsets.only(top: 24, left: 20, right: 20),
              child: Column(
                children: [
                  //App Bar
                  Padding(
                    padding: const EdgeInsets.only(bottom: 24, top: 24),
                    child: Row(
                      children: [
                        IconButton(
                            onPressed: () {
                              isSearch
                                  ? setState(() {
                                      isSearch = false;
                                    })
                                  : Get.back();
                            },
                            icon: const Icon(Icons.arrow_back_ios)),
                        const SizedBox(
                          width: 8,
                        ),
                        CustomText(
                          text: isSearch
                              ? AppStaticStrings.searchResult
                              : AppStaticStrings.search,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ],
                    ),
                  ),

                  //Tab Bar
                  GetBuilder<SearchUserController>(builder: (controller) {
                    return Row(
                      children: [
                        //Search by Criteria
                        TabBarButton(
                            text: AppStaticStrings.searchbyCriteria,
                            ontap: () {
                              setState(() {
                                controller.clear();
                                controller.results = [];
                                isSearch = false;
                                isCriteria = !isCriteria;
                              });
                            },
                            isSelected: isCriteria),
                        //Search by Name

                        TabBarButton(
                            text: AppStaticStrings.searchbyName,
                            ontap: () {
                              setState(() {
                                isSearch = false;
                                isCriteria = !isCriteria;
                              });
                            },
                            isSelected: !isCriteria),
                      ],
                    );
                  }),
                  const SizedBox(
                    height: 8,
                  ),
                  isCriteria
                      ? Expanded(
                          child: SearchByCriteria(
                            isSearch: isSearch,
                          ),
                        )
                      : Expanded(
                          child: SearchByName(
                            isSearch: isSearch,
                          ),
                        )
                ],
              ),
            ),
          )),
    );
  }
}
