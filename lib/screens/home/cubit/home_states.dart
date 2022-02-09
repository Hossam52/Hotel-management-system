abstract class HomeState {}

class InitialHomeState extends HomeState {}

class ChangeTabIndexState extends HomeState {}

class LoadingAllOrdersHomeState extends HomeState {}

class SuccessAllOrdersHomeState extends HomeState {}

class ErrorAllOrdersHomeState extends HomeState {
  final String error;

  ErrorAllOrdersHomeState(this.error);
}
