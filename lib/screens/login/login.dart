import 'dart:developer';

import 'package:custom_radio_grouped_button/custom_radio_grouped_button.dart';
// import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:htask/layout/cubit/app_cubit.dart';
import 'package:htask/layout/employee_layout/employee_layout.dart';
import 'package:htask/layout/supervisor_layout/supervisor_home_layout.dart';
import 'package:htask/screens/login/cubit/auth_cubit.dart';
import 'package:htask/screens/login/cubit/auth_states.dart';
import 'package:htask/screens/login/login_background.dart';
import 'package:htask/screens/login/login_widgets/auth_fields_responsive.dart';
import 'package:htask/shared/constants.dart';
import 'package:htask/shared/constants/methods.dart';
import 'package:htask/shared/responsive/responsive.dart';
import 'package:htask/styles/colors.dart';
import 'package:htask/widgets/default_text_field.dart';
import 'package:htask/widgets/defulat_button.dart';
import 'package:easy_localization/easy_localization.dart' as localization;
import 'package:htask/widgets/svg_image_widget.dart';

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
      body: AllScreenResponsive(
        child: BlocProvider<AuthCubit>(
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
                              const AuthFieldsResponsive(),
                              // DefaultTextField(
                              //   hintText: 'Hotel_Code'.tr(),
                              //   isPassword: false,
                              //   controller: authCubit.loginHotelCodeController,
                              //   validator: authCubit.validateHotelCode,
                              // ),
                              const SizedBox(height: 20),
                              // const _AuthTypeImages(),
                              const SizedBox(height: 40),
                              // DefaultButton(
                              //     text: 'Login'.tr(),
                              //     loading: loading,
                              //     onPressed: () async {
                              //       if (authCubit.formKey.currentState!
                              //           .validate()) {
                              //         await AuthCubit.instance(context)
                              //             .login(context);
                              //       }
                              //     })
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
      ),
    );
  }

  Widget _logo() => Directionality(
        textDirection: TextDirection.ltr,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // const Spacer(),
            // const Spacer(),
            Image.asset('assets/images/logo.png', scale: 4.8),
            // const Spacer(),
          ],
        ),
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
              child: _buildAuthTypeWidget('assets/images/icons/supervisor.svg',
                  type: LoginAuthType.supervisor,
                  isSelected: selectedAuthType == LoginAuthType.supervisor,
                  displayTypeString: 'Supervisor'.tr()),
            ),
            Expanded(
              child: _buildAuthTypeWidget('assets/images/icons/employee.svg',
                  type: LoginAuthType.employee,
                  isSelected: selectedAuthType == LoginAuthType.employee,
                  displayTypeString: 'Employee'.tr()),
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
      return GestureDetector(
        onTap: () {
          AuthCubit.instance(context).changeSelectedAccountType(type);
        },
        child: Container(
          margin: const EdgeInsets.all(16),
          padding: const EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
            color: isSelected
                ? AppColors.darkPrimaryColor
                : Theme.of(context).canvasColor,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Text(
                  displayTypeString,
                  style: TextStyle(
                      color: isSelected
                          ? Colors.white
                          : AppColors.darkPrimaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
                Spacer(),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                  width: MediaQuery.of(context).size.width * 0.07,
                  child: SvgImageWidget(
                    path: imagePath,
                    color:
                        isSelected ? Colors.white : AppColors.darkPrimaryColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
