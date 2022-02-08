abstract class AuthState {}

class InitialAuthState extends AuthState {}

class ChangeVisiblePasswordState extends AuthState {}

//////Login states
class LoadingLoginState extends AuthState {}

class SuccessLoginState extends AuthState {}

class ErrorLoginState extends AuthState {
  String errorMessage;
  ErrorLoginState({
    required this.errorMessage,
  });
}
