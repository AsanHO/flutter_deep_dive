import 'package:dio/dio.dart';
import 'package:flutter_deep_dive/common/const/environments.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class CustomInterceptor extends Interceptor {
  final FlutterSecureStorage storage;

  CustomInterceptor({required this.storage});

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    print('[REQ] [${options.method}] ${options.uri}');

    if (options.headers['accessToken'] == 'true') {
      // 헤더 삭제
      options.headers.remove('accessToken');

      final token = await storage.read(key: ACCESS_TOKEN_KEY);

      // 실제 토큰으로 대체
      options.headers.addAll({
        'authorization': 'Bearer $token',
      });
    }

    if (options.headers['refreshToken'] == 'true') {
      // 헤더 삭제
      options.headers.remove('refreshToken');

      final token = await storage.read(key: REFRESH_TOKEN_KEY);

      // 실제 토큰으로 대체
      options.headers.addAll({
        'authorization': 'Bearer $token',
      });
    }

    return super.onRequest(options, handler);
  }
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async{
    print('ERR [${err.requestOptions.method}] [${err.requestOptions.uri}]');

    final refreshToken = await storage.read(key: REFRESH_TOKEN_KEY);

    if (refreshToken == null){
      return handler.reject(err);
    }

    final isStatus401 = err.response?.statusCode == 401;

    final isPathRefresh = err.requestOptions.path == '/auth/token';
    if(isStatus401 && !isPathRefresh){
      final dio = Dio();

      try{
        final resp = await dio.post(
          '$IP/auth/token',
          options: Options(
            headers: {
              'authorization': 'Bearer $refreshToken',
            },
          ),
        );

        final accessToken = resp.data['accessToken'];

        final options = err.requestOptions;

        // 토큰 변경하기
        options.headers.addAll({
          'authorization': 'Bearer $accessToken',
        });

        await storage.write(key: ACCESS_TOKEN_KEY, value: accessToken);

        // 요청 재전송
        final response = await dio.fetch(options);

        return handler.resolve(response);
      }on DioException catch(e){
        return handler.reject(e);
      }
    }
    return super.onError(err, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    print('RES [${response.requestOptions.method}] [${response.requestOptions.uri}]');
    // TODO: implement onResponse
    super.onResponse(response, handler);
  }
}
