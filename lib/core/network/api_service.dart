import 'package:dio/dio.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';


import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:ClickEt/app/constants/api_endpoints.dart';
import 'package:ClickEt/core/network/dio_response_interceptor.dart';

class ApiService {
  final Dio _dio;
  final CookieJar _cookieJar;
  Dio get dio => _dio;

  ApiService(this._dio): _cookieJar = CookieJar()  {
    _dio
      ..options.baseUrl = ApiEndpoints.baseUrl
      ..options.connectTimeout = ApiEndpoints.connectionTimeout
      ..options.receiveTimeout = ApiEndpoints.receiveTimeout
      ..interceptors.add(DioErrorInterceptor())
      ..interceptors.add(PrettyDioLogger(
          requestHeader: true, requestBody: true, responseHeader: true))
      ..interceptors.add(
        CookieManager(_cookieJar),
      )
      ..options.headers = {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      };
  }

  // Get stored cookies
  Future<List<Cookie>> getCookies(String url) async {
    return _cookieJar.loadForRequest(Uri.parse(url));
  }

  // Clear cookies (for logout)
  Future<void> clearCookies() async {
    await _cookieJar.deleteAll();
  }
}
