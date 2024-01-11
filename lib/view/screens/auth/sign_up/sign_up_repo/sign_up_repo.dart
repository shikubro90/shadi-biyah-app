import 'package:matrimony/core/global/api_response_method.dart';
import 'package:matrimony/core/global/api_response_model.dart';
import 'package:matrimony/core/global/api_url_container.dart';
import 'package:matrimony/core/service/api_service.dart';

class SignUpRepo {
  ApiService apiService;
  SignUpRepo({required this.apiService});

  Future<ApiResponseModel> createUser({
    required String name,
    required String email,
    required String password,
    required String phoneNumber,
    required String gender,
    required String profileFor,
    required String dataOfBirth,
    required String height,
    required String country,
    required String city,
    required String state,
    required String residentialStatus,
    required String education,
    required String workExperience,
    required String occupation,
    required String income,
    required String maritalStatus,
    required String motherTongue,
    required String religion,
    required String caste,
    required String sect,
  }) async {
    String url = "${ApiUrlContainer.baseURL}${ApiUrlContainer.register}";
    String responseMethod = ApiResponseMethod.postMethod;
    Map<String, dynamic> params = {
      "name": name,
      "email": email,
      "phoneNumber": phoneNumber,
      "password": password,
      "role": "user",
      "gender": gender,
      "profileFor": profileFor,
      "dataOfBirth": dataOfBirth,
      "height": height,
      "country": country,
      "state": state,
      "city": city,
      "residentialStatus": residentialStatus,
      "education": education,
      "workExperience": workExperience,
      "occupation": occupation,
      "income": income,
      "maritalStatus": maritalStatus,
      "motherTongue": motherTongue,
      "religion": religion,
      "caste": caste,
      "sect": sect
    };

    ApiResponseModel responseModel = await apiService
        .request(url, responseMethod, params, passHeader: false);

    return responseModel;
  }
}
