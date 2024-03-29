import 'dart:developer';

import 'package:htask/models/categories/all_categories_model.dart';
import 'package:htask/models/categories/category_request_model.dart';
import 'package:htask/models/notifications/delete_notification_model.dart';
import 'package:htask/models/notifications/notification_model.dart';
import 'package:htask/models/notifications/read_notifications.dart';
import 'package:htask/models/orders/change_order_status.dart';
import 'package:htask/models/person_login_model.dart';
import 'package:htask/models/logout_model.dart';
import 'package:htask/models/orders/all_orders_statueses_model.dart';
import 'package:htask/models/supervisor/all_employees_to_assign.dart';
import 'package:htask/models/supervisor/assign_order_to_employee.dart';
import 'package:htask/models/supervisor/supervisor_employees/change_employee_status.dart';
import 'package:htask/models/supervisor/supervisor_employees/supervisor_employees_model.dart';
import 'package:htask/models/supervisor/supervisor_login.dart';
import 'package:htask/screens/staff/assign_staff_employee_to_order.dart';
import 'package:htask/shared/constants/api_constants.dart';
import 'package:htask/shared/network/remote/dio_helper.dart';

class SupervisorSurvices {
  static Future<SupervisorLoginModel> login(EmployeeRequestModel model) async {
    final res = await DioHelper.postData(
        url: SupervisorApis.login, data: model.toMap());

    SupervisorLoginModel emp = SupervisorLoginModel.fromMap(res.data);
    if (emp.status) log('token ${emp.token}');
    return emp;
  }

  static Future<LogoutModel> logout(String token) async {
    final res = await DioHelper.postData(
        url: SupervisorApis.logout, token: token, data: {});
    LogoutModel logoutModel = LogoutModel.fromMap(res.data);
    if (logoutModel.status) log('token exit sucessifully');
    return logoutModel;
  }

  static Future<AllOrderStatusesModel> getOrders(String token,
      {required String orderType,
      int? page,
      CategoryRequestModel? requestModel}) async {
    final Map<String, dynamic> requestedMap = {'status': orderType};
    if (requestModel != null) {
      requestedMap.addAll(requestModel.toMap());
    }
    final res = await DioHelper.postData(
      url: SupervisorApis.getOrders,
      token: token,
      query: {'page': page},
      data: requestedMap,
    );

    AllOrderStatusesModel allOrders = AllOrderStatusesModel.fromMap(res.data);
    return allOrders;
  }

  static Future<AllOrderStatusesModel> getNextOrderPage(String token, int page,
      {CategoryRequestModel? requestModel}) async {
    final res = await DioHelper.postData(
        url: EmployeeApis.getOrders,
        token: token,
        query: {'page': page},
        data: requestModel == null ? {} : requestModel.toMap());
    AllOrderStatusesModel allOrders = AllOrderStatusesModel.fromMap(res.data);
    return allOrders;
  }

  static Future<ChangeOrderStatusModel> changeStatusToProcess(
      String token, int orderId) async {
    final res = await DioHelper.postData(
        url: SupervisorApis.changeStatusToProcess,
        token: token,
        data: {'order_id': orderId});
    ChangeOrderStatusModel status = ChangeOrderStatusModel.fromMap(res.data);
    return status;
  }

  static Future<ChangeOrderStatusModel> changeStatusToEnd(
      String token, int orderId) async {
    final res = await DioHelper.postData(
        url: SupervisorApis.changeStatusToEnd,
        token: token,
        data: {'order_id': orderId});
    ChangeOrderStatusModel status = ChangeOrderStatusModel.fromMap(res.data);
    return status;
  }

  static Future<AllCategoriesModel> getAllCategories(String token) async {
    final res = await DioHelper.getData(
      url: SupervisorApis.getAuthCategory,
      token: token,
    );
    AllCategoriesModel categoies = AllCategoriesModel.fromMap(res.data);
    return categoies;
  }

  static Future<AllEmployeesToAssign> getAllEmployees(
      String token, GetAvaEmployeesRequest request) async {
    log(request.toMap().toString());
    final res = await DioHelper.postData(
        url: SupervisorApis.getAvaEmployee,
        token: token,
        data: request.toMap());

    AllEmployeesToAssign categoies = AllEmployeesToAssign.fromMap(res.data);
    return categoies;
  }

  static Future<AssignOrderToEmployee> assignEmployeeToOrder(
      String token, AssignOrderToEmployeeRequest request) async {
    final res = await DioHelper.postData(
        url: SupervisorApis.assignEmployeeToOrder,
        token: token,
        data: request.toMap());

    AssignOrderToEmployee categoies = AssignOrderToEmployee.fromMap(res.data);
    return categoies;
  }

  static Future<SupervisorEmployeesModel> getMyEmployees(String token) async {
    final res = await DioHelper.getData(
      url: SupervisorApis.getMyEmployee,
      token: token,
    );

    SupervisorEmployeesModel categoies =
        SupervisorEmployeesModel.fromMap(res.data);
    return categoies;
  }

  static Future<ChangeEmployeeStatusModel> changeEmployeeStatus(
      String token, int id) async {
    final res = await DioHelper.postData(
        url: SupervisorApis.changeEmployeeStatus,
        token: token,
        data: {'employee_id': id});

    ChangeEmployeeStatusModel employeeStatusModel =
        ChangeEmployeeStatusModel.fromMap(res.data);
    return employeeStatusModel;
  }

  static Future<NotificationsModel> getAllNotifications(String token) async {
    final res = await DioHelper.getData(
        url: SupervisorApis.getNotifications, token: token);
    NotificationsModel status = NotificationsModel.fromJson(res.data);
    return status;
  }

  static Future<NotificationsModel> getNextNotificationPage(
      String token, int nextPage) async {
    final res = await DioHelper.getData(
        url: SupervisorApis.getNotifications,
        token: token,
        query: {'page': nextPage});
    NotificationsModel status = NotificationsModel.fromJson(res.data);
    log('${status.notifications!.meta}');
    return status;
  }

  static Future<DeleteNotifyResponse> deleteNotification(
      String token, DeleteNotifyRequest notificationRequest) async {
    final res = await DioHelper.postData(
        url: SupervisorApis.deleteNotification,
        token: token,
        data: notificationRequest.toMap());
    log(res.data.toString());
    DeleteNotifyResponse status = DeleteNotifyResponse.fromMap(res.data);
    return status;
  }

  static Future<ReadNotificationsModelResponse> readNotifications(
      String token) async {
    final res = await DioHelper.getData(
      url: SupervisorApis.readNotifications,
      token: token,
    );
    ReadNotificationsModelResponse status =
        ReadNotificationsModelResponse.fromMap(res.data);
    return status;
  }
}
