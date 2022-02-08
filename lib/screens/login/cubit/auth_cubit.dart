import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:htask/layout/cubit/app_cubit.dart';
import 'package:htask/models/person_login_model.dart';
import 'package:htask/screens/login/cubit/auth_states.dart';
import 'package:htask/shared/constants/api_constants.dart';
import 'package:htask/shared/network/services/employee_services.dart';
import 'package:htask/shared/network/services/supervisor_survices.dart';

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

  Future<void> login(BuildContext context, LoginAuthType auth) async {
    try {
      emit(LoadingLoginState());
      final personalProfile = await _callLoginApi(auth);
      log(personalProfile.toString());
      AppCubit.instance(context).setPersonalData(personalProfile, token);
      emit(SuccessLoginState());
    } catch (e) {
      emit(ErrorLoginState(errorMessage: e.toString()));
    }
  }

  Future<PersonLoginModel> _callLoginApi(LoginAuthType type) async {
    final loginRequestModel = EmployeeRequestModel(
        email: loginEmailController.text,
        password: loginPasswordController.text);
    if (type == LoginAuthType.employee) {
      final model = await EmployeeServices.login(loginRequestModel);
      token = model.token;
      return model.employee;
    } else if (type == LoginAuthType.supervisor) {
      final model = await SupervisorSurvices.login(loginRequestModel);
      token = model.token;
      return model.supervisor;
    } else {
      throw Exception('Un known type');
    }
  }
}
