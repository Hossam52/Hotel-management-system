abstract class OrderDetailsState {}

class IntitalOrderDetailsState extends OrderDetailsState {}

//--- For change order to process
class LoadingChangeStatusToProcessState extends OrderDetailsState {}

class SuccessChangeStatusToProcessState extends OrderDetailsState {
  String message;
  SuccessChangeStatusToProcessState({
    required this.message,
  });
}

// class ErrorChangeStatusToProcessState extends OrderDetailsState {
//   final String error;

//   ErrorChangeStatusToProcessState(this.error);
// }

class ErrorOrderState extends OrderDetailsState {
  final String error;

  ErrorOrderState(this.error);
}

//For change assignment

class ChangingEmployeeassignmentState extends OrderDetailsState {}

class SuccessChangingEmployeeassignmentState extends OrderDetailsState {
  String message;
  SuccessChangingEmployeeassignmentState({
    required this.message,
  });
}

class ErrorChangingEmployeeassignmentState extends OrderDetailsState {
  final String error;

  ErrorChangingEmployeeassignmentState(this.error);
}
