import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:htask/layout/cubit/app_states.dart';
import 'package:htask/layout/employee_layout/employee_layout.dart';
import 'package:htask/layout/supervisor_layout/supervisor_home_layout.dart';
import 'package:htask/models/person_login_model.dart';
import 'package:htask/screens/login/cubit/auth_cubit.dart';
import 'package:htask/screens/login/login.dart';
import 'package:htask/shared/constants/constants.dart';
import 'package:htask/shared/network/local/cache_helper.dart';

enum Language { arabic, english }

extension LanguageString on Language {
  String get getString {
    switch (this) {
      case Language.arabic:
        return 'Arabic'.tr();

      case Language.english:
        return 'English'.tr();

      default:
        return '';
    }
  }
}

class AppCubit extends Cubit<AppState> {
  AppCubit(Locale _currentLocale) : super(InitalAppState()) {
    _changeLocale(_currentLocale);
  }
  static AppCubit instance(BuildContext context) =>
      BlocProvider.of<AppCubit>(context);
  LoginAuthType? currentUserType;
  bool get isEmployeeType =>
      currentUserType == LoginAuthType.employee ? true : false;
  bool get isSupervisorType =>
      currentUserType == LoginAuthType.supervisor ? true : false;
  void _changeLocale(Locale locale) {
    if (locale.languageCode == const Locale('ar', 'EG').languageCode) {
      lang = 'ar';
      language = Language.arabic;
    } else if (locale.languageCode == const Locale('en', 'US').languageCode) {
      lang = 'en';
      language = Language.english;
    } else {
      lang = 'en';
      language = Language.english;
    }
  }

  Language language = Language.english;
  void changeLanguage(BuildContext context, Locale newLocale) {
    _changeLocale(newLocale);
    context.setLocale(newLocale);
    emit(ChangeAppLanguage());
  }

  PersonLoginModel? _personalData;
  String get currency => _personalData!.currency;
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

  bool showingOrderNotificationScreen = false;
  void currentShowingOrderNotificationScreen() {
    showingOrderNotificationScreen = true;
    emit(OpenNotificationScreen());
  }

  void closeOrderNotificationScreen() {
    showingOrderNotificationScreen = false;
    emit(CloseNotificationScreen());
  }

  Future<void> _storeProfileInCache(PersonLoginModel data) async {
    await CacheHelper.saveData(key: 'id', value: data.id);
    await CacheHelper.saveData(key: 'name', value: data.name);
    await CacheHelper.saveData(key: 'email', value: data.email);
    await CacheHelper.saveData(
        key: 'orderCashPrice', value: data.orderCashPrice);
    await CacheHelper.saveData(key: 'image', value: data.image);
    await CacheHelper.saveData(key: 'hotel', value: data.hotel);
    await CacheHelper.saveData(key: 'currency', value: data.currency);
    await CacheHelper.saveData(key: 'hotel_logo', value: data.hotel_logo);
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
    int orderCashPrice = CacheHelper.getData(key: 'orderCashPrice');
    String image = CacheHelper.getData(key: 'image');
    String hotel = CacheHelper.getData(key: 'hotel');
    String currency = CacheHelper.getData(key: 'currency');
    String hotel_logo = CacheHelper.getData(key: 'hotel_logo');

    return PersonLoginModel(
      id: id,
      name: name,
      email: email,
      orderCashPrice: orderCashPrice,
      image: image,
      hotel: hotel,
      currency: currency,
      hotel_logo: hotel_logo,
    );
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
