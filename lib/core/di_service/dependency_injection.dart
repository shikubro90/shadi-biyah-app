import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:get/get.dart';
import 'package:matrimony/core/global/no_internet/no_internet.dart';
import 'package:matrimony/core/global/payment/payment_controller.dart';
import 'package:matrimony/core/service/api_service.dart';
import 'package:matrimony/view/screens/about_us/about_us_controller/about_us_controller.dart';
import 'package:matrimony/view/screens/auth/sign_in/sign_in_controller/sign_in_controller.dart';
import 'package:matrimony/view/screens/auth/sign_up/screens/about_yourself/about_yourself_controller/about_yourself_controller.dart';
import 'package:matrimony/view/screens/auth/sign_up/screens/carrer_details/carrer_details_controller/carrier_details_controller.dart';
import 'package:matrimony/view/screens/auth/sign_up/screens/mail_otp_verify/otp_controller/otp_controller.dart';
import 'package:matrimony/view/screens/auth/sign_up/screens/upload_photo/upload_photo_controller/upload_photo_controller.dart.dart';
import 'package:matrimony/view/screens/auth/sign_up/sign_up_controller/sign_up_controller.dart';
import 'package:matrimony/view/screens/blocked_profile/blocked_profile_controller/blocked_profile_controller.dart';
import 'package:matrimony/view/screens/home/home_controller/home_controller.dart';
import 'package:matrimony/view/screens/match_request/match_req_controller/match_req_controller.dart';
import 'package:matrimony/view/screens/messages/message_controller/message_controller.dart';
import 'package:matrimony/view/screens/messages/screen/message/inbox/inbox_controller.dart/inbox_controller.dart';
import 'package:matrimony/view/screens/my_matches/my_match_controller/my_match_controller.dart';
import 'package:matrimony/view/screens/my_subscription_plan/my_subscription_controller/my_subscription_controller.dart';
import 'package:matrimony/view/screens/notification/notifiaction_controller/notifiaction_controller.dart';
import 'package:matrimony/view/screens/premium_packages/premium_packages_controller/premium_packages_controller.dart';
import 'package:matrimony/view/screens/privacy_policy/privacy_policy_controller/privacy_policy_controller.dart';
import 'package:matrimony/view/screens/profile/profile_controller/profile_controller.dart';
import 'package:matrimony/view/screens/purches_more_match/pusches_match_controller/pusches_match_controller.dart';
import 'package:matrimony/view/screens/search/search_controller/search_controller.dart';
import 'package:matrimony/view/screens/send_request/send_request_controller/send_request_controller.dart';
import 'package:matrimony/view/screens/settings/login_activity/login_activity_controller/login_activity_controller.dart';
import 'package:matrimony/view/screens/short_listed_profile/short_listed_profile_controller/short_listed_profile_controller.dart';
import 'package:matrimony/view/screens/terms_condition/terms_condition_controller/terms_condition_controller.dart';
import 'package:matrimony/view/screens/user_profile_details/family_details/family_details_controller/family_details_controller.dart';
import 'package:matrimony/view/screens/user_profile_details/life_style/life_style_controller/life_style_controller.dart';
import 'package:matrimony/view/screens/user_profile_details/partner%E2%80%99s_preferences/partner_pre_controller/partner_pre_controller.dart';
import 'package:matrimony/view/screens/auth/sign_up/screens/number_verify/otp_controller/otp_controller.dart';
import 'package:matrimony/view/widget/profile_custom/inner/aboutProfile/personal_details_controller/personal_details_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DependencyInjection extends Bindings {
  downloadPermission() async {
    await FlutterDownloader.initialize(
        debug:
            true, // optional: set to false to disable printing logs to console (default: true)
        ignoreSsl:
            true // option: set to false to disable working with http links (default: false)
        );
  }

  @override
  void dependencies() async {
    //Global Controllers
    final sharedPreference = await SharedPreferences.getInstance();
    Get.lazyPut(() => sharedPreference, fenix: true);
    Get.lazyPut(
        () => ApiService(
              sharedPreferences: Get.find(),
            ),
        fenix: true);
    Get.put(NoInternetController(), permanent: true);

    //Payment Controller

    Get.lazyPut(() => PaymentController(), fenix: true);

    //Auth
    Get.lazyPut(() => SignUpController(), fenix: true);
    Get.lazyPut(() => SignUpOtpController(), fenix: true);
    Get.lazyPut(() => UploadImageController(), fenix: true);
    Get.lazyPut(() => AboutYourSelfController(), fenix: true);
    Get.lazyPut(() => FamilyDetailsController(), fenix: true);
    Get.lazyPut(() => LifeStyleController(), fenix: true);
    Get.lazyPut(() => PartnerPreController(), fenix: true);

    Get.lazyPut(() => SignInController(), fenix: true);

    //Phone Verify
    Get.lazyPut(() => PhnVerifyController(), fenix: true);

    //Home Screen

    Get.lazyPut(
      () => HomeController(),
    );

    //Profile
    Get.lazyPut(() => ProfileController(), fenix: true);
    Get.lazyPut(() => PersonalDetailsController(), fenix: true);
    Get.lazyPut(() => CarrierDetailsController(), fenix: true);

    //Subscription
    Get.lazyPut(() => PremiumPackageController(), fenix: true);
    Get.lazyPut(() => MySubscriptionController(), fenix: true);
    Get.lazyPut(() => PurchesMoreController(), fenix: true);

    //Send Match Req
    Get.lazyPut(() => SendMatchReqController(), fenix: true);

    //Short Listed
    Get.lazyPut(() => ShortListProfileController(), fenix: true);

    //Match Request
    Get.lazyPut(() => MyMatchController(), fenix: true);
    Get.lazyPut(() => MatchReqController(), fenix: true);

    //Notification
    Get.lazyPut(() => NotificationController(), fenix: true);

    //Blocked Profile List
    Get.lazyPut(() => BlockedProfileController(), fenix: true);

    //LogIn Activity
    Get.lazyPut(() => LogInActivityController(), fenix: true);

    //Privacy Policy
    Get.lazyPut(() => PrivacyPolicyController(), fenix: true);

    //Terms and Condition
    Get.lazyPut(() => TermsAndConditionController(), fenix: true);

    //Privacy Policy
    Get.lazyPut(() => AboutUsController(), fenix: true);

    //Search
    Get.lazyPut(() => SearchUserController(), fenix: true);

    //Message
    Get.lazyPut(() => MessageController(), fenix: true);
    Get.lazyPut(() => InboxController(), fenix: true);
  }

  disposeController() {
    if (Get.isRegistered<HomeController>()) {
      HomeController homeController = Get.find<HomeController>();
      homeController.dispose();
    }
  }
}
