import 'package:flutter/cupertino.dart';
import 'package:flutter_deep_dive/common/view/root_tab.dart';
import 'package:flutter_deep_dive/common/view/root_tab.dart';
import 'package:flutter_deep_dive/common/view/splash_screen.dart';
import 'package:flutter_deep_dive/restaurant/view/restaurant_detail_screen.dart';
import 'package:flutter_deep_dive/restaurant/view/restaurant_detail_screen.dart';
import 'package:flutter_deep_dive/user/models/user_model.dart';
import 'package:flutter_deep_dive/user/provider/user_me_provider.dart';
import 'package:flutter_deep_dive/user/repository/user_me_repository.dart';
import 'package:flutter_deep_dive/user/view/login_screen.dart';
import 'package:flutter_deep_dive/user/view/login_screen.dart';
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
  String? redirectLogic(BuildContext context,GoRouterState routerState) {
    final UserModelBase? userState = ref.read(userMeProvider);

    final isLoginIn = routerState.matchedLocation == '/login';

    if (userState is UserModelLoading) {
      return isLoginIn ? null : '/login';
    }
    if (userState is UserModel) {
      return isLoginIn || routerState.matchedLocation == '/splash' ? '/' : null;
    }
    if (userState is UserModelError) {
      return !isLoginIn ? '/login' : null;
    }
    return null;
  }

  List<GoRoute> get routes => [
        GoRoute(
          path: '/',
          name: RootTab.routeName,
          builder: (_, __) => const RootTab(),
          routes: [
            GoRoute(
              path: 'restaurant/:id',
              name: RestaurantDetailScreen.routeName,
              builder: (_, state) => RestaurantDetailScreen(
                id: state.pathParameters['id']!,
                title: state.pathParameters['title']!,
              ),
            ),
          ],
        ),
        GoRoute(
          path: '/splash',
          name: SplashScreen.routeName,
          builder: (_, __) => const SplashScreen(),
        ),
        GoRoute(
          path: '/login',
          name: LoginScreen.routeName,
          builder: (_, __) => const LoginScreen(),
        )
      ];

  Future<void> logout() async {
    ref.read(userMeProvider.notifier).logout();
  }
}
