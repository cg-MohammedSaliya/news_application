
import 'package:news_application/app/data/data_provider/common/api_data_provider.dart';

class OnBoardingProvider extends ApiDataProvider {
  OnBoardingProvider._();

  static OnBoardingProvider instance = OnBoardingProvider._();

  // Future<bool> login({required String username, required String password}) async {
  //   Map<String, dynamic>? res = await postApi('/instructorlogin', body: {'username': username, 'password': password});
  //   if (res != null) {
  //     LoginResponse loginResponse = LoginResponse.fromJson(res);
  //     ///save token
  //     final prefs = await SharedPreferences.getInstance();
  //     prefs.setInt(cityId, loginResponse.data?[0].intCityId ?? '');
  //     prefs.setString(course, loginResponse.data?[0].course ?? '');
  //     prefs.setString("username", username);
  //
  //     return true;
  //   }
  //   return false;
  // }
}
