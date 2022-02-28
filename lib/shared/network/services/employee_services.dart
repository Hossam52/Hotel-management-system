import 'dart:developer';

import 'package:htask/models/Employee/employee_login_model.dart';
import 'package:htask/models/categories/category_request_model.dart';
import 'package:htask/models/notifications/notification_model.dart';
import 'package:htask/models/orders/change_order_status.dart';
import 'package:htask/models/person_login_model.dart';
import 'package:htask/models/logout_model.dart';
import 'package:htask/models/orders/all_orders_statueses_model.dart';
import 'package:htask/shared/constants/api_constants.dart';
import 'package:htask/shared/network/remote/dio_helper.dart';

class EmployeeServices {
  static Future<EmployeeLoginModel> login(EmployeeRequestModel model) async {
    final res =
        await DioHelper.postData(url: EmployeeApis.login, data: model.toMap());
    log(res.statusCode!.toString());
    EmployeeLoginModel emp = EmployeeLoginModel.fromMap(res.data);
    if (emp.status) log('token ${emp.token}');
    return emp;
  }

  static Future<LogoutModel> logout(String token) async {
    final res = await DioHelper.postData(
        url: EmployeeApis.logout, token: token, data: {});
    LogoutModel logoutModel = LogoutModel.fromMap(res.data);
    if (logoutModel.status) log('token exit sucessifully');
    return logoutModel;
  }

  static Future<AllOrderStatusesModel> getOrders(String token,
      {CategoryRequestModel? requestModel}) async {
    final res = await DioHelper.postData(
        url: EmployeeApis.getOrders,
        token: token,
        data: requestModel == null ? {} : requestModel.toMap());
    AllOrderStatusesModel allOrders = AllOrderStatusesModel.fromMap(res.data);
    return allOrders;
  }

  static Future<ChangeOrderStatusModel> changeStatusToProcess(
      String token, int orderId) async {
    final res = await DioHelper.postData(
        url: EmployeeApis.changeStatusToProcess,
        token: token,
        data: {'order_id': orderId});
    ChangeOrderStatusModel status = ChangeOrderStatusModel.fromMap(res.data);
    return status;
  }

  static Future<ChangeOrderStatusModel> changeStatusToEnd(
      String token, int orderId) async {
    final res = await DioHelper.postData(
        url: EmployeeApis.changeStatusToEnd,
        token: token,
        data: {'order_id': orderId});
    ChangeOrderStatusModel status = ChangeOrderStatusModel.fromMap(res.data);
    return status;
  }

  static Future<NotificationsModel> getAllNotifications(String token) async {
    final res = await DioHelper.getData(
        url: EmployeeApis.getNotifications, token: token);
    NotificationsModel status = NotificationsModel.fromJson(res.data);
    return status;
  }
}
