import 'dart:developer';

import 'package:htask/models/categories/all_categories_model.dart';
import 'package:htask/models/categories/category_request_model.dart';
import 'package:htask/models/notifications/notification_model.dart';
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
      {CategoryRequestModel? requestModel}) async {
    final res = await DioHelper.postData(
        url: SupervisorApis.getOrders,
        token: token,
        data: requestModel == null ? {} : requestModel.toMap());
    log(res.toString());
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
    log(res.toString());
    AllEmployeesToAssign categoies = AllEmployeesToAssign.fromMap(res.data);
    return categoies;
  }

  static Future<AssignOrderToEmployee> assignEmployeeToOrder(
      String token, AssignOrderToEmployeeRequest request) async {
    final res = await DioHelper.postData(
        url: SupervisorApis.assignEmployeeToOrder,
        token: token,
        data: request.toMap());
    log(res.toString());
    AssignOrderToEmployee categoies = AssignOrderToEmployee.fromMap(res.data);
    return categoies;
  }

  static Future<SupervisorEmployeesModel> getMyEmployees(String token) async {
    final res = await DioHelper.getData(
      url: SupervisorApis.getMyEmployee,
      token: token,
    );
    log(res.toString());
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
    log(res.toString());
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
}
