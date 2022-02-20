import 'dart:developer';

import 'package:custom_radio_grouped_button/custom_radio_grouped_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:htask/layout/cubit/app_cubit.dart';
import 'package:htask/layout/employee_layout/employee_layout.dart';
import 'package:htask/layout/supervisor_layout/supervisor_home_layout.dart';
import 'package:htask/screens/login/cubit/auth_cubit.dart';
import 'package:htask/screens/login/cubit/auth_states.dart';
import 'package:htask/screens/login/login_background.dart';
import 'package:htask/shared/constants.dart';
import 'package:htask/shared/constants/methods.dart';
import 'package:htask/styles/colors.dart';
import 'package:htask/widgets/default_text_field.dart';
import 'package:htask/widgets/defulat_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: AppColors.primaryColor,
      body: BlocProvider<AuthCubit>(
        create: (context) => AuthCubit(),
        lazy: false,
        child: BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is SuccessLoginState) {
              showSuccessToast('Login successifully');
              navigateToReplacement(context,
                  AppCubit.instance(context).homeLayout(state.authType));
            } else if (state is ErrorLoginState) {
              showErrorToast(state.errorMessage);
            }
          },
          builder: (context, state) {
            final AuthCubit authCubit = AuthCubit.instance(context);
            final loading = state is LoadingLoginState;

            return Stack(
              children: [
                const LoginBackground(),
                Form(
                  key: authCubit.formKey,
                  child: Center(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _logo(),
                            const SizedBox(
                              height: 40,
                            ),
                            DefaultTextField(
                              hintText: 'Email',
                              isPassword: false,
                              controller: authCubit.loginEmailController,
                              validator: authCubit.validateEmail,
                            ),
                            DefaultTextField(
                              hintText: 'Password',
                              passwordWidget: _passwordWidget(authCubit),
                              isPassword: authCubit.visiblePassword,
                              controller: authCubit.loginPasswordController,
                              validator: authCubit.validatePassword,
                            ),
                            const SizedBox(height: 20),
                            const _AuthTypeImages(),
                            const SizedBox(height: 40),
                            DefaultButton(
                                text: 'Login',
                                loading: loading,
                                onPressed: () async {
                                  if (authCubit.formKey.currentState!
                                      .validate()) {
                                    await AuthCubit.instance(context)
                                        .login(context);
                                  }
                                })
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _passwordWidget(AuthCubit authCubit) {
    return GestureDetector(
      onTap: () => authCubit.changeVisiblePassword(),
      child: Icon(
        authCubit.getPasswordIcon(),
      ),
    );
  }

  Widget _logo() => Row(
        children: [
          const Spacer(),
          const Spacer(),
          Image.asset('assets/images/logo.png', scale: 4.8),
          const Spacer(),
        ],
      );
}

class _AuthTypeImages extends StatelessWidget {
  const _AuthTypeImages({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        final selectedAuthType =
            AuthCubit.instance(context).selectedAccountType;
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: _buildAuthTypeWidget('assets/images/supervisor_image.png',
                  type: LoginAuthType.supervisor,
                  isSelected: selectedAuthType == LoginAuthType.supervisor,
                  displayTypeString: 'Supervisor'),
            ),
            Expanded(
              child: _buildAuthTypeWidget('assets/images/employee_image.png',
                  type: LoginAuthType.employee,
                  isSelected: selectedAuthType == LoginAuthType.employee,
                  displayTypeString: 'Employee'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildAuthTypeWidget(String imagePath,
      {required LoginAuthType type,
      required bool isSelected,
      required String displayTypeString}) {
    return Builder(builder: (context) {
      return Container(
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.darkPrimaryColor
              : Theme.of(context).canvasColor,
          borderRadius: BorderRadius.circular(30),
        ),
        child: GestureDetector(
          onTap: () {
            AuthCubit.instance(context).changeSelectedAccountType(type);
          },
          child: Row(
            children: [
              Text(
                displayTypeString,
                style: TextStyle(
                    color: isSelected ? Colors.white : Colors.black,
                    fontSize: 16),
              ),
              Expanded(
                child: SizedBox(
                  height: 56,
                  width: 56,
                  child: Image.asset(imagePath),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
