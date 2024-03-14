import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_deep_dive/common/const/environments.dart';
import 'package:flutter_deep_dive/common/models/login_response.dart';
import 'package:flutter_deep_dive/common/utils/data_utils.dart';
import 'package:flutter_deep_dive/user/models/user_model.dart';
import 'package:flutter_deep_dive/user/repository/auth_repository.dart';
import 'package:flutter_deep_dive/user/repository/user_me_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UserMeStateNotifier extends StateNotifier<UserModelBase?> {
  final AuthRepository authRepository;
  final UserMeRepository repository;
  final FlutterSecureStorage storage;

  UserMeStateNotifier({
    required this.repository,
    required this.storage,
    required this.authRepository,
  }) : super(UserModelLoading()) {
    getUser();
  }

  Future<void> getUser() async {
    final refreshToken = await storage.read(key: REFRESH_TOKEN_KEY);
    final accessToken = await storage.read(key: ACCESS_TOKEN_KEY);
    if (refreshToken == null || accessToken == null) {
      return;
    }
    final resp = await repository.getUser();
    state = resp;
  }

  Future<UserModelBase> login({
    required String email,
    required String password,
  }) async {
    state = UserModelLoading();

    try {
      final resp = await authRepository.login(
        email: email,
        password: password,
      );

      await storage.write(key: ACCESS_TOKEN_KEY, value: resp.accessToken);
      await storage.write(key: REFRESH_TOKEN_KEY, value: resp.refreshToken);

      final userResp = await repository.getUser();

      state = userResp;

      return userResp;
    } catch (e) {
      state = UserModelError(message: '로그인에 실패했습니다.');

      return Future.value(state);
    }
  }

  Future<void> logout() async {
    state = null;
    Future.wait(
      [
        storage.delete(key: ACCESS_TOKEN_KEY),
        storage.delete(key: REFRESH_TOKEN_KEY)
      ],
    );
  }
}
