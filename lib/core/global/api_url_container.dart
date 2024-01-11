class ApiUrlContainer {
  static const baseURL = "http://103.145.138.78:3009/v1/"; //Local URL

  //Payment Info Stripe
  static const stripeUrl = 'https://api.stripe.com/v1/payment_intents';
  static const stripeSecretKey =
      'Bearer sk_test_51O9nIoHSFV2X1M0tX7A7PXKSreDrfZBT6sgntuK8XCGAieTUeVZYhjcUcmJOsiyKWSOUfFSC9DNpLAxfeizi0Psp00RJk1SK8P';

  static const stripePublishableKey =
      'pk_test_51O9nIoHSFV2X1M0tWjfHXoRLm6Y2qOzTRjn2EErsoHvLeW8Wzk3WnLisaVdHFHcXCGFydr2OfkgPOQA7pYKyZpjq00jKmoZewB';

  static const stripeContentType = 'application/x-www-form-urlencoded';

  //Payment Info Paymob

  static const paymobApiKey =
      'ZXlKaGJHY2lPaUpJVXpVeE1pSXNJblI1Y0NJNklrcFhWQ0o5LmV5SmpiR0Z6Y3lJNklrMWxjbU5vWVc1MElpd2ljSEp2Wm1sc1pWOXdheUk2TVRFNE1EUXhMQ0p1WVcxbElqb2lhVzVwZEdsaGJDSjkuTVdVZE52STU2dHkwTHZEemowaEN5UDg0eVZlMlpOSUdqaHJ1cmR0QVZIeFVFenFEV0Rpc2E1aG9aU2xOWGRIVlBSd3h6X3RTdzR6VDZLakxnX294ZkE=';

  //Test
  static const jazzIdTest = 133071;
  static const easypaisaIDTest = 133074;
  static const cardPKRIDTest = 132996;
  static const cardUSDIDTest = 136140;

  //Live
  static const jazzIdLive = 140532;
  static const easypaisaIDLive = 140535;
  static const cardPkrIDLive = 140529;
  static const cardUSDIDLive = 143247;

  //Others
  static const iFrameID = 146211;
  static const usd = "USD";
  static const pkr = "PKR";

  //Chat (Socket)

  static const socketUrl = "ws://103.145.138.78:3009";
  //Auth
  static const register = "auth/register";
  static const signUpVerifyEmail = "auth/verify-email";
  static const updateProfile = "users/";
  static const resendOTP = "auth/forgot-password";
  static const changePass = "change-password";
  static const resetPassword = "auth/reset-password";
  static const logIn = "auth/login?model=";

  static const sendOtpPhn = "auth/sendOTP";
  static const verifyPhnNumber = "auth/verifyOTP";

  //Home
  static const home = "users/home?page=";

  //Profile
  static const myProfile = "users/";
  static const report = "report";
  static const blockProfile = "blocklist?page=";

  //SubsCription Plan
  static const allPackages = "subscription";
  static const mySubscription = "my-subscription";
  static const purchesMoreMatch = "additional-match-requests/purchase";
  static const getMoreMatchReq = "additional-match-requests";

  //Match
  static const sendMatchRequest = "match-requests";
  static const myMatch = "match-requests?requestType=my-matches&page";

  static const getMatchRequest =
      "match-requests?requestType=match-requests&page=";
  static const acceptMatchReq = "match-requests?matchRequestId=";

  //Send Match Request
  static const sendMatchReq = "match-requests?requestType=sent-requests&page=";
  static const sendReminder = "match-requests/reminder/?matchRequestId=";

  //ShortList
  static const addToShortlist = "shortlisted";
  static const shortlist = "shortlisted?page=";

  //Not Interested
  static const notInterested = "notInterested";

  //Notification
  static const notification = "notification?page=";

  //Block Profile List
  static const blocklist = "blocklist?page=";
  static const unBlocklist = "blocklist?id=";

  //Settings Change Pass
  static const changePassword = "auth/change-password";

  //Log In Activity
  static const logInActivity = "activity";
  static const logOut = "activity/";

  //Delete Account
  static const deleteAccount = "auth/delete-me";

  //Privacy Policy
  static const privacy = "privacy";

  //About
  static const about = "about";

  //Terms and Condition
  static const terms = "terms";

  //Message chat
  static const createChat = "chat";
  static const getChat = "chat";
  static const deleteChat = "chat";
  static const sendMsgInbox = "message/add-message";
  static const inboxChat = "message/get-messages?chatId=";
}
