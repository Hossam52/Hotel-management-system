abstract class NotificationStates {}

class ChangeSelectedNotification extends NotificationStates {
  int selectedId;
  ChangeSelectedNotification({
    required this.selectedId,
  });
}

class SelectAllNotifications extends NotificationStates {}

class DeSelectAllNotifications extends NotificationStates {}

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

class LoadingDeleteNotificationState extends NotificationStates {}

class SuccessDeleteNotificationState extends NotificationStates {}

class ErrorDeleteNotificationState extends NotificationStates {
  final String error;
  ErrorDeleteNotificationState({
    required this.error,
  });
}

class LoadingReadNotificationState extends NotificationStates {}

class SuccessReadNotificationState extends NotificationStates {}

class ErrorReadNotificationState extends NotificationStates {
  final String error;
  ErrorReadNotificationState({
    required this.error,
  });
}
