import 'package:flutter_deep_dive/common/const/environments.dart';
import 'package:flutter_deep_dive/user/models/user_model.dart';
import 'package:flutter_deep_dive/user/repository/user_me_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UserMeStateNotifier extends StateNotifier<UserModelBase?> {
  final UserMeRepository repository;
  final FlutterSecureStorage storage;

  UserMeStateNotifier({required this.repository, required this.storage})
      : super(null) {
    getUser();
  }

  Future<void> getUser() async {
    final refreshToken = await storage.read(key: REFRESH_TOKEN_KEY);
    final accessToken = await storage.read(key: ACCESS_TOKEN_KEY);
    if (refreshToken == null || accessToken == null) {
      state = null;
      return;
    }
    final resp = await repository.getUser();
    state = resp;
  }
}
