abstract class ApiBaseHelper {
  Future<dynamic> get(
      {required String url});

  Future<dynamic> post(
      {required String url,
      Map<String, dynamic>? headers,
      Map<String, dynamic> parameters = const {},
      dynamic data = const {},
      String cacheId = ""});

  Future<dynamic> put(
      {required String url,
      Map<String, dynamic>? headers,
      Map<String, dynamic> parameters = const {},
      dynamic data = const {},
      String cacheId = ""});

  Future<dynamic> patch(
      {required String url,
        Map<String, dynamic>? headers,
        Map<String, dynamic> parameters = const {},
        dynamic data = const {},
        String cacheId = ""});

  void clearCaches();
}
