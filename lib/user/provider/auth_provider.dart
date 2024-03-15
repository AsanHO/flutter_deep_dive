import 'package:flutter/cupertino.dart';
import 'package:flutter_deep_dive/user/models/user_model.dart';
import 'package:flutter_deep_dive/user/provider/user_me_provider.dart';
import 'package:flutter_deep_dive/user/repository/user_me_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final authProvider =
    ChangeNotifierProvider<AuthProvider>((ref) => AuthProvider(ref: ref));

class AuthProvider extends ChangeNotifier {
  final Ref ref;

  AuthProvider({required this.ref}) {
    ref.listen<UserModelBase?>(
      userMeProvider,
      (previous, next) {
        if (previous != next) {
          notifyListeners();
        }
      },
    );
  }
  // SplashScreen
  // 앱을 처음 시작했을때 토큰 유무에 따라 라우팅해줘야한다.
  String? redirectLogic(GoRouterState routerState){

    final UserModelBase? userState = ref.read(userMeProvider);

    final isLoginIn = routerState.matchedLocation == '/login';

    if(userState == null){
      return isLoginIn ? null : '/login';
    }
    if (userState is UserModel){
      return isLoginIn || routerState.matchedLocation == '/splash' ?'/':null;
    }
    if (userState is UserModelError){
      return !isLoginIn ? '/login' : null;
    }
    return null;
  }
}
