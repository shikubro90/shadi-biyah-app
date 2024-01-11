import 'package:matrimony/core/global/api_response_method.dart';
import 'package:matrimony/core/global/api_response_model.dart';
import 'package:matrimony/core/global/api_url_container.dart';
import 'package:matrimony/core/helper/sharedpreference_helper.dart';
import 'package:matrimony/core/service/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyProfileRepo {
  ApiService apiService;
  MyProfileRepo({required this.apiService});

  Future<ApiResponseModel> myProfileRepo() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? userID = prefs.getString(SharedPreferenceHelper.userIdKey);
    String url =
        "${ApiUrlContainer.baseURL}${ApiUrlContainer.myProfile}$userID";
    String responseMethod = ApiResponseMethod.getMethod;

    ApiResponseModel responseModel =
        await apiService.request(url, responseMethod, null, passHeader: true);

    return responseModel;
  }
}
