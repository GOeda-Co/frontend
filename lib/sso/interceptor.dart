import 'package:dio/dio.dart';
import 'package:frontend/sso/storage.dart';

class AuthInterceptor extends Interceptor {
  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await TokenStorage.getToken();
    print("TK HERE");
    print(token);
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      final newToken = await TokenStorage.getToken();
      err.requestOptions.headers['Authorization'] = 'Bearer $newToken';

      final response = await Dio().fetch(err.requestOptions);
      return handler.resolve(response);
    }
  }
}
