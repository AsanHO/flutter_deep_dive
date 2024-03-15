import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_deep_dive/common/components/custom_text_form_field.dart';
import 'package:flutter_deep_dive/common/const/colors.dart';
import 'package:flutter_deep_dive/common/const/environments.dart';
import 'package:flutter_deep_dive/common/layout/default_layout.dart';
import 'package:flutter_deep_dive/common/view/root_tab.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LoginScreen extends StatefulWidget {
  static String  get routeName =>'login';

  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final dio = Dio();
  final secureStorage = FlutterSecureStorage();
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      child: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: SafeArea(
          bottom: true,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  "환영합니다.",
                  style: TextStyle(fontSize: 34, fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  height: 16,
                ),
                const Text(
                  "이메일과 비밀번호를 입력해서 로그인해주세요\n오늘도 성공적인 주문이 되길 :)",
                  style: TextStyle(fontSize: 18, color: BODY_TEXT_COLOR),
                ),
                Image.asset(
                  'asset/img/misc/logo.png',
                  width: MediaQuery.of(context).size.width * 0.4,
                ),
                const SizedBox(
                  height: 16,
                ),
                CustomTextFormField(
                  hintText: "이메일",
                  onChanged: (String value) {
                    email = value;
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                CustomTextFormField(
                  hintText: "비밀번호",
                  obscureText: true,
                  onChanged: (String value) {
                    password = value;
                  },
                ),
                ElevatedButton(
                  onPressed: () async {
                    Codec<String, String> stringToBase64 = utf8.fuse(base64);

                    String token = stringToBase64.encode('$email:$password');

                    final resp = await dio.post(
                      "$IP/auth/login",
                      options: Options(
                        headers: {'authorization': 'Basic $token'},
                      ),
                    );
                    print(resp.data);
                    final aToken = resp.data['accessToken'];
                    final rToken = resp.data['refreshToken'];

                    await secureStorage.write(key: ACCESS_TOKEN_KEY, value: aToken);
                    await secureStorage.write(key: REFRESH_TOKEN_KEY, value: rToken);
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (_) => const RootTab()));

                  },
                  child: Text("로그인"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: PRIMARY_COLOR,
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: Text("회원가입"),
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
