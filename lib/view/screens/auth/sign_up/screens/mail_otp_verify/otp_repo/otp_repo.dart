import 'package:matrimony/core/global/api_response_method.dart';
import 'package:matrimony/core/global/api_response_model.dart';
import 'package:matrimony/core/global/api_url_container.dart';
import 'package:matrimony/core/service/api_service.dart';

class SignUpOtpRepo {
  ApiService apiService;
  SignUpOtpRepo({required this.apiService});

  Future<ApiResponseModel> signUpOtpRepo({
    required String email,
    required String oneTimeCode,
  }) async {
    String url =
        "${ApiUrlContainer.baseURL}${ApiUrlContainer.signUpVerifyEmail}";
    String responseMethod = ApiResponseMethod.postMethod;
    Map<String, dynamic> params = {
      "email": email,
      "oneTimeCode": oneTimeCode,
    };

    ApiResponseModel responseModel = await apiService
        .request(url, responseMethod, params, passHeader: false);

    return responseModel;
  }
}
