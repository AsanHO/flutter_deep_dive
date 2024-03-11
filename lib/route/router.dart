import 'package:flutter_deep_dive/screens/basic_screen.dart';
import 'package:flutter_deep_dive/screens/root_screen.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => RootScreen(),
      routes: [
        GoRoute(path: 'basic',builder: (_,__) => BasicScreen()),
        GoRoute(path: 'named',name:'named_screen',builder: (_,__) => BasicScreen())
      ]
    )
  ],
);
