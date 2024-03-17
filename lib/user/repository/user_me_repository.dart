import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_deep_dive/common/const/environments.dart';
import 'package:flutter_deep_dive/common/dio/dio.dart';
import 'package:flutter_deep_dive/user/models/user_model.dart';
import 'package:retrofit/http.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_me_repository.g.dart';

final userMeRepositoryProvider = Provider<UserMeRepository>((ref) {
  final dio = ref.watch(dioProvider);

  return UserMeRepository(dio, baseUrl: IP);
});

@RestApi()
abstract class UserMeRepository {
  factory UserMeRepository(Dio dio, {String baseUrl}) = _UserMeRepository;

  @GET('/user/me')
  @Headers({'accessToken': 'true'})
  Future<UserModel> getUser();
}
