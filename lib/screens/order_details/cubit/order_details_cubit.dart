import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:htask/layout/cubit/app_cubit.dart';
import 'package:htask/models/orders/order_model.dart';
import 'package:htask/models/supervisor/all_employees_to_assign.dart';
import 'package:htask/models/supervisor/assign_order_to_employee.dart';
import 'package:htask/screens/login/cubit/auth_cubit.dart';
import 'package:htask/screens/order_details/cubit/order_details_states.dart';
import 'package:htask/screens/staff/assign_staff_employee_to_order.dart';
import 'package:htask/shared/constants/api_constants.dart';
import 'package:htask/shared/constants/methods.dart';
import 'package:htask/shared/network/services/employee_services.dart';
import 'package:htask/shared/network/services/supervisor_survices.dart';

abstract class OrderDetailsCubit extends Cubit<OrderDetailsState> {
  OrderDetailsCubit() : super(IntitalOrderDetailsState());
  static OrderDetailsCubit instance(BuildContext context) =>
      BlocProvider.of(context);
  factory OrderDetailsCubit.getCurrentUserCubit(BuildContext context) {
    final authType = AppCubit.instance(context).currentUserType!;
    if (authType == LoginAuthType.employee) {
      return EmployeeOrderDetailsCubit();
    } else if (authType == LoginAuthType.supervisor) {
      return SupervisorOrderDetailsCubit();
    } else {
      throw Exception('Unknown type');
    }
  }
}

class SupervisorOrderDetailsCubit extends OrderDetailsCubit {
  static SupervisorOrderDetailsCubit instance(BuildContext context) =>
      BlocProvider.of(context);
  Future<void> changeStatusToProcess(String token, int orderId) async {
    try {
      emit(LoadingChangeStatusToProcessState());
      final res =
          await SupervisorSurvices.changeStatusToProcess(token, orderId);
      if (!res.status) {
        emit(ErrorOrderState(res.message));
        return;
      }
      emit(SuccessChangeStatusToProcessState(message: res.message));
    } catch (e) {
      emit(ErrorOrderState(e.toString()));
    }
  }

  Future<void> changeStatusToEnd(String token, int orderId) async {
    try {
      emit(LoadingChangeStatusToProcessState());
      final res = await SupervisorSurvices.changeStatusToEnd(token, orderId);
      if (!res.status) {
        emit(ErrorOrderState(res.message));
        return;
      }
      emit(SuccessChangeStatusToProcessState(message: res.message));
    } catch (e) {
      emit(ErrorOrderState(e.toString()));
    }
  }

  Future<void> changeAssignedEmployee(
      BuildContext context, OrderModel order) async {
    final token = AppCubit.instance(context).token;
    int seID = order.orderdetails.first.service_id;
    log(' ${order.roomId}  seID $seID');
    final employeeNum = await Navigator.of(context).push<int?>(
      MaterialPageRoute(
        builder: (_) => AssignStaffEmployeeToOrder(
          roomId: order.roomId,
          seID: seID,
        ),
      ),
    );
    if (employeeNum == null) {
      return;
    }
    try {
      emit(ChangingEmployeeassignmentState());
      final res = await SupervisorSurvices.assignEmployeeToOrder(
          token,
          AssignOrderToEmployeeRequest(
              orderId: order.id, employeeId: employeeNum.toInt()));
      if (res.status) showSuccessToast(res.message);
      emit(SuccessChangingEmployeeassignmentState(message: res.message));
    } catch (e) {
      emit(ErrorChangingEmployeeassignmentState(e.toString()));
    }
  }
}

class EmployeeOrderDetailsCubit extends OrderDetailsCubit {
  static EmployeeOrderDetailsCubit instance(BuildContext context) =>
      BlocProvider.of(context);
  Future<void> changeStatusToProcess(String token, int orderId) async {
    try {
      emit(LoadingChangeStatusToProcessState());
      final res = await EmployeeServices.changeStatusToProcess(token, orderId);
      if (!res.status) {
        emit(ErrorOrderState(res.message));
        return;
      }
      emit(SuccessChangeStatusToProcessState(message: res.message));
    } catch (e) {
      emit(ErrorOrderState(e.toString()));
    }
  }

  Future<void> changeStatusToEnd(String token, int orderId) async {
    try {
      emit(LoadingChangeStatusToProcessState());
      final res = await EmployeeServices.changeStatusToEnd(token, orderId);
      if (!res.status) {
        emit(ErrorOrderState(res.message));
        return;
      }
      emit(SuccessChangeStatusToProcessState(message: res.message));
    } catch (e) {
      emit(ErrorOrderState(e.toString()));
    }
  }
}
