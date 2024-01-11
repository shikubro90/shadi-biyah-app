import 'package:matrimony/core/global/api_response_method.dart';
import 'package:matrimony/core/global/api_response_model.dart';
import 'package:matrimony/core/global/api_url_container.dart';
import 'package:matrimony/core/service/api_service.dart';

class MySubscriptionRepo {
  ApiService apiService;
  MySubscriptionRepo({required this.apiService});

  Future<ApiResponseModel> mySubscriptionRepo() async {
    String url = "${ApiUrlContainer.baseURL}${ApiUrlContainer.mySubscription}";
    String responseMethod = ApiResponseMethod.getMethod;

    ApiResponseModel responseModel =
        await apiService.request(url, responseMethod, null, passHeader: true);

    return responseModel;
  }
}
