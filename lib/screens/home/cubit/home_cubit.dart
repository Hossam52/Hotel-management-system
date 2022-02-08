import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:htask/layout/cubit/app_cubit.dart';
import 'package:htask/models/orders/all_orders_statueses_model.dart';
import 'package:htask/screens/home/cubit/home_states.dart';
import 'package:htask/screens/login/cubit/auth_cubit.dart';
import 'package:htask/shared/network/services/employee_services.dart';
import 'package:htask/shared/network/services/supervisor_survices.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(InitialHomeState());
  static HomeCubit instance(BuildContext context) =>
      BlocProvider.of<HomeCubit>(context);

  late AllOrderStatusesModel allOrders;

  Future<void> getAllOrders(BuildContext context) async {
    final loginAuthType = AppCubit.instance(context).currentUserType;
    final token = AppCubit.instance(context).token;
    try {
      emit(LoadingAllOrdersHomeState());
      allOrders = await _callApiToGetOrders(loginAuthType!, token);
      emit(SuccessAllOrdersHomeState());
    } on Exception catch (e) {
      emit(ErrorAllOrdersHomeState(e.toString()));
    }
  }

  Future<AllOrderStatusesModel> _callApiToGetOrders(
      LoginAuthType authType, String token) async {
    if (authType == LoginAuthType.employee) {
      return await EmployeeServices.getOrders(token);
    }
    if (authType == LoginAuthType.supervisor) {
      return await SupervisorSurvices.getOrders(token);
    } else {
      throw Exception('Unknown type');
    }
  }
}
