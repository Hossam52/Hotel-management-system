abstract class StaffStates {}

class InitalStaffState extends StaffStates {}

//Get all employees to assign

class LoadingAllEmployeesToAssignStaffState extends StaffStates {}

class SuccessAllEmployeesToAssignStaffState extends StaffStates {}

class ErrorllEmployeesToAssignStaffState extends StaffStates {
  final String error;

  ErrorllEmployeesToAssignStaffState(this.error);
}

//Get my employees
class LoadingMyEmployeesStaffState extends StaffStates {}

class SuccessMyEmployeesStaffState extends StaffStates {}

class ErrorMyEmployeesStaffState extends StaffStates {
  final String error;

  ErrorMyEmployeesStaffState(this.error);
}

//Change employee status
class ChangingEmployeeStatus extends StaffStates {}

class SuccessChangingEmployeeStatus extends StaffStates {
  final String message;

  SuccessChangingEmployeeStatus(this.message);
}

class ErrorChangingEmployeeStatus extends StaffStates {
  final String error;

  ErrorChangingEmployeeStatus(this.error);
}
