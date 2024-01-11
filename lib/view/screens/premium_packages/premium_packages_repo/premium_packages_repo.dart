import 'package:matrimony/core/global/api_response_method.dart';
import 'package:matrimony/core/global/api_response_model.dart';
import 'package:matrimony/core/global/api_url_container.dart';
import 'package:matrimony/core/service/api_service.dart';

class PremiumPackageRepo {
  ApiService apiService;
  PremiumPackageRepo({required this.apiService});

  Future<ApiResponseModel> premiumPackageRepo() async {
    String url = "${ApiUrlContainer.baseURL}${ApiUrlContainer.allPackages}";
    String responseMethod = ApiResponseMethod.getMethod;

    ApiResponseModel responseModel =
        await apiService.request(url, responseMethod, null, passHeader: true);

    return responseModel;
  }
}
