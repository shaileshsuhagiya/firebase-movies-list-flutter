import 'dart:async';

import 'package:dio/dio.dart';

class DioConnectivityRequestRetrier {
  final Dio dio;

  DioConnectivityRequestRetrier({required this.dio});

  Future<Response> scheduleRequestRetry(RequestOptions requestOptions) async {
    final responseCompleter = Completer<Response>();
    final options = Options(
      method: requestOptions.method,
      headers: requestOptions.headers,
    );

    return responseCompleter.future;
  }
}
