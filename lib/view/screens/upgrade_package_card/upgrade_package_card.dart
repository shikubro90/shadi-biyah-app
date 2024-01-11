import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matrimony/core/global/payment/payment_controller.dart';
import 'package:matrimony/utils/app_colors.dart';
import 'package:matrimony/utils/app_static_strings.dart';
import 'package:matrimony/view/screens/premium_packages/package_model/package_model.dart';
import 'package:matrimony/view/widget/button/button.dart';
import 'package:matrimony/view/widget/button/loading_button.dart';
import 'package:matrimony/view/widget/customText/custom_text.dart';
import 'package:matrimony/view/widget/custom_appbar/custom_appbar.dart';

class UpgradePackageCard extends StatefulWidget {
  const UpgradePackageCard({
    super.key,
  });

  @override
  State<UpgradePackageCard> createState() => _UpgradePackageCardState();
}

class _UpgradePackageCardState extends State<UpgradePackageCard> {
  dynamic package = Get.arguments[0];
  final bool showPackage = Get.arguments[1];
  final String country = Get.arguments[2];

  List<String> pkPaymentLists = [
    AppStaticStrings.paymobCard,
    AppStaticStrings.easyPaisa,
    AppStaticStrings.jazzCash,
  ];

  List<String> otherPaymentLists = [
    AppStaticStrings.paymobCard,
  ];

  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        top: false,
        child: Scaffold(
          appBar: const CustomAppBar(
            title: AppStaticStrings.upgradetoPremiumAccount,
          ),
          bottomNavigationBar:
              GetBuilder<PaymentController>(builder: (controller) {
            return controller.isLoading
                ? const CustomLoadingButton(
                    left: 20,
                    right: 20,
                    bottom: 24,
                  )
                : CustomButton(
                    text: AppStaticStrings.proceedtoPayment,
                    ontap: () async {
                      await controller.paymobPayment(
                          country: country,
                          isAditionnalMatch: showPackage,
                          subsCriptionID: package.id.toString(),
                          index: currentIndex,
                          price: country == "PK"
                              ? package.pkCountryPrice.toString()
                              : package.otherCountryPrice.toString(),
                          context: context,
                          packageName: package.name);
                    },
                    left: 20,
                    right: 20,
                    bottom: 24,
                  );
          }),
          body: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Card Details (Design)
                if (showPackage)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: PackageCardDesign(
                      country: country,
                      showButton: false,
                      package: package,
                    ),
                  ),

                //Text
                if (showPackage)
                  const CustomText(
                    fontSize: 16,
                    bottom: 16,
                    fontWeight: FontWeight.w500,
                    text: AppStaticStrings.paymentMethod,
                  ),

                //Warning Note for Jazz Cash

                if (currentIndex == 2)
                  const CustomText(
                    textAlign: TextAlign.left,
                    fontSize: 16,
                    bottom: 16,
                    color: AppColors.pink100,
                    maxLines: 4,
                    fontWeight: FontWeight.w500,
                    text: AppStaticStrings.jazzCashWarnning,
                  ),
                //All Payment Method Card List
                Expanded(
                    child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount:
                      //country == "PK"
                      //   ?

                      pkPaymentLists.length,
                  // :

                  // otherPaymentLists.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          currentIndex = index;
                        });
                      },
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 16),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: AppColors.white100),
                        child: Row(
                          children: [
                            Container(
                              height: 20,
                              width: 20,
                              decoration: ShapeDecoration(
                                  shape: CircleBorder(
                                      side: BorderSide(
                                          color: currentIndex != index
                                              ? AppColors.pink100
                                              : AppColors.white100)),
                                  color: currentIndex == index
                                      ? AppColors.pink100
                                      : null),
                            ),
                            CustomText(
                                left: 10,
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                text:
                                    //country == "PK"
                                    //  ?
                                    pkPaymentLists[index]
                                // :
                                // otherPaymentLists[index],
                                )
                          ],
                        ),
                      ),
                    );
                  },
                ))
              ],
            ),
          ),
        ));
  }
}
