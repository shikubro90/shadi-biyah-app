import 'package:flutter/material.dart';
import 'package:matrimony/utils/app_static_strings.dart';
import 'package:matrimony/view/widget/tap_bar_button/tap_bar_button.dart';

class ProfileCustom extends StatefulWidget {
  final Widget imgSection;
  final Widget aboutSection;
  final Widget familySection;
  final Widget preferenceSection;

  const ProfileCustom(
      {super.key,
      required this.imgSection,
      required this.aboutSection,
      required this.familySection,
      required this.preferenceSection});

  @override
  State<ProfileCustom> createState() => _ProfileCustomState();
}

class _ProfileCustomState extends State<ProfileCustom> {
  List<String> tapBarItems = [
    AppStaticStrings.about,
    AppStaticStrings.family,
    AppStaticStrings.preferences,
  ];

  int tapBarIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            //Image Section
            widget.imgSection,
            const SizedBox(
              height: 22,
            ),

            //Tap Bar
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: tapBarItems.asMap().entries.map((entry) {
                int index = entry.key;
                String status = entry.value;

                return TabBarButton(
                  isSelected: tapBarIndex == index,
                  text: status,
                  ontap: () {
                    setState(() {
                      tapBarIndex = index;
                    });
                  },
                );
              }).toList(),
            ),
            const SizedBox(
              height: 16,
            ),
            //rest of the content
            if (tapBarIndex == 0) widget.aboutSection,
            if (tapBarIndex == 1) widget.familySection,
            if (tapBarIndex == 2) widget.preferenceSection,
          ],
        ),
      ),
    );
  }
}
