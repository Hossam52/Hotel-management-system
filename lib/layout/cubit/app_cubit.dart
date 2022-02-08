import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:htask/layout/cubit/app_states.dart';
import 'package:htask/models/person_login_model.dart';
import 'package:htask/screens/login/cubit/auth_cubit.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(InitalAppState());
  static AppCubit instance(BuildContext context) =>
      BlocProvider.of<AppCubit>(context);
  LoginAuthType? currentUserType = LoginAuthType.supervisor;
  PersonLoginModel? _personalData;
  late String token;
  PersonLoginModel get getProfile => _personalData!;
  void setPersonalData(PersonLoginModel data, String token) {
    _personalData = data;
    this.token = token;
  }

  void changeAuthType(LoginAuthType? authType) {
    currentUserType = authType;
    emit(ChangeAuthTypeState());
  }
}
