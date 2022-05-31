abstract class EmployeeStates {}

class InitialEmployeeState extends EmployeeStates {}

class ChangeSelectedEmployeeTabState extends EmployeeStates {}

//GetCashCounter online fetch data
class GetCashCounterLoadingState extends EmployeeStates {}

class GetCashCounterSuccessState extends EmployeeStates {}

class GetCashCounterErrorState extends EmployeeStates {
  final String error;
  GetCashCounterErrorState({required this.error});
}
