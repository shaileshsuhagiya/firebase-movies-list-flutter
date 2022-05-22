import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:mvvm_demo/src/configs/app_configurations.dart';
import 'package:mvvm_demo/src/core/helpers/app_exception.dart';
import 'package:mvvm_demo/src/core/helpers/dio_connectivity_request_retrier.dart';
import 'package:mvvm_demo/src/core/helpers/retry_interceptor.dart';
import 'package:mvvm_demo/src/movie_functionality/business_logic/utils/exception_utility.dart';
import 'package:mvvm_demo/src/movie_functionality/services/web_verbs/api_base_helper.dart';

/// That common base class of Dio API calling like get, post, put, patch method...
class ApiBaseHelperImplementation extends ApiBaseHelper {
  final Dio _dio = Dio(
    BaseOptions(
        followRedirects: true,
        connectTimeout: Config.connectionTimeOut,
        receiveTimeout: Config.readTimeOut),
  );

  late DioCacheManager _dioCacheManager;

  ApiBaseHelperImplementation() {
    _dio.interceptors.add(RetryOnConnectionChangeInterceptor(
        requestRetrier: DioConnectivityRequestRetrier(
      dio: _dio,
    )));
  }

  Options _getCachOptions(
          Map<String, dynamic> headers, String url, String cacheId) =>
      buildCacheOptions(
        const Duration(days: 15),
        maxStale: const Duration(days: 15),
        options: Options(headers: headers),
        primaryKey: cacheId == "" ? url : "${url}_$cacheId",
        forceRefresh: true,
      );

  @override
  void clearCaches() {
    _dioCacheManager.clearAll();
  }

  @override
  Future<dynamic> post(
      {required String url,
      Map<String, dynamic>? headers,
      Map<String, dynamic> parameters = const {},
      dynamic data = const {},
      String cacheId = ""}) async {
    var responseMap;
    try {
      final Response response = await _dio.post(url);

      responseMap = _returnResponse(response);
    } catch (e) {
      throw getCurrentFailure(e);
    }

    return responseMap;
  }

  @override
  Future<dynamic> put(
      {required String url,
      Map<String, dynamic>? headers,
      Map<String, dynamic> parameters = const {},
      dynamic data = const {},
      String cacheId = ""}) async {
    var responseMap;
    try {
      final Response response = await _dio.put(url,
          queryParameters: parameters,
          options: Options(headers: headers ?? {}),
          data: data);

      responseMap = _returnResponse(response);
    } on SocketException {
      throw FetchDataException("No Internet connection");
    } on DioError catch (error) {
      throw getCurrentFailure(error);
    }

    return responseMap;
  }

  @override
  Future<dynamic> patch(
      {required String url,
      Map<String, dynamic>? headers,
      Map<String, dynamic> parameters = const {},
      dynamic data = const {},
      String cacheId = ""}) async {
    var responseMap;
    try {
      final Response response = await _dio.patch(url,
          queryParameters: parameters,
          options: Options(headers: headers ?? {}),
          data: data);

      responseMap = _returnResponse(response);
    } on SocketException {
      throw FetchDataException("No Internet connection");
    } on DioError catch (error) {
      throw getCurrentFailure(error);
    }

    return responseMap;
  }

  Future<dynamic> get({required String url}) async {
    var responseMap;
    try {
      final Response response = await _dio.get(
        url,
      );
      responseMap = _returnResponse(response);
    } catch (e) {
      throw getCurrentFailure(e);
    }

    return responseMap;
  }

  dynamic _returnResponse(Response response) {
    final decodedResponse = response.data;

    if (response.statusCode == 200) {
      return decodedResponse;
    }

    if (response.statusCode != 200) {
      throw BadRequestException("Brand name or key are missing");
    }

    if (response.data.containsKey('status') && response.data['status'] != 1) {
      throw FetchDataException("not found", 404);
    }

    return decodedResponse;
  }

  String getEnumValue(String name) {
    return name.toString().substring(name.toString().indexOf('.') + 1);
  }
}
