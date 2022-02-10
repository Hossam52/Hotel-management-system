abstract class StaffStates {}

class InitalStaffState extends StaffStates {}

//Get all employees to assign

class LoadingAllEmployeesToAssignStaffState extends StaffStates {}

class SuccessAllEmployeesToAssignStaffState extends StaffStates {}

class ErrorllEmployeesToAssignStaffState extends StaffStates {
  final String error;

  ErrorllEmployeesToAssignStaffState(this.error);
}
