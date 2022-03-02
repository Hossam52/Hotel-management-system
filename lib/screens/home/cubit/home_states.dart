abstract class HomeState {}

class InitialHomeState extends HomeState {}

class ChangeTabIndexState extends HomeState {}

class ChangeCategoryIndexState extends HomeState {}

class ChangeDateFilterState extends HomeState {}

//All orders
class LoadingAllOrdersHomeState extends HomeState {}

class SuccessAllOrdersHomeState extends HomeState {}

class ErrorAllOrdersHomeState extends HomeState {
  final String error;

  ErrorAllOrdersHomeState(this.error);
}

class LoadingNextAllOrdersHomeState extends HomeState {}

class SuccessNextAllOrdersHomeState extends HomeState {}

class ErrorNextAllOrdersHomeState extends HomeState {
  final String error;

  ErrorNextAllOrdersHomeState(this.error);
}

//All categories
class LoadingAllCategoriesHomeState extends HomeState {}

class SuccessAllCategoriesHomeState extends HomeState {}

class ErrorAllCategoriesHomeState extends HomeState {
  final String error;

  ErrorAllCategoriesHomeState(this.error);
}
