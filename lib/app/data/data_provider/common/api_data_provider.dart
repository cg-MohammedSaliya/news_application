import 'package:connectivity_plus/connectivity_plus.dart';
import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:news_application/app/ui/my_snackbar.dart';
import 'package:shared_preferences/shared_preferences.dart';

// const kIdToken = 'MilesOneConnect';

enum RestApiMethod { get, put, post }

class ApiDataProvider {

  //Live
  // var dio = Dio(BaseOptions(baseUrl: 'https://cpa-api.mileseducation.com'));

  //UAT
  var dio = Dio(BaseOptions(baseUrl: 'https://newsapi.org/v2/'));

  Future<String?> get baseUrl async {
    final prefs = await SharedPreferences.getInstance();
  }

  Future<Map<String, String>> getHeader() async {
    final prefs = await SharedPreferences.getInstance();
    final Map<String, String> headers = {
      'Authorization': "",
      'Content-Type': 'application/json',
    };
    return headers;
  }

  Future<bool> isInternetConnected() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      /// I am connected to a mobile network.
      return true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      /// I am connected to a wifi network.
      return true;
    }
    return false;
  }

  showError(DioError e) {
    try {
      showSnackBar(jsonDecode(e.response.toString())['message'] ?? e.message, isError: true);
    } catch (error) {
      showSnackBar(e.message, isError: true);
    }
  }

  Future<bool> isError(Response response, bool showError) async {
    if (!(await isInternetConnected())) {
      showSnackBar('NO INTERNET CONNECTION', isError: null);
      return true;
    }

    Map x = {};
    if (response.data is Map) x = response.data as Map;
    bool isError = !(x['status'] is bool ? x['status'] : true) || !(x['success'] is bool ? x['success'] : true);
    int statusCode = response.statusCode ?? 0;
    if (statusCode < 200 || statusCode >= 300 || isError) {
      if (showError) {
        showSnackBar(
          "${x['message'] ?? '${response.statusCode ?? ''} Something Went Wrong'}",
          isError: true,
        );
      }
      return true;
    } else {
      return false;
    }
  }

  Future<Map<String, dynamic>?> restApi<T>(
    String path, {
    String? baseUrl,
    required RestApiMethod apiMethod,
    dynamic body = const {},

    ///[attachToken] is for defining whether to attach token in the header or not
    bool attachToken = false,
    bool showError = true,
  }) async {
    try {

      String? url = await this.baseUrl;
      if (url != null) {
        ///if user chooses to send a different base url
        //Live
        // dio.options.baseUrl = 'https://$url-api.mileseducation.com';

        //UAT
        dio.options.baseUrl = 'https://$url-api-uat.mileseducation.com';

      }
      if (baseUrl != null) {
        ///if user chooses to send a different base url
        dio.options.baseUrl = baseUrl;
      }

      ///logging the POST endpoint and PAYLOAD
      log('${dio.options.baseUrl}$path', name: '$apiMethod');
      // if (body is! FormData) log(body.toString(), name: "PAYLOAD");
      ///checking if the internet is connected or not
      if (!(await isInternetConnected())) {
        showSnackBar('NO INTERNET CONNECTION', isError: null);
        return null;
      }

      ///Hitting the POST request
      Response<T>? response;
      switch (apiMethod) {
        case RestApiMethod.get:
          response = await dio.get(
            path,
            options: attachToken ? Options(headers: await getHeader()) : null,
          );
          break;
        case RestApiMethod.put:
          response = await dio.put(
            path,
            data: body,
            options: attachToken ? Options(headers: await getHeader()) : null,
          );
          break;
        case RestApiMethod.post:
          response = await dio.post(
            path,
            data: body,
            options: attachToken ? Options(headers: await getHeader()) : null,
          );
          break;
        default:
          break;
      }

      ///logging the RESPONSE details
      log('${response?.data}', name: "RESPONSE");
      log('${response?.statusCode}', name: "RESPONSE STATUS CODE");

      ///if nor error then return response else return NUll
      if (response != null) {
        await isError(response, showError);
        if (response.data is Map?) {
          Map<String, dynamic>? x = response.data as Map<String, dynamic>?;
          return x;
        }
      }
    } on DioError catch (e) {
      ///if exception show the error
      log('${e.response}', name: 'DIO EXCEPTION');
      if (showError) this.showError(e);
    }
    return null;
  }

  Future<Map<String, dynamic>?> postApi<T>(
    String path, {
    String? baseUrl,
    required dynamic body,
    bool attachToken = false,
    bool showError = true,
  }) async {
    return await restApi(
      path,
      baseUrl: baseUrl,
      body: body,
      attachToken: attachToken,
      apiMethod: RestApiMethod.post,
      showError: showError,
    );
  }

  Future<Map<String, dynamic>?> getApi<T>(
    String path, {
    String? baseUrl,
    bool attachToken = false,
    bool showError = true,
  }) async {
    return await restApi(
      path,
      baseUrl: baseUrl,
      attachToken: attachToken,
      apiMethod: RestApiMethod.get,
      showError: showError,
    );
  }

  Future<Map<String, dynamic>?> putApi<T>(
    String path, {
    String? baseUrl,
    required dynamic body,
    bool attachToken = false,
    bool showError = true,
  }) async {
    return await restApi(
      path,
      baseUrl: baseUrl,
      body: body,
      attachToken: attachToken,
      apiMethod: RestApiMethod.put,
      showError: showError,
    );
  }
}

