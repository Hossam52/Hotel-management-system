abstract class NotificationStates {}

class InitialNotificationState extends NotificationStates {}

class LoadingNotificationState extends NotificationStates {}

class SuccessNotificationState extends NotificationStates {}

class ErrorNotificationState extends NotificationStates {
  final String error;
  ErrorNotificationState({
    required this.error,
  });
}

class LoadingMoreNotificationState extends NotificationStates {}

class SuccessMoreNotificationState extends NotificationStates {}

class ErrorMoreNotificationState extends NotificationStates {
  final String error;
  ErrorMoreNotificationState({
    required this.error,
  });
}
