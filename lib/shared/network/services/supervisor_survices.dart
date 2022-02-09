import 'dart:developer';

import 'package:htask/models/orders/change_order_status.dart';
import 'package:htask/models/person_login_model.dart';
import 'package:htask/models/logout_model.dart';
import 'package:htask/models/orders/all_orders_statueses_model.dart';
import 'package:htask/models/supervisor/supervisor_login.dart';
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

  static Future<AllOrderStatusesModel> getOrders(String token) async {
    final res = await DioHelper.postData(
        url: SupervisorApis.getOrders, token: token, data: {});
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
        url: SupervisorApis.changeStatusToProcess,
        token: token,
        data: {'order_id': orderId});
    ChangeOrderStatusModel status = ChangeOrderStatusModel.fromMap(res.data);
    return status;
  }
}
