///////////
const String BASE_URL = 'https://hotelstask.com/hotelTask/public/';

/////////////// Supervisor
abstract class SupervisorApis {
  static const String url = 'supervisor';
  static const String login = '$url/login';
  static const String logout = '$url/logout';
  static const String changeStatusToProcess = '$url/changeStatusToProcess';
  static const String changeStatusToEnd = '$url/changeStatusToEnd';
  static const String getOrders = '$url/getOrders';
  static const String getAuthCategory = '$url/getAuthCategory';
  static const String getAvaEmployee = '$url/getAvaEmployee';
  static const String assignEmployeeToOrder = '$url/AssignEmployeeToOrder';
  static const String getMyEmployee = '$url/getMyEmployee';
  static const String changeEmployeeStatus = '$url/changeEmployeeStatus';
  static const String getNotifications = '$url/getNotifications';
  static const String deleteNotification = '$url/deleteNotify';
  static const String readNotifications = '$url/readNotification';
}

/////////////// Employee
abstract class EmployeeApis {
  static const String url = 'employee';
  static const String login = '$url/login';

  static const String logout = '$url/logout';
  static const String employeeOrders = '$url/getOrders';
  static const String changeStatusToProcess = '$url/changeStatusToProcess';
  static const String changeStatusToEnd = '$url/changeStatusToEnd';
  static const String getOrders = '$url/getOrders';
  static const String getNotifications = '$url/getNotifications';
  static const String deleteNotification = '$url/deleteNotify';
  static const String readNotifications = '$url/readNotification';
}
