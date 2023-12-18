import 'package:flutter/material.dart';

import '../const/colors.dart';

class CustomTextFormField extends StatelessWidget {
  final String? errorText;
  final String? hintText;
  final bool obscureText;
  final bool autofocus;
  final ValueChanged<String>? onChanged;

  const CustomTextFormField({
    super.key,
    this.obscureText = false,
    this.autofocus = false,
    required this.onChanged,
    this.errorText,
    this.hintText,
  });

  final baseBorder = const OutlineInputBorder(
    borderSide: BorderSide(color: INPUT_BORDER_COLOR, width: 1.0),
  );

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText,
      autofocus: autofocus,
      onChanged: onChanged,
      cursorColor: PRIMARY_COLOR,
      decoration: InputDecoration(
        hintText: hintText,
        errorText: errorText,
        border: baseBorder,
        fillColor: INPUT_BG_COLOR,
        filled: true,
        focusColor: PRIMARY_COLOR,
        focusedBorder: baseBorder.copyWith(
          borderSide: const BorderSide(color: PRIMARY_COLOR),
        ),
      ),
    );
  }
}
