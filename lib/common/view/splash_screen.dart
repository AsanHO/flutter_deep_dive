import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_deep_dive/common/const/colors.dart';
import 'package:flutter_deep_dive/common/const/environments.dart';
import 'package:flutter_deep_dive/common/layout/default_layout.dart';
import 'package:flutter_deep_dive/common/view/root_tab.dart';
import 'package:flutter_deep_dive/user/view/login_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SplashScreen extends ConsumerWidget {
  static String get routeName => 'splash';
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    return DefaultLayout(
      backgroundColor: PRIMARY_COLOR,
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'asset/img/logo/logo.png',
              width: MediaQuery.of(context).size.width / 2,
            ),
            const SizedBox(height: 16.0),
            CircularProgressIndicator(
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}