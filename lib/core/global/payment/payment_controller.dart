import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matrimony/core/global/api_response_method.dart';
import 'package:matrimony/core/global/api_response_model.dart';
import 'package:matrimony/core/global/api_url_container.dart';
import 'package:matrimony/core/global/payment/paymob/billing/paymob_billing_data.dart';
import 'package:matrimony/core/global/payment/paymob/payment_utils/paymob_payment_utils.dart';
import 'package:matrimony/core/global/payment/paymob/response/paymob_response.dart';
import 'package:matrimony/core/helper/sharedpreference_helper.dart';
import 'package:matrimony/core/service/api_service.dart';
import 'package:matrimony/utils/app_static_strings.dart';
import 'package:matrimony/utils/app_utils.dart';
import 'package:matrimony/view/screens/my_subscription_plan/my_subscription_controller/my_subscription_controller.dart';
import 'package:matrimony/view/screens/profile/profile_controller/profile_controller.dart';
import 'package:matrimony/view/widget/pop_up/all_pop_up.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PaymentController extends GetxController with GetxServiceMixin {
  String getName = "";
  String getEmail = "";

  getNameAndEmail() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    String? name = prefs.getString(SharedPreferenceHelper.name);
    String? email = prefs.getString(SharedPreferenceHelper.email);

    getName = name ?? " ";
    getEmail = email ?? " ";

    debugPrint("Email=============$getEmail");
    debugPrint("getName=============$getName");

    update();
  }

  List<String> cardList = [
    AppStaticStrings.paymobCard,
    AppStaticStrings.easyPaisa,
    AppStaticStrings.jazzCash,
  ];
  //Update Profile

  ProfileController profileController = Get.find<ProfileController>();

  ApiService apiService = ApiService(sharedPreferences: Get.find());

  bool isLoading = false;

//Paymob
//
//

//Initialize paymob
  initPaymob({required String country}) {
    PaymobPakistan.instance.initialize(
      apiKey: ApiUrlContainer
          .paymobApiKey, // from dashboard Select Settings -> Account Info -> API Key
      jazzcashIntegrationId: ApiUrlContainer
          .jazzIdTest, // From Dashboard select Developers -> Payment Integrations -> JazzCash Integration ID
      easypaisaIntegrationID: ApiUrlContainer
          .easypaisaIDTest, // From Dashboard select Developers -> Payment Integrations -> EasyPaisa Integration ID
      integrationID: country == "PK"
          ? ApiUrlContainer.cardPKRIDTest
          : ApiUrlContainer
              .cardUSDIDTest, // from dashboard Select Developers -> Payment Integrations -> Online Card ID
      iFrameID:
          ApiUrlContainer.iFrameID, // from paymob Select Developers -> iframes
    );
  }

//Payment with paymob

  Future<void> paymobPayment({
    required BuildContext context,
    required int index,
    required String subsCriptionID,
    required String country,
    required bool isAditionnalMatch,
    required String price,
    required String packageName,
  }) async {
    try {
      PaymobResponse? response;
      isLoading = true;
      initPaymob(country: country);
      update();

      await PaymobPakistan.instance.pay(
        context: context,
        currency: country == "PK" ? AppStaticStrings.pkr : AppStaticStrings.uSD,
        paymentType: index == 0
            ? PaymentType.card
            : index == 1
                ? PaymentType.easypaisa
                : PaymentType.jazzcash,
        amountInCents: (int.tryParse(price)! * 100).toString(),
        onPayment: (getResponse) => response = getResponse,
        billingData: PaymobBillingData(
            email: getEmail,
            firstName: getName,
            lastName: getName,
            phoneNumber: "+921234567890",
            apartment: "NA",
            building: "NA",
            city: "NA",
            country: "Pakistan",
            floor: "NA",
            postalCode: "NA",
            shippingMethod: "Online",
            state: "NA",
            street: "NA"),
      );

      if (response!.success) {
        if (isAditionnalMatch) {
          // ignore: use_build_context_synchronously
          upgradeSubscription(
              country: country,
              subsCriptionID: subsCriptionID,
              context: context,
              transactionId: response!.transactionID!,
              paymentMethod: cardList[index],
              packageName: packageName);
        } else {
          additionalMatchRequest(
              country: country,
              additionalMatchRequestsId: subsCriptionID,
              transactionId: response!.transactionID!,
              paymentMethod: cardList[index]);
        }

        //Update SubsCription
        MySubscriptionController mySubscriptionController =
            Get.find<MySubscriptionController>();
        mySubscriptionController.mySubscription();
        profileController.myProfile();

        isLoading = false;
        update();
      } else {
        TostMessage.toastMessage(message: AppStaticStrings.someThingWentWrong);
        isLoading = false;
        update();
      }
    } catch (error) {
      isLoading = false;
      update();
    }
  }

//
//
//Buy Package's
  Future<void> additionalMatchRequest({
    required String additionalMatchRequestsId,
    required String transactionId,
    required String paymentMethod,
    required String country,
  }) async {
    String url =
        "${ApiUrlContainer.baseURL}${ApiUrlContainer.purchesMoreMatch}";
    String responseMethod = ApiResponseMethod.postMethod;

    Map<String, String> body = {
      "additionalMatchRequestsId": additionalMatchRequestsId,
      "transactionId": transactionId,
      "paymentMethod": paymentMethod,
      "country": country
    };

    ApiResponseModel responseModel = await apiService
        .request(url, responseMethod, body, passHeader: true, isRawData: true);

    if (responseModel.statusCode == 201) {
      final SharedPreferences prefs = await SharedPreferences.getInstance();

      await prefs.setBool(SharedPreferenceHelper.isPayment, true);
      //Update SubsCription
      MySubscriptionController mySubscriptionController =
          Get.find<MySubscriptionController>();
      mySubscriptionController.mySubscription();
      profileController.myProfile();
      // ignore: use_build_context_synchronously
      TostMessage.toastMessage(message: responseModel.message);
    } else {
      TostMessage.toastMessage(message: responseModel.message);
    }
  }

  Future<ApiResponseModel> upgradeSubscription({
    required String subsCriptionID,
    required BuildContext context,
    required String transactionId,
    required String paymentMethod,
    required String country,
    required String packageName,
  }) async {
    String url = "${ApiUrlContainer.baseURL}${ApiUrlContainer.mySubscription}";
    String responseMethod = ApiResponseMethod.postMethod;

    Map<String, String> body = {
      "subscriptionId": subsCriptionID,
      "transactionId": transactionId,
      "paymentMethod": paymentMethod,
      "country": country
    };

    ApiResponseModel responseModel = await apiService
        .request(url, responseMethod, body, passHeader: true, isRawData: true);

    if (responseModel.statusCode == 201) {
      final SharedPreferences prefs = await SharedPreferences.getInstance();

      await prefs.setBool(SharedPreferenceHelper.isPayment, true);
      //Update SubsCription
      MySubscriptionController mySubscriptionController =
          Get.find<MySubscriptionController>();
      mySubscriptionController.mySubscription();
      profileController.myProfile();
      // ignore: use_build_context_synchronously
      AllPopUp.paymentSuccessfull(context: context, packageName: packageName);
    } else {
      TostMessage.toastMessage(message: responseModel.message);
    }

    return responseModel;
  }

  @override
  void onInit() {
    getNameAndEmail();
    super.onInit();
  }
}

typedef PaymentCallback = void Function(PaymobResponse response);
