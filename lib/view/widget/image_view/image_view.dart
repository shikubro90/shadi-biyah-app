import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matrimony/utils/app_static_strings.dart';
import 'package:matrimony/view/widget/custom_appbar/custom_appbar.dart';

class ImageView extends StatelessWidget {
  const ImageView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    List<dynamic> images = Get.arguments;

    return SafeArea(
        top: false,
        child: Scaffold(
          appBar: const CustomAppBar(title: AppStaticStrings.viewImages),
          body: GridView.builder(
            padding: const EdgeInsets.all(20),
            itemCount: images.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
                mainAxisExtent: 200,
                crossAxisCount: 2),
            itemBuilder: (context, index) {
              return Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(
                            images[index].publicFileUrl.toString()))),
              );
            },
          ),
        ));
  }
}
