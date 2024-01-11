import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:matrimony/utils/app_static_strings.dart';
import 'package:matrimony/view/screens/about_us/about_us_controller/about_us_controller.dart';
import 'package:matrimony/view/widget/customText/custom_text.dart';
import 'package:matrimony/view/widget/custom_appbar/custom_appbar.dart';

class AboutUS extends StatefulWidget {
  const AboutUS({super.key});

  @override
  State<AboutUS> createState() => _AboutUSState();
}

class _AboutUSState extends State<AboutUS> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        top: false,
        child: Scaffold(
          appBar: const CustomAppBar(
            title: AppStaticStrings.aboutUs,
          ),
          body: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: GetBuilder<AboutUsController>(builder: (controller) {
                return controller.isLoading
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : controller.attributes.isEmpty
                        ? const Center(
                            child: CustomText(
                              text: AppStaticStrings.noAboutUs,
                            ),
                          )
                        : Html(data: controller.attributes[0].content);
              })),
        ));
  }
}
