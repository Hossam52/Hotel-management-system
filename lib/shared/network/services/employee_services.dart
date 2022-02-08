import 'dart:developer';

import 'package:htask/models/Employee/employee_login_model.dart';
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

  static Future<AllOrderStatusesModel> getOrders(String token) async {
    final res =
        await DioHelper.getData(url: EmployeeApis.getOrders, token: token);
    AllOrderStatusesModel allOrders = AllOrderStatusesModel.fromMap(res.data);
    return allOrders;
  }

  static Future<AllOrderStatusesModel> changeStatusToProcess(
      String token, int orderId) async {
    final res = await DioHelper.postData(
        url: EmployeeApis.changeStatusToProcess, token: token, data: {});
    AllOrderStatusesModel allOrders = AllOrderStatusesModel.fromMap(res.data);
    return allOrders;
  }

  static Future<AllOrderStatusesModel> changeStatusToEnd(
      String token, int orderId) async {
    final res = await DioHelper.postData(
        url: EmployeeApis.changeStatusToProcess, token: token, data: {});
    AllOrderStatusesModel allOrders = AllOrderStatusesModel.fromMap(res.data);
    return allOrders;
  }
}
