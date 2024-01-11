import 'package:matrimony/core/global/api_response_method.dart';
import 'package:matrimony/core/global/api_response_model.dart';
import 'package:matrimony/core/global/api_url_container.dart';
import 'package:matrimony/core/service/api_service.dart';

class SearchRepo {
  ApiService apiService;
  SearchRepo({required this.apiService});

  Future<ApiResponseModel> searchRepo({
    required int pageNum,
    required String name,
    required String partnerMinHeight,
    required String partnerMixHeight,
    required String partnerMaritalStatus,
    required String partnerCountry,
    required String partnerCity,
    required String partnerReligion,
    required String partnerCaste,
    required String partnerResidentialStatus,
    required String partnerMotherTongue,
    required String partnerMinAge,
    required String partnerMixAge,
  }) async {
    String url =
        "${ApiUrlContainer.baseURL}users/home?name=$name&sect=$partnerCaste&religion=$partnerReligion&maritalStatus=$partnerMaritalStatus&motherTongue=$partnerMotherTongue&city=$partnerCity&country=$partnerCountry&residentialStatus=$partnerResidentialStatus&ageMin=$partnerMinAge&ageMax=$partnerMixAge&heightMin=$partnerMinHeight&heightMax=$partnerMixHeight&page=$pageNum";
    String responseMethod = ApiResponseMethod.getMethod;

    ApiResponseModel responseModel =
        await apiService.request(url, responseMethod, null, passHeader: true);

    return responseModel;
  }
}
