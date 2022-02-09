import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:htask/layout/cubit/app_cubit.dart';
import 'package:htask/screens/login/cubit/auth_cubit.dart';
import 'package:htask/screens/order_details/cubit/order_details_states.dart';
import 'package:htask/shared/constants/api_constants.dart';
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
        throw Exception(res.message);
      }
      emit(SuccessChangeStatusToProcessState(message: res.message));
    } on Exception catch (e) {
      emit(ErrorChangeStatusToProcessState(e.toString()));
    }
  }

  Future<void> changeStatusToEnd(String token, int orderId) async {
    try {
      emit(LoadingChangeStatusToProcessState());
      final res = await SupervisorSurvices.changeStatusToEnd(token, orderId);
      if (!res.status) {
        throw Exception(res.message);
      }
      emit(SuccessChangeStatusToProcessState(message: res.message));
    } on Exception catch (e) {
      emit(ErrorChangeStatusToProcessState(e.toString()));
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
        throw Exception(res.message);
      }
      emit(SuccessChangeStatusToProcessState(message: res.message));
    } on Exception catch (e) {
      emit(ErrorChangeStatusToProcessState(e.toString()));
    }
  }

  Future<void> changeStatusToEnd(String token, int orderId) async {
    try {
      emit(LoadingChangeStatusToProcessState());
      final res = await EmployeeServices.changeStatusToEnd(token, orderId);
      if (!res.status) {
        throw Exception(res.message);
      }
      emit(SuccessChangeStatusToProcessState(message: res.message));
    } on Exception catch (e) {
      emit(ErrorChangeStatusToProcessState(e.toString()));
    }
  }
}
