import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_deep_dive/common/const/environments.dart';
import 'package:flutter_deep_dive/common/dio/dio.dart';
import 'package:flutter_deep_dive/common/models/login_response.dart';
import 'package:flutter_deep_dive/common/models/token_response.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final dio = ref.watch(dioProvider);
  return AuthRepository(baseUrl: IP, dio: dio);
});

class AuthRepository {
  final String baseUrl;
  final Dio dio;

  AuthRepository({
    required this.baseUrl,
    required this.dio,
  });

  Future<LoginResponse> login({
    required String email,
    required String password,
  }) async {
    Codec<String, String> stringToBase64 = utf8.fuse(base64);

    String token = stringToBase64.encode('$email:$password');
    final resp = await dio.post(
      "$IP/auth/login",
      options: Options(
        headers: {'authorization': 'Basic $token'},
      ),
    );

    return LoginResponse.fromJson(resp.data);
  }

  Future<TokenResponse> token() async {
    final resp = await dio.post('$baseUrl/token',
        options: Options(headers: {'refreshToken': 'true'}));
    return TokenResponse.fromJson(resp.data);
  }
}
