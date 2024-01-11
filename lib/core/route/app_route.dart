import 'package:get/get.dart';
import 'package:matrimony/view/screens/about_us/about_us.dart';
import 'package:matrimony/view/screens/auth/sign_in/screens/OtpSignIn/otp_sign_in.dart';
import 'package:matrimony/view/screens/auth/sign_in/screens/forget_pass/forget_pass.dart';
import 'package:matrimony/view/screens/auth/sign_in/screens/reset_pass/reset_pass.dart';
import 'package:matrimony/view/screens/auth/sign_in/screens/sign_in.dart';
import 'package:matrimony/view/screens/auth/sign_up/screens/about_yourself/about_yourself.dart';
import 'package:matrimony/view/screens/auth/sign_up/screens/carrer_details/carrer_details.dart';
import 'package:matrimony/view/screens/auth/sign_up/screens/create_profile_for/create_profile_for.dart';
import 'package:matrimony/view/screens/auth/sign_up/screens/login_details/login_details.dart';
import 'package:matrimony/view/screens/auth/sign_up/screens/mail_otp_verify/otp_verify.dart';
import 'package:matrimony/view/screens/auth/sign_up/screens/personal_details/personal_details.dart';
import 'package:matrimony/view/screens/auth/sign_up/screens/social_details/social_details.dart';
import 'package:matrimony/view/screens/auth/sign_up/screens/upload_photo/upload_photo.dart';
import 'package:matrimony/view/screens/blocked_profile/blocked_profile.dart';
import 'package:matrimony/view/screens/home/home.dart';
import 'package:matrimony/view/screens/match_request/match_request.dart';
import 'package:matrimony/view/screens/messages/screen/message/inbox/inbox.dart';
import 'package:matrimony/view/screens/messages/screen/no_msg_screen/inner_widget/message_suggest.dart';
import 'package:matrimony/view/screens/my_matches/matches_navigate.dart';
import 'package:matrimony/view/screens/messages/screen/message_navigator.dart';
import 'package:matrimony/view/screens/my_subscription_plan/my_subscription_plan.dart';
import 'package:matrimony/view/screens/no_internet/no_internet.dart';
import 'package:matrimony/view/screens/notification/notification.dart';
import 'package:matrimony/view/screens/onboarding/onboarding.dart';
import 'package:matrimony/view/screens/payment/payment.dart';
import 'package:matrimony/view/screens/premium_packages/premium_packages.dart';
import 'package:matrimony/view/screens/privacy_policy/privacy_policy.dart';
import 'package:matrimony/view/screens/profile/profile.dart';
import 'package:matrimony/view/screens/profile_details/profile_details.dart';
import 'package:matrimony/view/screens/purches_more_match/purches_more_match.dart';
import 'package:matrimony/view/screens/search/search.dart';
import 'package:matrimony/view/screens/send_request/send_request.dart';
import 'package:matrimony/view/screens/settings/change_pass/change_pass.dart';
import 'package:matrimony/view/screens/settings/delete/delete.dart';
import 'package:matrimony/view/screens/settings/forget_pass/forget_pass.dart';
import 'package:matrimony/view/screens/settings/login_activity/login_activity.dart';
import 'package:matrimony/view/screens/settings/otp_settings/otp_settings.dart';
import 'package:matrimony/view/screens/settings/reset_pass_setting/reset_pass_setting.dart';
import 'package:matrimony/view/screens/settings/settings.dart';
import 'package:matrimony/view/screens/short_listed_profile/short_listed_profile.dart';
import 'package:matrimony/view/screens/splash/splash.dart';
import 'package:matrimony/view/screens/terms_condition/terms_condition.dart';
import 'package:matrimony/view/screens/upgrade_package_card/upgrade_package_card.dart';
import 'package:matrimony/view/screens/user_profile_details/family_details/family_details.dart';
import 'package:matrimony/view/screens/user_profile_details/life_style/life_style.dart';
import 'package:matrimony/view/screens/user_profile_details/partner%E2%80%99s_preferences/partner_preferences.dart';
import 'package:matrimony/view/widget/image_view/image_view.dart';
import 'package:matrimony/view/widget/nav_bar/nav_bar.dart';
import 'package:matrimony/view/widget/profile_custom/inner/aboutProfile/about_personal_details/about_personal_details.dart';
import 'package:matrimony/view/widget/profile_custom/inner/aboutProfile/contact_info/contact_info.dart';
import 'package:matrimony/view/screens/auth/sign_up/screens/number_verify/otp_verify_phn.dart';

class AppRoute {
  //splashScreen
  static const String splashScreen = "/splash_screen";
  //onboarding
  static const String onboarding = "/onboarding_screen";
  //Sign In
  static const String signIn = "/signIn_screen";
  static const String forgetPass = "/forgetPass";
  static const String otpSignin = "/otp_signin";
  static const String resetPassSignIn = "/reset_Password";
  //Sign up
  static const String aboutYourSelf = "/aboutYourSelf";
  static const String carrerDetails = "/carrerDetails";
  static const String createProfileFor = "/createProfileFor";
  static const String logInDetails = "/logInDetails";
  static const String otpSignUp = "/otpSignUp";
  static const String personalDetails = "/personalDetails";
  static const String socailaDetails = "/socailaDetails";
  static const String uploadPhoto = "/uploadPhoto";
  //User Profile Details
  static const String familyDetails = "/familyDetails";
  static const String lifeStyle = "/lifeStyle";
  static const String partnerPreferences = "/partnerPreferences";
  //NavBar
  static const String navBar = "/navBar";
  static const String home = "/home";
  static const String matchesNavigate = "/matches";
  static const String messageNavigate = "/messageNavigate";
  static const String profile = "/profile";
  //Message Suggest
  static const String messageSuggest = "/messageSuggest";
  static const String inbox = "/inbox";
  //Home Drawer Screen
  static const String matchRequest = "/match_request";
  static const String sentRequest = "/sentRequest";
  static const String shortListedProfile = "/shortListedProfile";
  static const String blockProfile = "/blockProfile";
  static const String settings = "/settings";
  static const String privacyPolicy = "/privacyPolicy";
  static const String termsCondition = "/termsCondition";
  static const String aboutUs = "/aboutUs";
  static const String premiumPackages = "/premiumPackages";
  static const String mySubscriptionPlan = "/mySubscriptionPlan";

  //Profile Details
  static const String profileDetails = "/profileDetails";
  static const String aboutContactInformation = "/about_Contact_Information";
  static const String imageView = "/image_View";

  static const String aboutProfileDetails = "/about_Profile_Details";

  //Notification
  static const String notification = "/notification";

  //Settings Inner Screen
  static const String changePassSetting = "/changePass";
  static const String forgetPassSettings = "/forgetPassSettings";
  static const String otpSettings = "/otpSettings";
  static const String resetPasswordSetting = "/resetPassSettings";
  static const String deleteAccount = "/deleteAccount";
  static const String loginActivity = "/loginActivity";

  //No Internet
  static const String noInternet = "/no_Internet";

  //Search
  static const String search = "/search";

  //Premium Package's
  static const String upgradePackageCard = "/upgradePackageCard";
  static const String payment = "/payment";

  //Others
  static const String purchesMoreMatch = "/PurchesMoreMatch";
  static const String otpVerifyPhn = "/otp_verify_phn";

  static List<GetPage> routes = [
    //Splash
    GetPage(name: splashScreen, page: () => const SplashScreen()),

    //Onboarding
    GetPage(name: onboarding, page: () => const Onboarding()),

    //Auth Screens
    /////Sign in
    GetPage(name: signIn, page: () => const SignInScreen()),
    GetPage(name: forgetPass, page: () => const ForgetPassword()),
    GetPage(name: otpSignin, page: () => const OtpSignIn()),
    GetPage(name: resetPassSignIn, page: () => const ResetPassword()),
    /////Sign Up
    GetPage(name: aboutYourSelf, page: () => const AboutYourSelf()),
    GetPage(name: carrerDetails, page: () => const CarrerDetails()),
    GetPage(name: createProfileFor, page: () => const CreateProfileFor()),
    GetPage(name: logInDetails, page: () => const LogInDetails()),
    GetPage(name: otpSignUp, page: () => const OtpVerifySignUp()),
    GetPage(name: personalDetails, page: () => const PersonalDetails()),
    GetPage(name: socailaDetails, page: () => const SocialDetails()),
    GetPage(name: uploadPhoto, page: () => const UploadPhoto()),
    //User Profile Details
    GetPage(name: familyDetails, page: () => const FamilyDetails()),
    GetPage(name: lifeStyle, page: () => const LifeStyle()),
    GetPage(name: partnerPreferences, page: () => const PartnerPreferences()),
    GetPage(name: home, page: () => const HomeScreen()),
    GetPage(name: matchesNavigate, page: () => const MatchesNavigate()),
    GetPage(name: messageNavigate, page: () => const MessageNavigator()),
    GetPage(name: profile, page: () => const Profile()),
    //Message Suggest
    GetPage(name: messageSuggest, page: () => const MessageSuggest()),
    GetPage(name: inbox, page: () => const Inbox()),
    //Home Drawer Screen
    GetPage(name: matchRequest, page: () => const MatchRequest()),
    GetPage(name: sentRequest, page: () => const SentRequest()),
    GetPage(name: shortListedProfile, page: () => const ShortListedProfile()),
    GetPage(name: blockProfile, page: () => const BlockedProfile()),
    GetPage(name: aboutUs, page: () => const AboutUS()),
    GetPage(name: privacyPolicy, page: () => const PrivacyPolicy()),
    GetPage(name: termsCondition, page: () => const TermCondition()),
    GetPage(name: premiumPackages, page: () => const PremiumPackages()),
    GetPage(name: mySubscriptionPlan, page: () => const MySubsCriptionPlan()),

    //notification
    GetPage(name: notification, page: () => const NotificationScreen()),
    //Profile Details
    GetPage(name: profileDetails, page: () => const ProfileDetails()),
    GetPage(
        name: aboutProfileDetails,
        page: () => const AboutEditPersonalDetails()),
    GetPage(name: profileDetails, page: () => const ProfileDetails()),
    GetPage(
        name: aboutContactInformation, page: () => const AboutContactInfo()),
    GetPage(name: imageView, page: () => const ImageView()),

    //Purches More Match
    GetPage(name: purchesMoreMatch, page: () => const PurchesMoreMatch()),
    //Settings and Inner
    GetPage(name: settings, page: () => const Settings()),
    GetPage(name: changePassSetting, page: () => const ChangePasswordSetting()),
    GetPage(name: forgetPassSettings, page: () => const ForgetPassSetting()),
    GetPage(name: otpSettings, page: () => const OTPSettings()),
    GetPage(
        name: resetPasswordSetting, page: () => const ResetPasswordSetting()),
    GetPage(name: deleteAccount, page: () => const DeleteAccount()),
    GetPage(name: loginActivity, page: () => const LoginActivity()),
    //Premium Package's
    GetPage(name: upgradePackageCard, page: () => const UpgradePackageCard()),
    GetPage(name: payment, page: () => const Payment()),

    //Search
    GetPage(name: search, page: () => const SearchScreen()),
    GetPage(
        name: navBar,
        page: () => const NavBar(
              currentIndex: 0,
            )),

    //No Internet
    GetPage(name: noInternet, page: () => const NoInternet()),

    //Others
    GetPage(name: otpVerifyPhn, page: () => const OtpVerifyPhn()),
  ];
}
