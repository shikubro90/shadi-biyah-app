import 'package:get/get.dart';
import 'package:matrimony/view/screens/auth/sign_up/screens/mail_otp_verify/otp_repo/otp_repo.dart';
import 'package:matrimony/view/screens/auth/sign_up/sign_up_controller/sign_up_controller.dart';
import 'package:matrimony/view/screens/auth/sign_up/screens/number_verify/send_otp_repo/send_otp_repo.dart';

class PhnVerifyController extends GetxController {
  SignUpController signUpController = Get.find<SignUpController>();
  String oneTimeCode = "";
  SignUpOtpRepo signUpOtpRepo = SignUpOtpRepo(apiService: Get.find());

  bool isLoading = false;

  Future<void> verifyPhnOtp() async {
    isLoading = true;
    update();

    await SendOtpNum.verifyOTP(otpCode: oneTimeCode);

    isLoading = false;
    update();
  }
}
