import 'package:matrimony/core/global/api_response_method.dart';
import 'package:matrimony/core/global/api_response_model.dart';
import 'package:matrimony/core/global/api_url_container.dart';
import 'package:matrimony/core/service/api_service.dart';

class LogInActivityRepo {
  ApiService apiService;
  LogInActivityRepo({required this.apiService});

  Future<ApiResponseModel> loginActivityRepo() async {
    String url = "${ApiUrlContainer.baseURL}${ApiUrlContainer.logInActivity}";
    String responseMethod = ApiResponseMethod.getMethod;

    ApiResponseModel responseModel =
        await apiService.request(url, responseMethod, null, passHeader: true);

    return responseModel;
  }
}
