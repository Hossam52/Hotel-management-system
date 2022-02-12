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
                            const _RadioButtonAccountType(),
                            const SizedBox(height: 20),
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

  Image _logo() => Image.asset(
        'assets/images/logo.png',
        scale: 1.4,
      );
}

class _RadioButtonAccountType extends StatelessWidget {
  const _RadioButtonAccountType({Key? key}) : super(key: key);
  final String supervisor = 'Supervisor';
  final String employee = 'Employee';
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {},
      buildWhen: (previous, current) =>
          current is ChangeSelectedAccountTypeState,
      builder: (context, state) {
        return CustomRadioButton(
          elevation: 0,
          unSelectedColor: Theme.of(context).canvasColor,
          enableShape: true,
          autoWidth: true,
          buttonLables: [
            supervisor,
            employee,
          ],
          buttonValues: [
            supervisor,
            employee,
          ],
          buttonTextStyle: const ButtonTextStyle(
              selectedColor: Colors.white,
              unSelectedColor: Colors.black,
              textStyle: TextStyle(fontSize: 16)),
          radioButtonValue: (value) {
            String val = value as String;
            if (val == employee) {
              AuthCubit.instance(context)
                  .changeSelectedAccountType(LoginAuthType.employee);
            } else if (val == supervisor) {
              AuthCubit.instance(context)
                  .changeSelectedAccountType(LoginAuthType.supervisor);
            } else {
              throw Exception('Unknown type');
            }
          },
          selectedColor: AppColors.darkPrimaryColor,
        );
      },
    );
  }
}
