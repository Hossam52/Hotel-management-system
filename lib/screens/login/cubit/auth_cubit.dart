import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:htask/layout/cubit/app_cubit.dart';
import 'package:htask/models/logout_model.dart';
import 'package:htask/models/person_login_model.dart';
import 'package:htask/screens/login/cubit/auth_states.dart';
import 'package:htask/screens/login/login.dart';
import 'package:htask/shared/constants.dart';
import 'package:htask/shared/constants/api_constants.dart';
import 'package:htask/shared/constants/methods.dart';
import 'package:htask/shared/network/services/employee_services.dart';
import 'package:htask/shared/network/services/supervisor_survices.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

enum LoginAuthType { supervisor, employee }

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(InitialAuthState());
  static AuthCubit instance(BuildContext context) =>
      BlocProvider.of<AuthCubit>(context);

  final formKey = GlobalKey<FormState>();
  final loginEmailController = TextEditingController();
  final loginPasswordController = TextEditingController();

  bool visiblePassword = false;
  late String token;

  LoginAuthType? selectedAccountType = LoginAuthType.employee;
  void changeVisiblePassword() {
    visiblePassword = !visiblePassword;
    emit(ChangeVisiblePasswordState());
  }

  IconData getPasswordIcon() {
    if (visiblePassword) {
      return Icons.visibility;
    } else {
      return Icons.visibility_off;
    }
  }

  String? validateEmail(String? input) {
    final val = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(input!);
    if (input.isEmpty) {
      return 'Email cannot be empty';
    } else if (!val) {
      return 'Email is not correct';
    } else {
      return null;
    }
  }

  String? validatePassword(String? input) {
    if (input!.isEmpty) {
      return 'Password field cannot be empty';
    } else {
      return null;
    }
  }

  Future<void> login(BuildContext context) async {
    try {
      emit(LoadingLoginState());
      if (selectedAccountType == null) {
        emit(ErrorLoginState(errorMessage: 'Account type not selected'));
        return;
      }
      final personalProfile = await _callLoginApi();
      log(personalProfile.toString());
      await AppCubit.instance(context)
          .setPersonalData(personalProfile, token, selectedAccountType!);
      emit(SuccessLoginState(selectedAccountType!));
    } catch (e) {
      emit(ErrorLoginState(errorMessage: e.toString()));
    }
  }

  Future<PersonLoginModel> _callLoginApi() async {
    final deviceToken = await getDeviceToken;
    final loginRequestModel = EmployeeRequestModel(
        email: loginEmailController.text,
        password: loginPasswordController.text,
        mobileToken: deviceToken!);
    if (selectedAccountType == LoginAuthType.employee) {
      final model = await EmployeeServices.login(loginRequestModel);
      token = model.token;
      return model.employee;
    } else if (selectedAccountType == LoginAuthType.supervisor) {
      final model = await SupervisorSurvices.login(loginRequestModel);
      token = model.token;
      return model.supervisor;
    } else {
      throw Exception('Un known type');
    }
  }

  Future<void> logout(BuildContext context) async {
    final token = AppCubit.instance(context).token;
    final authType = AppCubit.instance(context).currentUserType!;

    try {
      emit(LoadingLogoutState());

      final res = await _callLogoutApi(authType, token);

      if (res.status) {
        await AppCubit.instance(context).removeAllStoredDataInCache();
        emit(SuccessLogoutState(res.message));
        navigateToReplacement(context, const LoginScreen());
      } else {
        throw Exception(res.message);
      }
    } catch (e) {
      emit(ErrorLogoutState(e.toString()));
    }
  }

  Future<LogoutModel> _callLogoutApi(
      LoginAuthType authType, String accessToken) async {
    if (authType == LoginAuthType.employee) {
      return await EmployeeServices.logout(accessToken);
    } else if (authType == LoginAuthType.supervisor) {
      return await SupervisorSurvices.logout(accessToken);
    } else {
      throw Exception('Unknown type');
    }
  }

  void changeSelectedAccountType(LoginAuthType auth) {
    selectedAccountType = auth;
    emit(ChangeSelectedAccountTypeState());
  }
}
