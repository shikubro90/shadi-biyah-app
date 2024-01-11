import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:matrimony/utils/app_static_strings.dart';
import 'package:matrimony/view/screens/terms_condition/terms_condition_controller/terms_condition_controller.dart';
import 'package:matrimony/view/widget/customText/custom_text.dart';
import 'package:matrimony/view/widget/custom_appbar/custom_appbar.dart';

class TermCondition extends StatefulWidget {
  const TermCondition({super.key});

  @override
  State<TermCondition> createState() => _TermConditionState();
}

class _TermConditionState extends State<TermCondition> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        top: false,
        child: Scaffold(
          appBar: const CustomAppBar(
            title: AppStaticStrings.termsConditions,
          ),
          body: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: GetBuilder<TermsAndConditionController>(
                builder: (controller) {
                  return controller.isLoading
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : controller.attributes.isEmpty
                          ? const Center(
                              child: CustomText(
                                text: AppStaticStrings.noTermsConditions,
                              ),
                            )
                          : Html(data: controller.attributes[0].content);
                },
              )),
        ));
  }
}
