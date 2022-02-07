import 'package:flutter/material.dart';
import 'package:htask/layout/main_layout.dart';
import 'package:htask/layout/supervisor_layout/supervisor_home_layout.dart';
import 'package:htask/screens/home/home.dart';
import 'package:htask/screens/login/login_background.dart';
import 'package:htask/shared/constants.dart';
import 'package:htask/styles/colors.dart';
import 'package:htask/widgets/default_text_field.dart';
import 'package:htask/widgets/defulat_button.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: AppColors.primaryColor,
      body: Stack(
        children: [
          const LoginBackground(),
          Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _logo(),
                    const SizedBox(
                      height: 40,
                    ),
                    DefaultTextField(
                      hintText: 'Email',
                      isPassword: false,
                      controller: TextEditingController(),
                    ),
                    DefaultTextField(
                      hintText: 'Password',
                      isPassword: true,
                      controller: TextEditingController(),
                    ),
                    const SizedBox(height: 20),
                    DefaultButton(
                        text: 'Login',
                        onPressed: () async {
                          await navigateTo(
                              context, const SuperVisorHomeLayout());
                        })
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Image _logo() => Image.asset(
        'assets/images/logo.png',
        scale: 1.4,
      );
}
