import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:htask/layout/cubit/app_states.dart';
import 'package:htask/layout/employee_layout/employee_layout.dart';
import 'package:htask/layout/supervisor_layout/supervisor_home_layout.dart';
import 'package:htask/models/person_login_model.dart';
import 'package:htask/screens/login/cubit/auth_cubit.dart';
import 'package:htask/screens/login/login.dart';
import 'package:htask/shared/network/local/cache_helper.dart';

enum Language { arabic, english }

extension LanguageString on Language {
  String get getString {
    switch (this) {
      case Language.arabic:
        return 'Arabic';

      case Language.english:
        return 'English';

      default:
        return '';
    }
  }
}

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(InitalAppState());
  static AppCubit instance(BuildContext context) =>
      BlocProvider.of<AppCubit>(context);
  LoginAuthType? currentUserType;

  Language language = Language.english;
  void changeLanguage(Language language) {
    this.language = language;
    emit(ChangeAppLanguage());
  }

  PersonLoginModel? _personalData;
  late String token;
  PersonLoginModel get getProfile => _personalData!;
  Future<void> setPersonalData(
      PersonLoginModel data, String token, LoginAuthType loginAuthType) async {
    _personalData = data;
    currentUserType = loginAuthType;
    this.token = token;
    await CacheHelper.saveData(key: 'token', value: token);
    await CacheHelper.saveData(
        key: 'loginAuthType', value: loginAuthType.toString());
    await _storeProfileInCache(data);
    log('Done Storing data');
  }

  Future<void> _storeProfileInCache(PersonLoginModel data) async {
    await CacheHelper.saveData(key: 'id', value: data.id);
    await CacheHelper.saveData(key: 'name', value: data.name);
    await CacheHelper.saveData(key: 'email', value: data.email);
    await CacheHelper.saveData(key: 'image', value: data.image);
  }

  void changeAuthType(LoginAuthType? authType) {
    currentUserType = authType;
    emit(ChangeAuthTypeState());
  }

  Widget loginScreenOrHomeScreen() {
    final String? tokenFromDB = CacheHelper.getData(key: 'token');
    final String? loginAuthTypeString =
        CacheHelper.getData(key: 'loginAuthType');
    if (tokenFromDB != null && loginAuthTypeString != null) {
      // return LoginScreen();
      final loginAuthType = getAuthType(loginAuthTypeString);
      if (loginAuthType != null) {
        token = tokenFromDB;
        currentUserType = loginAuthType;
        _personalData = _getProfileFromCache();
        log(token);
        return homeLayout(loginAuthType);
      } else {
        return const LoginScreen();
      }
    } else {
      return const LoginScreen();
    }
  }

  LoginAuthType? getAuthType(String authTypeString) {
    if (authTypeString == LoginAuthType.employee.toString()) {
      return LoginAuthType.employee;
    } else if (authTypeString == LoginAuthType.supervisor.toString()) {
      return LoginAuthType.supervisor;
    } else {
      return null;
    }
  }

  PersonLoginModel _getProfileFromCache() {
    int id = CacheHelper.getData(key: 'id');
    String name = CacheHelper.getData(key: 'name');
    String email = CacheHelper.getData(key: 'email');
    String image = CacheHelper.getData(key: 'image');

    return PersonLoginModel(id: id, name: name, email: email, image: image);
  }

  Widget homeLayout(LoginAuthType loginAuthType) {
    if (loginAuthType == LoginAuthType.supervisor) {
      return const SuperVisorHomeLayout();
    } else if (loginAuthType == LoginAuthType.employee) {
      return const EmployeeLayout();
    } else {
      throw Exception('Unknown type');
    }
  }

  Future<void> removeAllStoredDataInCache() async {
    token = '';
    _personalData = null;
    currentUserType = null;
    await CacheHelper.sharedPreferences.clear();
  }
}
