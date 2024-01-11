import 'package:matrimony/core/global/api_response_method.dart';
import 'package:matrimony/core/global/api_response_model.dart';
import 'package:matrimony/core/global/api_url_container.dart';
import 'package:matrimony/core/service/api_service.dart';

class SendReqRepo {
  ApiService apiService;
  SendReqRepo({required this.apiService});

  Future<ApiResponseModel> sendReqRepo({required String pageNum}) async {
    String url =
        "${ApiUrlContainer.baseURL}${ApiUrlContainer.sendMatchReq}$pageNum";
    String responseMethod = ApiResponseMethod.getMethod;

    ApiResponseModel responseModel =
        await apiService.request(url, responseMethod, null, passHeader: true);

    return responseModel;
  }
}
