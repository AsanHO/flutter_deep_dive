import 'package:flutter/material.dart';
import 'package:flutter_deep_dive/common/components/custom_text_form_field.dart';
import 'package:flutter_deep_dive/common/view/splash_screen.dart';
import 'package:flutter_deep_dive/user/provider/auth_provider.dart';
import 'package:flutter_deep_dive/user/view/login_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'common/providers/router_provider.dart';

void main() {
  runApp(
    ProviderScope(
      child: const _App(),
    ),
  );
}

class _App extends ConsumerWidget {
  const _App({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
final router = ref.watch(routerProvider);
    return MaterialApp.router(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(fontFamily: 'NotoSans'),
        routerConfig: router,
    );
  }
}
