import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:matrimony/utils/app_static_strings.dart';
import 'package:matrimony/view/screens/privacy_policy/privacy_policy_controller/privacy_policy_controller.dart';
import 'package:matrimony/view/widget/customText/custom_text.dart';
import 'package:matrimony/view/widget/custom_appbar/custom_appbar.dart';

class PrivacyPolicy extends StatefulWidget {
  const PrivacyPolicy({super.key});

  @override
  State<PrivacyPolicy> createState() => _PrivacyPolicyState();
}

class _PrivacyPolicyState extends State<PrivacyPolicy> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        top: false,
        child: Scaffold(
          appBar: const CustomAppBar(
            title: AppStaticStrings.privacyPolicy,
          ),
          body: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: GetBuilder<PrivacyPolicyController>(builder: (controller) {
                return controller.isLoading
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : controller.attributes.isEmpty
                        ? const Center(
                            child: CustomText(
                              text: AppStaticStrings.noPrivacyPolicy,
                            ),
                          )
                        : Html(
                            data: controller.attributes[0].content,
                          );
              })),
        ));
  }
}
