import 'package:flutter/material.dart';
import 'package:flutter_deep_dive/common/components/custom_text_form_field.dart';
import 'package:flutter_deep_dive/common/const/colors.dart';
import 'package:flutter_deep_dive/common/layout/default_layout.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            "환영합니다.",
            style: TextStyle(fontSize: 34, fontWeight: FontWeight.w500),
          ),
          SizedBox(height: 16,),
          Text(
            "이메일과 비밀번호를 입력해서 로그인해주세요\n오늘도 성공적인 주문이 되길 :)",
            style: TextStyle(fontSize: 18, color: BODY_TEXT_COLOR),
          ),
          Image.asset(
            'asset/img/misc/logo.png',
            width: MediaQuery.of(context).size.width * 0.4,
          ),
          SizedBox(height: 16,),
          CustomTextFormField(
            hintText: "이메일",
            onChanged: (String value) {},
          ),
          SizedBox(height: 16,),
          CustomTextFormField(
            hintText: "비밀번호",
            obscureText: true,
            onChanged: (String value) {},
          ),
          ElevatedButton(
            onPressed: () {},
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
          )
        ],
      ),
    );
  }
}
