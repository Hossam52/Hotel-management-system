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

class ErrorChangeStatusToProcessState extends OrderDetailsState {
  final String error;

  ErrorChangeStatusToProcessState(this.error);
}
