import 'dart:io';

import 'package:dio/dio.dart';
import 'dio_connectivity_request_retrier.dart';

class RetryOnConnectionChangeInterceptor extends Interceptor {
  final DioConnectivityRequestRetrier requestRetrier;

  RetryOnConnectionChangeInterceptor({
    required this.requestRetrier,
  });
  @override
  Future onError(DioError err, ErrorInterceptorHandler handler) async {
    if (_shouldRetry(err)) {
      try {
        print("******* Retry Inceptor ****************");
        requestRetrier.scheduleRequestRetry(err.requestOptions);
      } catch (e) {
        return e;
      }
    }

    return super.onError(err, handler);
  }

  bool _shouldRetry(DioError error) {
    return error.type == DioErrorType.other &&
        error.error != null &&
        error.error is SocketException;
  }
}
