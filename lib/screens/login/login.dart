import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:htask/layout/main_layout.dart';
import 'package:htask/layout/supervisor_layout/supervisor_home_layout.dart';
import 'package:htask/screens/login/cubit/auth_cubit.dart';
import 'package:htask/screens/login/cubit/auth_states.dart';
import 'package:htask/screens/login/login_background.dart';
import 'package:htask/shared/constants.dart';
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
              navigateToReplacement(context, const SuperVisorHomeLayout());
              return;
              // Fluttertoast.showToast(
              //     msg: 'Successifully logged in',
              //     backgroundColor: AppColors.doneColor,
              //     gravity: ToastGravity.BOTTOM);
            } else if (state is ErrorLoginState) {
              // Fluttertoast.showToast(
              //     msg: state.errorMessage,
              //     backgroundColor: Colors.red,
              //     gravity: ToastGravity.SNACKBAR);
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
                              isPassword: true,
                              controller: authCubit.loginPasswordController,
                              validator: authCubit.validatePassword,
                            ),
                            const SizedBox(height: 20),
                            DefaultButton(
                                text: 'Login',
                                loading: loading,
                                onPressed: () async {
                                  if (authCubit.formKey.currentState!
                                      .validate()) {
                                    await AuthCubit.instance(context).login(
                                        context, LoginAuthType.supervisor);
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

  Image _logo() => Image.asset(
        'assets/images/logo.png',
        scale: 1.4,
      );
}
