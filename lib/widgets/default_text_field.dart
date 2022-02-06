import 'package:flutter/material.dart';
import 'package:htask/styles/colors.dart';

class DefaultTextField extends StatelessWidget {
  const DefaultTextField(
      {Key? key,
      required this.hintText,
      required this.isPassword,
      required this.controller})
      : super(key: key);
  final String hintText;
  final bool isPassword;
  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: controller,
          obscureText: isPassword,
          decoration: InputDecoration(
              hintText: hintText,
              filled: true,
              fillColor: AppColors.white,
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none)),
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
