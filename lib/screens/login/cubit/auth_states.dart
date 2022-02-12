import 'package:htask/screens/login/cubit/auth_cubit.dart';

abstract class AuthState {}

class InitialAuthState extends AuthState {}

class ChangeVisiblePasswordState extends AuthState {}

class ChangeSelectedAccountTypeState extends AuthState {}

//////Login states
class LoadingLoginState extends AuthState {}

class SuccessLoginState extends AuthState {
  final LoginAuthType authType;

  SuccessLoginState(this.authType);
}

class ErrorLoginState extends AuthState {
  String errorMessage;
  ErrorLoginState({
    required this.errorMessage,
  });
}

//////logout states
class LoadingLogoutState extends AuthState {}

class SuccessLogoutState extends AuthState {
  final String message;

  SuccessLogoutState(this.message);
}

class ErrorLogoutState extends AuthState {
  final String error;

  ErrorLogoutState(this.error);
}
